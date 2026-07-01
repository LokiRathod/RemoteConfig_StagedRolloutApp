import 'package:rcsr_app/core/remote_config/models/feature_decision.dart';
import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/remote_config/services/config_validator.dart';
import 'package:rcsr_app/core/remote_config/services/rollout_evaluator.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';

class FeatureGateService {
  const FeatureGateService({
    required this.rolloutEvaluator,
    required this.configValidator,
  });

  final RolloutEvaluator rolloutEvaluator;
  final ConfigValidator configValidator;

  FeatureDecision evaluate({
    required String featureKey,
    required String userId,
    required RemoteConfigModel config,
  }) {
    final FeatureFlagConfig? featureConfig = config.features[featureKey];

    if (featureConfig == null) {
      return const FeatureDecision(
        featureKey: '',
        enabled: false,
        reason: AppStrings.disabledSafelyUnknownFeature,
        bucket: null,
        rolloutPercentage: 0,
        killSwitch: false,
      );
    }

    final validation = configValidator.validate(config);
    if (!validation.isValid) {
      return FeatureDecision(
        featureKey: featureKey,
        enabled: false,
        reason: AppStrings.disabledSafelyInvalidConfig,
        bucket: null,
        rolloutPercentage: featureConfig.rolloutPercentage,
        killSwitch: featureConfig.killSwitch,
        variant: featureConfig.variant,
      );
    }

    final bucket = rolloutEvaluator.bucketForUser(
      userId: userId,
      featureKey: featureKey,
    );

    // Kill-switch must always win so teams can stop exposure immediately.
    if (featureConfig.killSwitch) {
      return FeatureDecision(
        featureKey: featureKey,
        enabled: false,
        reason: AppStrings.disabledByKillSwitch,
        bucket: bucket,
        rolloutPercentage: featureConfig.rolloutPercentage,
        killSwitch: true,
        variant: featureConfig.variant,
      );
    }

    if (!featureConfig.enabled) {
      return FeatureDecision(
        featureKey: featureKey,
        enabled: false,
        reason: AppStrings.disabledBecauseFeatureFlagIsOff,
        bucket: bucket,
        rolloutPercentage: featureConfig.rolloutPercentage,
        killSwitch: false,
        variant: featureConfig.variant,
      );
    }

    if (featureConfig.blockedUserIds?.contains(userId) ?? false) {
      return FeatureDecision(
        featureKey: featureKey,
        enabled: false,
        reason: AppStrings.disabledBecauseUserIsBlocked,
        bucket: bucket,
        rolloutPercentage: featureConfig.rolloutPercentage,
        killSwitch: false,
        variant: featureConfig.variant,
      );
    }

    if (featureConfig.allowedUserIds?.contains(userId) ?? false) {
      return FeatureDecision(
        featureKey: featureKey,
        enabled: true,
        reason: AppStrings.enabledBecauseUserIsExplicitlyAllowed,
        bucket: bucket,
        rolloutPercentage: featureConfig.rolloutPercentage,
        killSwitch: false,
        variant: featureConfig.variant,
      );
    }

    final isInRollout = rolloutEvaluator.isUserInRollout(
      userId: userId,
      featureKey: featureKey,
      rolloutPercentage: featureConfig.rolloutPercentage,
    );

    final reason = isInRollout
        ? AppStrings.enabledBecauseUserBucketInside(
            bucket,
            featureConfig.rolloutPercentage,
          )
        : AppStrings.disabledBecauseUserBucketOutside(
            bucket,
            featureConfig.rolloutPercentage,
          );

    return FeatureDecision(
      featureKey: featureKey,
      enabled: isInRollout,
      reason: reason,
      bucket: bucket,
      rolloutPercentage: featureConfig.rolloutPercentage,
      killSwitch: false,
      variant: featureConfig.variant,
    );
  }
}
