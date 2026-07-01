import 'package:rcsr_app/core/remote_config/models/feature_decision.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/remote_config/repository/remote_config_repository.dart';

class HomeViewModel {
  const HomeViewModel({
    required this.currentUserId,
    required this.selectedConfig,
    required this.selectedConfigName,
    required this.activeConfig,
    required this.featureDecisions,
    required this.switchConfig,
    required this.switchUser,
  });

  final String currentUserId;
  final ConfigSelection selectedConfig;
  final String selectedConfigName;
  final RemoteConfigModel activeConfig;
  final Map<String, FeatureDecision> featureDecisions;
  final void Function(ConfigSelection selection) switchConfig;
  final void Function(String userId) switchUser;

  bool isFeatureEnabled(String featureKey) {
    return featureDecisions[featureKey]?.enabled ?? false;
  }
}
