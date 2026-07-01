import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';

class RemoteConfigModel {
  const RemoteConfigModel({
    required this.configVersion,
    required this.environment,
    required this.features,
  });

  final String configVersion;
  final String environment;
  final Map<String, FeatureFlagConfig> features;

  factory RemoteConfigModel.fromMap(Map<String, dynamic> map) {
    final rawFeatures = map['features'];
    final features = <String, FeatureFlagConfig>{};

    if (rawFeatures is Map<String, dynamic>) {
      for (final entry in rawFeatures.entries) {
        if (entry.value is Map<String, dynamic>) {
          features[entry.key] = FeatureFlagConfig.fromMap(
            entry.value as Map<String, dynamic>,
          );
        }
      }
    }

    return RemoteConfigModel(
      configVersion: map['configVersion'] as String? ?? 'unknown',
      environment: map['environment'] as String? ?? 'unknown',
      features: features,
    );
  }
}
