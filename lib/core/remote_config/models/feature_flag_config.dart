class FeatureFlagConfig {
  const FeatureFlagConfig({
    required this.key,
    required this.enabled,
    required this.killSwitch,
    required this.rolloutPercentage,
    this.allowedUserIds,
    this.blockedUserIds,
    this.variant,
    this.metadata,
    this.owner,
    this.expiryDate,
  });

  final String key;
  final bool enabled;
  final bool killSwitch;
  final int rolloutPercentage;
  final Set<String>? allowedUserIds;
  final Set<String>? blockedUserIds;
  final String? variant;
  final Map<String, Object?>? metadata;
  final String? owner;
  final DateTime? expiryDate;

  factory FeatureFlagConfig.fromMap(Map<String, dynamic> map) {
    return FeatureFlagConfig(
      key: map['key'] as String? ?? '',
      enabled: map['enabled'] as bool? ?? false,
      killSwitch: map['killSwitch'] as bool? ?? false,
      rolloutPercentage: map['rolloutPercentage'] as int? ?? 0,
      allowedUserIds: _stringSet(map['allowedUserIds']),
      blockedUserIds: _stringSet(map['blockedUserIds']),
      variant: map['variant'] as String?,
      metadata: map['metadata'] is Map<String, Object?>
          ? map['metadata'] as Map<String, Object?>
          : null,
      owner: map['owner'] as String?,
      expiryDate: _parseDate(map['expiryDate']),
    );
  }

  static Set<String>? _stringSet(dynamic value) {
    if (value is Iterable) {
      return value.whereType<String>().toSet();
    }
    return null;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value is DateTime) {
      return value;
    }
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
