import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rcsr_app/core/constants/feature_keys.dart';
import 'package:rcsr_app/core/remote_config/models/feature_decision.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/remote_config/repository/mock_remote_config_repository.dart';
import 'package:rcsr_app/core/remote_config/repository/remote_config_repository.dart';
import 'package:rcsr_app/core/remote_config/services/config_validator.dart';
import 'package:rcsr_app/core/remote_config/services/feature_gate_service.dart';
import 'package:rcsr_app/core/remote_config/services/rollout_evaluator.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/view_model/home_view_model.dart';

final currentUserProvider = StateProvider<String>(
  (Ref ref) => AppStrings.defaultUserId,
);

final selectedConfigProvider = StateProvider<ConfigSelection>((Ref ref) {
  return ConfigSelection.configA;
});

final remoteConfigRepositoryProvider = Provider<RemoteConfigRepository>((
  Ref ref,
) {
  return const MockRemoteConfigRepository();
});

final remoteConfigProvider = Provider<RemoteConfigModel>((Ref ref) {
  final repository = ref.watch(remoteConfigRepositoryProvider);
  final selection = ref.watch(selectedConfigProvider);
  return repository.getConfig(selection);
});

final rolloutEvaluatorProvider = Provider<RolloutEvaluator>((Ref ref) {
  return const RolloutEvaluator();
});

final configValidatorProvider = Provider<ConfigValidator>((Ref ref) {
  return const ConfigValidator();
});

final featureGateServiceProvider = Provider<FeatureGateService>((Ref ref) {
  return FeatureGateService(
    rolloutEvaluator: ref.watch(rolloutEvaluatorProvider),
    configValidator: ref.watch(configValidatorProvider),
  );
});

final homeViewModelProvider = Provider<HomeViewModel>((Ref ref) {
  final currentUserId = ref.watch(currentUserProvider);
  final selectedConfig = ref.watch(selectedConfigProvider);
  final activeConfig = ref.watch(remoteConfigProvider);
  final featureGateService = ref.watch(featureGateServiceProvider);

  final featureDecisions = <String, FeatureDecision>{
    for (final featureKey in FeatureKeys.all)
      featureKey: featureGateService.evaluate(
        featureKey: featureKey,
        userId: currentUserId,
        config: activeConfig,
      ),
  };

  return HomeViewModel(
    currentUserId: currentUserId,
    selectedConfig: selectedConfig,
    selectedConfigName: selectedConfig.label,
    activeConfig: activeConfig,
    featureDecisions: Map<String, FeatureDecision>.unmodifiable(
      featureDecisions,
    ),
    switchConfig: (ConfigSelection selection) {
      ref.read(selectedConfigProvider.notifier).state = selection;
    },
    switchUser: (String userId) {
      ref.read(currentUserProvider.notifier).state = userId;
    },
  );
});
