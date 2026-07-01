import 'package:flutter/material.dart';

import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class NewPortfolioWidget extends StatelessWidget {
  const NewPortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.newPortfolioTitle,
      subtitle: AppStrings.newPortfolioSubtitle,
      icon: Icons.stacked_line_chart,
      accentColor: AppColors.newPortfolioAccent,
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Expanded(
                child: _InsightTile(
                  label: AppStrings.netWorthLabel,
                  value: AppStrings.netWorthValue,
                  trend: AppStrings.netWorthTrend,
                  color: AppColors.newPortfolioValueBackground,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _InsightTile(
                  label: AppStrings.riskScoreLabel,
                  value: AppStrings.riskScoreValue,
                  trend: AppStrings.riskScoreTrend,
                  color: AppColors.newPortfolioRiskBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.allocationBackground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppStrings.allocationSnapshotTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                const _AllocationBar(
                  label: AppStrings.equitiesLabel,
                  widthFactor: 0.62,
                  color: AppColors.headerGradientEnd,
                ),
                const SizedBox(height: 10),
                const _AllocationBar(
                  label: AppStrings.etfsLabel,
                  widthFactor: 0.23,
                  color: AppColors.newPortfolioAccent,
                ),
                const SizedBox(height: 10),
                const _AllocationBar(
                  label: AppStrings.cashLabel,
                  widthFactor: 0.15,
                  color: AppColors.debugPanelAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.label,
    required this.value,
    required this.trend,
    required this.color,
  });

  final String label;
  final String value;
  final String trend;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            trend,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AllocationBar extends StatelessWidget {
  const _AllocationBar({
    required this.label,
    required this.widthFactor,
    required this.color,
  });

  final String label;
  final double widthFactor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label),
        const SizedBox(height: 6),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.allocationTrack,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Container(
                  height: 10,
                  width: constraints.maxWidth * widthFactor,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
