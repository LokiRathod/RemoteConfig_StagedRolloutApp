import 'package:rcsr_app/core/constants/feature_keys.dart';
import 'package:rcsr_app/core/remote_config/models/feature_flag_config.dart';
import 'package:rcsr_app/core/remote_config/models/remote_config_model.dart';

final RemoteConfigModel mockConfigB = RemoteConfigModel(
  configVersion: '2026.07.b',
  environment: 'demo',
  features: <String, FeatureFlagConfig>{
    FeatureKeys.newPortfolioDashboard: FeatureFlagConfig(
      key: FeatureKeys.newPortfolioDashboard,
      enabled: true,
      killSwitch: true,
      rolloutPercentage: 100,
      variant: 'v2',
      owner: 'portfolio-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{'description': 'Emergency rollback example'},
    ),
    FeatureKeys.marketNewsCard: FeatureFlagConfig(
      key: FeatureKeys.marketNewsCard,
      enabled: false,
      killSwitch: false,
      rolloutPercentage: 0,
      variant: 'default',
      owner: 'content-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{'description': 'Market news disabled'},
    ),
    FeatureKeys.advancedChart: FeatureFlagConfig(
      key: FeatureKeys.advancedChart,
      enabled: true,
      killSwitch: false,
      rolloutPercentage: 30,
      variant: 'candlestick',
      owner: 'charts-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{'description': 'Experimental chart variant'},
    ),
    FeatureKeys.quickInvestButton: FeatureFlagConfig(
      key: FeatureKeys.quickInvestButton,
      enabled: true,
      killSwitch: false,
      rolloutPercentage: 100,
      variant: 'full',
      owner: 'investment-team',
      expiryDate: DateTime(2026, 12, 31),
      metadata: <String, Object?>{
        'description': 'Full quick invest experience',
      },
    ),
  },
);
