import 'package:rcsr_app/core/remote_config/data/mock_config_a.dart';
import 'package:rcsr_app/core/remote_config/data/mock_config_b.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';
import 'package:rcsr_app/core/remote_config/repository/remote_config_repository.dart';

class MockRemoteConfigRepository implements RemoteConfigRepository {
  const MockRemoteConfigRepository();

  @override
  RemoteConfigModel getConfig(ConfigSelection selection) {
    return switch (selection) {
      ConfigSelection.configA => mockConfigA,
      ConfigSelection.configB => mockConfigB,
    };
  }
}
