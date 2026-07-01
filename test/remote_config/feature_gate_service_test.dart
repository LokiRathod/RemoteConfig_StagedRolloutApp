import 'package:flutter_test/flutter_test.dart';
import 'package:rcsr_app/core/constants/feature_keys.dart';
import 'package:rcsr_app/core/remote_config/data/mock_config_a.dart';
import 'package:rcsr_app/core/remote_config/data/mock_config_b.dart';
import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/remote_config/services/config_validator.dart';
import 'package:rcsr_app/core/remote_config/services/feature_gate_service.dart';
import 'package:rcsr_app/core/remote_config/services/rollout_evaluator.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';

void main() {
  const service = FeatureGateService(
    rolloutEvaluator: RolloutEvaluator(),
    configValidator: ConfigValidator(),
  );

  group('FeatureGateService', () {
    test(
      'kill-switch disables feature even when enabled is true and rollout is 100',
      () {
        const config = RemoteConfigModel(
          configVersion: 'test',
          environment: 'test',
          features: <String, FeatureFlagConfig>{
            FeatureKeys.newPortfolioDashboard: FeatureFlagConfig(
              key: FeatureKeys.newPortfolioDashboard,
              enabled: true,
              killSwitch: true,
              rolloutPercentage: 100,
            ),
          },
        );

        final decision = service.evaluate(
          featureKey: FeatureKeys.newPortfolioDashboard,
          userId: 'user_123',
          config: config,
        );

        expect(decision.enabled, isFalse);
        expect(decision.reason, AppStrings.disabledByKillSwitch);
      },
    );

    test('enabled false disables feature', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.advancedChart: FeatureFlagConfig(
            key: FeatureKeys.advancedChart,
            enabled: false,
            killSwitch: false,
            rolloutPercentage: 100,
          ),
        },
      );

      final decision = service.evaluate(
        featureKey: FeatureKeys.advancedChart,
        userId: 'user_123',
        config: config,
      );

      expect(decision.enabled, isFalse);
      expect(decision.reason, AppStrings.disabledBecauseFeatureFlagIsOff);
    });

    test('unknown feature returns disabled safely', () {
      final decision = service.evaluate(
        featureKey: 'does_not_exist',
        userId: 'user_123',
        config: mockConfigA,
      );

      expect(decision.enabled, isFalse);
      expect(decision.reason, AppStrings.disabledSafelyUnknownFeature);
    });

    test('invalid rollout percentage disables safely', () {
      const invalidConfig = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.quickInvestButton: FeatureFlagConfig(
            key: FeatureKeys.quickInvestButton,
            enabled: true,
            killSwitch: false,
            rolloutPercentage: 150,
          ),
        },
      );

      final decision = service.evaluate(
        featureKey: FeatureKeys.quickInvestButton,
        userId: 'user_123',
        config: invalidConfig,
      );

      expect(decision.enabled, isFalse);
      expect(decision.reason, AppStrings.disabledSafelyInvalidConfig);
    });

    test('allowedUserIds enables user regardless of rollout', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.quickInvestButton: FeatureFlagConfig(
            key: FeatureKeys.quickInvestButton,
            enabled: true,
            killSwitch: false,
            rolloutPercentage: 0,
            allowedUserIds: <String>{'user_123'},
          ),
        },
      );

      final decision = service.evaluate(
        featureKey: FeatureKeys.quickInvestButton,
        userId: 'user_123',
        config: config,
      );

      expect(decision.enabled, isTrue);
      expect(decision.reason, AppStrings.enabledBecauseUserIsExplicitlyAllowed);
    });

    test('blockedUserIds disables user even if rollout allows', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.quickInvestButton: FeatureFlagConfig(
            key: FeatureKeys.quickInvestButton,
            enabled: true,
            killSwitch: false,
            rolloutPercentage: 100,
            blockedUserIds: <String>{'user_123'},
          ),
        },
      );

      final decision = service.evaluate(
        featureKey: FeatureKeys.quickInvestButton,
        userId: 'user_123',
        config: config,
      );

      expect(decision.enabled, isFalse);
      expect(decision.reason, AppStrings.disabledBecauseUserIsBlocked);
    });

    test('Config A and Config B produce different decisions', () {
      final configADecision = service.evaluate(
        featureKey: FeatureKeys.marketNewsCard,
        userId: 'user_123',
        config: mockConfigA,
      );
      final configBDecision = service.evaluate(
        featureKey: FeatureKeys.marketNewsCard,
        userId: 'user_123',
        config: mockConfigB,
      );

      expect(configADecision.enabled, isTrue);
      expect(configBDecision.enabled, isFalse);
      expect(configADecision.reason, isNot(configBDecision.reason));
    });

    test('decision reason is clear and explainable', () {
      final decision = service.evaluate(
        featureKey: FeatureKeys.marketNewsCard,
        userId: 'user_123',
        config: mockConfigA,
      );

      expect(decision.reason, contains('Enabled because user bucket'));
    });
  });
}
