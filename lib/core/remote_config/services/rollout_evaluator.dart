class RolloutEvaluator {
  const RolloutEvaluator();

  int bucketForUser({required String userId, required String featureKey}) {
    // Deterministic bucket assignment keeps rollout stable across app launches.
    final input = '$userId:$featureKey';
    var hash = 0;

    for (final codeUnit in input.codeUnits) {
      hash = ((hash * 31) + codeUnit) & 0x7fffffff;
    }

    return hash % 100;
  }

  bool isUserInRollout({
    required String userId,
    required String featureKey,
    required int rolloutPercentage,
  }) {
    if (rolloutPercentage <= 0) {
      return false;
    }
    if (rolloutPercentage >= 100) {
      return true;
    }

    final bucket = bucketForUser(userId: userId, featureKey: featureKey);
    return bucket < rolloutPercentage;
  }
}
