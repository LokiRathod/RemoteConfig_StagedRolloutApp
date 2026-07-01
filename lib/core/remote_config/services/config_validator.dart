import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';

class ConfigValidationResult {
  const ConfigValidationResult.valid()
    : isValid = true,
      errors = const <String>[];

  const ConfigValidationResult.invalid(this.errors) : isValid = false;

  final bool isValid;
  final List<String> errors;
}

class ConfigValidator {
  const ConfigValidator();

  ConfigValidationResult validate(RemoteConfigModel? config) {
    if (config == null) {
      return const ConfigValidationResult.invalid(<String>[
        AppStrings.configIsNull,
      ]);
    }

    final errors = <String>[];

    if (config.features.isEmpty) {
      errors.add(AppStrings.configMustDefineAtLeastOneFeature);
    }

    config.features.forEach((String mapKey, FeatureFlagConfig feature) {
      if (mapKey.trim().isEmpty) {
        errors.add(AppStrings.featureMapKeyMustNotBeEmpty);
      }
      if (feature.key.trim().isEmpty) {
        errors.add(AppStrings.featureKeyMustNotBeEmpty);
      }
      if (mapKey != feature.key) {
        errors.add(AppStrings.featureKeyMismatch(mapKey));
      }
      if (feature.rolloutPercentage < 0 || feature.rolloutPercentage > 100) {
        errors.add(AppStrings.rolloutPercentageRangeError(mapKey));
      }
    });

    if (errors.isEmpty) {
      return const ConfigValidationResult.valid();
    }

    return ConfigValidationResult.invalid(List<String>.unmodifiable(errors));
  }
}
