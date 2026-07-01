import 'package:rcsr_app/core/constants/feature_keys.dart';
import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';

final RemoteConfigModel mockConfigA = RemoteConfigModel(
  configVersion: '2026.07.a',
  environment: 'demo',
  features: <String, FeatureFlagConfig>{
    FeatureKeys.newPortfolioDashboard: FeatureFlagConfig(
      key: FeatureKeys.newPortfolioDashboard,
      enabled: true,
      killSwitch: false,
      rolloutPercentage: 50,
      variant: 'v2',
      owner: 'portfolio-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{
        'description': 'New portfolio dashboard rollout',
      },
    ),
    FeatureKeys.marketNewsCard: FeatureFlagConfig(
      key: FeatureKeys.marketNewsCard,
      enabled: true,
      killSwitch: false,
      rolloutPercentage: 100,
      variant: 'default',
      owner: 'content-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{'description': 'Daily market headlines'},
    ),
    FeatureKeys.advancedChart: FeatureFlagConfig(
      key: FeatureKeys.advancedChart,
      enabled: false,
      killSwitch: false,
      rolloutPercentage: 0,
      variant: 'default',
      owner: 'charts-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{'description': 'Advanced charting surface'},
    ),
    FeatureKeys.quickInvestButton: FeatureFlagConfig(
      key: FeatureKeys.quickInvestButton,
      enabled: true,
      killSwitch: false,
      rolloutPercentage: 25,
      variant: 'compact',
      owner: 'investment-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{'description': 'Fast buy CTA'},
    ),
  },
);
