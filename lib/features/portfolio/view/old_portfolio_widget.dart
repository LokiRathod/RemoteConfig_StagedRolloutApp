import 'package:flutter/material.dart';

import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class OldPortfolioWidget extends StatelessWidget {
  const OldPortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.oldPortfolioTitle,
      subtitle: AppStrings.oldPortfolioSubtitle,
      icon: Icons.account_balance_wallet_outlined,
      accentColor: AppColors.oldPortfolioAccent,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _Metric(
                  label: AppStrings.balanceLabel,
                  value: AppStrings.balanceValue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Metric(
                  label: AppStrings.dayChangeLabel,
                  value: AppStrings.dayChangeValue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _HoldingRow(
            symbol: AppStrings.aaplSymbol,
            allocation: AppStrings.aaplAllocation,
            change: AppStrings.aaplChange,
          ),
          const Divider(height: 24),
          const _HoldingRow(
            symbol: AppStrings.tslaSymbol,
            allocation: AppStrings.tslaAllocation,
            change: AppStrings.tslaChange,
          ),
          const Divider(height: 24),
          const _HoldingRow(
            symbol: AppStrings.cashSymbol,
            allocation: AppStrings.cashAllocation,
            change: AppStrings.cashChange,
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.oldPortfolioMetricBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _HoldingRow extends StatelessWidget {
  const _HoldingRow({
    required this.symbol,
    required this.allocation,
    required this.change,
  });

  final String symbol;
  final String allocation;
  final String change;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            symbol,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Text(allocation),
        const SizedBox(width: 16),
        Text(change),
      ],
    );
  }
}
