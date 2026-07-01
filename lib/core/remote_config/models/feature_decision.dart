class FeatureDecision {
  const FeatureDecision({
    required this.featureKey,
    required this.enabled,
    required this.reason,
    required this.bucket,
    required this.rolloutPercentage,
    required this.killSwitch,
    this.variant,
  });

  final String featureKey;
  final bool enabled;
  final String reason;
  final int? bucket;
  final int rolloutPercentage;
  final bool killSwitch;
  final String? variant;
}
