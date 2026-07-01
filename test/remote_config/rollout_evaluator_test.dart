import 'package:flutter_test/flutter_test.dart';
import 'package:rcsr_app/core/remote_config/services/rollout_evaluator.dart';

void main() {
  const evaluator = RolloutEvaluator();

  group('RolloutEvaluator', () {
    test('same user and same feature always returns the same bucket', () {
      final first = evaluator.bucketForUser(
        userId: 'user_123',
        featureKey: 'new_portfolio_dashboard',
      );
      final second = evaluator.bucketForUser(
        userId: 'user_123',
        featureKey: 'new_portfolio_dashboard',
      );

      expect(first, second);
    });

    test('same user and different features can return different buckets', () {
      final buckets = <int>{
        evaluator.bucketForUser(
          userId: 'user_123',
          featureKey: 'new_portfolio_dashboard',
        ),
        evaluator.bucketForUser(
          userId: 'user_123',
          featureKey: 'market_news_card',
        ),
        evaluator.bucketForUser(
          userId: 'user_123',
          featureKey: 'advanced_chart',
        ),
      };

      expect(buckets.length, greaterThan(1));
    });

    test('different users can produce different buckets', () {
      final buckets = <int>{
        evaluator.bucketForUser(
          userId: 'user_123',
          featureKey: 'quick_invest_button',
        ),
        evaluator.bucketForUser(
          userId: 'user_456',
          featureKey: 'quick_invest_button',
        ),
        evaluator.bucketForUser(
          userId: 'vip_trader',
          featureKey: 'quick_invest_button',
        ),
      };

      expect(buckets.length, greaterThan(1));
    });

    test('0 percent rollout disables all valid users', () {
      for (final userId in <String>['user_123', 'user_456', 'vip_trader']) {
        expect(
          evaluator.isUserInRollout(
            userId: userId,
            featureKey: 'advanced_chart',
            rolloutPercentage: 0,
          ),
          isFalse,
        );
      }
    });

    test('100 percent rollout enables all valid users', () {
      for (final userId in <String>['user_123', 'user_456', 'vip_trader']) {
        expect(
          evaluator.isUserInRollout(
            userId: userId,
            featureKey: 'market_news_card',
            rolloutPercentage: 100,
          ),
          isTrue,
        );
      }
    });

    test('user inside rollout percentage returns true', () {
      const userId = 'user_123';
      const featureKey = 'new_portfolio_dashboard';
      final bucket = evaluator.bucketForUser(
        userId: userId,
        featureKey: featureKey,
      );

      expect(
        evaluator.isUserInRollout(
          userId: userId,
          featureKey: featureKey,
          rolloutPercentage: bucket + 1,
        ),
        isTrue,
      );
    });

    test('user outside rollout percentage returns false', () {
      const userId = 'user_123';
      const featureKey = 'new_portfolio_dashboard';
      final bucket = evaluator.bucketForUser(
        userId: userId,
        featureKey: featureKey,
      );

      expect(
        evaluator.isUserInRollout(
          userId: userId,
          featureKey: featureKey,
          rolloutPercentage: bucket,
        ),
        isFalse,
      );
    });
  });
}
