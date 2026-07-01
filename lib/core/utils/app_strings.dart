class AppStrings {
  const AppStrings._();

  static const String appTitle = 'RemoteConfig & StagedRollout';
  static const String appTagline =
      'Same app build, different runtime behavior driven by mocked remote config.';

  static const String currentUserSectionTitle = 'Current User';
  static const String portfolioSectionTitle = 'Portfolio';
  static const String marketNewsSectionTitle = 'Market News';
  static const String advancedChartSectionTitle = 'Advanced Chart';
  static const String quickInvestSectionTitle = 'Quick Invest';

  static const String userLabel = 'User';
  static const String configLabel = 'Config';
  static const String versionLabel = 'Version';
  static const String environmentLabel = 'Env';

  static const String configA = 'Config A';
  static const String configB = 'Config B';

  static const String defaultUserId = 'user_123';
  static const String secondDemoUserId = 'user_456';
  static const String vipTraderUserId = 'vip_trader';
  static const List<String> demoUsers = <String>[
    defaultUserId,
    secondDemoUserId,
    vipTraderUserId,
  ];

  static const String configSwitcherTitle = 'Config Switcher';
  static const String configSwitcherSubtitle =
      'Switch between Config A and Config B to prove runtime-controlled behavior.';

  static const String debugDecisionPanelTitle = 'Debug Decision Panel';
  static const String debugDecisionPanelSubtitle =
      'Every feature decision is explained by the service layer, not the widgets.';
  static const String enabledStatus = 'Enabled';
  static const String disabledStatus = 'Disabled';
  static const String unknownFeature = 'Unknown Feature';
  static const String keyLabel = 'Key';
  static const String bucketLabel = 'Bucket';
  static const String rolloutLabel = 'Rollout';
  static const String killSwitchLabel = 'Kill-switch';
  static const String variantLabel = 'Variant';
  static const String notAvailable = 'n/a';
  static const String on = 'On';
  static const String off = 'Off';

  static const String newPortfolioTitle = 'New Portfolio Dashboard';
  static const String newPortfolioSubtitle =
      'A richer experimental surface with stronger visual hierarchy and insight cards.';
  static const String netWorthLabel = 'Net Worth';
  static const String netWorthValue = '\$128,420';
  static const String netWorthTrend = '+2.9%';
  static const String riskScoreLabel = 'Risk Score';
  static const String riskScoreValue = 'Moderate';
  static const String riskScoreTrend = 'Optimized';
  static const String allocationSnapshotTitle = 'Allocation Snapshot';
  static const String equitiesLabel = 'Equities';
  static const String etfsLabel = 'ETFs';
  static const String cashLabel = 'Cash';

  static const String oldPortfolioTitle = 'Old Portfolio Widget';
  static const String oldPortfolioSubtitle =
      'Fallback experience shown when the new dashboard is gated off.';
  static const String balanceLabel = 'Balance';
  static const String balanceValue = '\$124,800';
  static const String dayChangeLabel = '1D Change';
  static const String dayChangeValue = '+0.8%';
  static const String aaplSymbol = 'AAPL';
  static const String aaplAllocation = '32%';
  static const String aaplChange = '+1.4%';
  static const String tslaSymbol = 'TSLA';
  static const String tslaAllocation = '18%';
  static const String tslaChange = '-0.6%';
  static const String cashSymbol = 'CASH';
  static const String cashAllocation = '50%';
  static const String cashChange = 'Flat';

  static const String marketNewsTitle = 'Market News Card';
  static const String marketNewsSubtitle =
      'This widget only appears when the remote config gate is enabled.';
  static const String marketHeadlineOne =
      'Fed signals steady rates while inflation cools';
  static const String marketHeadlineOneSource = 'Macro Desk';
  static const String marketHeadlineTwo =
      'Semiconductor stocks rally on stronger demand outlook';
  static const String marketHeadlineTwoSource = 'Markets Live';

  static const String advancedChartTitle = 'Advanced Chart Widget';
  static const String advancedChartSubtitle =
      'An experimental chart experience unlocked by deterministic rollout.';
  static const String chartRange5d = '5D';
  static const String chartRange1m = '1M';
  static const String chartRange6m = '6M';
  static const String chartRange1y = '1Y';
  static const String chartRangeMax = 'MAX';

  static const String quickInvestTitle = 'Quick Invest Button';
  static const String quickInvestSubtitle =
      'A gated action surface that can be rolled out gradually or killed instantly.';
  static const String quickInvestCta = 'Invest \$500 now';

  static const String configIsNull = 'Config is null';
  static const String configMustDefineAtLeastOneFeature =
      'Config must define at least one feature';
  static const String featureMapKeyMustNotBeEmpty =
      'Feature map key must not be empty';
  static const String featureKeyMustNotBeEmpty =
      'Feature key must not be empty';
  static const String disabledSafelyUnknownFeature =
      'Disabled safely: unknown feature';
  static const String disabledSafelyInvalidConfig =
      'Disabled safely: invalid config';
  static const String disabledByKillSwitch = 'Disabled by kill-switch';
  static const String disabledBecauseFeatureFlagIsOff =
      'Disabled because feature flag is off';
  static const String disabledBecauseUserIsBlocked =
      'Disabled because user is blocked';
  static const String enabledBecauseUserIsExplicitlyAllowed =
      'Enabled because user is explicitly allowed';

  static String featureKeyMismatch(String mapKey) {
    return 'Feature key mismatch for $mapKey';
  }

  static String rolloutPercentageRangeError(String mapKey) {
    return 'Rollout percentage for $mapKey must be between 0 and 100';
  }

  static String enabledBecauseUserBucketInside(
    int bucket,
    int rolloutPercentage,
  ) {
    return 'Enabled because user bucket $bucket is inside rollout percentage $rolloutPercentage';
  }

  static String disabledBecauseUserBucketOutside(
    int bucket,
    int rolloutPercentage,
  ) {
    return 'Disabled because user bucket $bucket is outside rollout percentage $rolloutPercentage';
  }
}
