import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';

enum ConfigSelection { configA, configB }

extension ConfigSelectionX on ConfigSelection {
  String get label {
    return switch (this) {
      ConfigSelection.configA => AppStrings.configA,
      ConfigSelection.configB => AppStrings.configB,
    };
  }
}

abstract class RemoteConfigRepository {
  RemoteConfigModel getConfig(ConfigSelection selection);
}
