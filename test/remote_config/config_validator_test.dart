import 'package:flutter_test/flutter_test.dart';
import 'package:rcsr_app/core/constants/feature_keys.dart';
import 'package:rcsr_app/core/remote_config/data/mock_config_a.dart';
import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/remote_config/services/config_validator.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';

void main() {
  const validator = ConfigValidator();

  group('ConfigValidator', () {
    test('rejects rolloutPercentage less than 0', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.marketNewsCard: FeatureFlagConfig(
            key: FeatureKeys.marketNewsCard,
            enabled: true,
            killSwitch: false,
            rolloutPercentage: -1,
          ),
        },
      );

      final result = validator.validate(config);

      expect(result.isValid, isFalse);
      expect(result.errors.single, contains('between 0 and 100'));
    });

    test('rejects rolloutPercentage greater than 100', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.marketNewsCard: FeatureFlagConfig(
            key: FeatureKeys.marketNewsCard,
            enabled: true,
            killSwitch: false,
            rolloutPercentage: 101,
          ),
        },
      );

      final result = validator.validate(config);

      expect(result.isValid, isFalse);
      expect(result.errors.single, contains('between 0 and 100'));
    });

    test('rejects empty feature key', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.marketNewsCard: FeatureFlagConfig(
            key: '',
            enabled: true,
            killSwitch: false,
            rolloutPercentage: 20,
          ),
        },
      );

      final result = validator.validate(config);

      expect(result.isValid, isFalse);
      expect(result.errors, contains(AppStrings.featureKeyMustNotBeEmpty));
    });

    test('valid config passes', () {
      final result = validator.validate(mockConfigA);

      expect(result.isValid, isTrue);
      expect(result.errors, isEmpty);
    });

    test('invalid config does not crash and fails safely', () {
      const config = RemoteConfigModel(
        configVersion: 'test',
        environment: 'test',
        features: <String, FeatureFlagConfig>{
          FeatureKeys.quickInvestButton: FeatureFlagConfig(
            key: 'different_key',
            enabled: true,
            killSwitch: false,
            rolloutPercentage: 25,
          ),
        },
      );

      expect(() => validator.validate(config), returnsNormally);
      expect(validator.validate(config).isValid, isFalse);
    });
  });
}
