import 'package:flutter/material.dart';

import 'package:rcsr_app/core/remote_config/models/feature_decision.dart';
import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class DebugDecisionPanel extends StatelessWidget {
  const DebugDecisionPanel({super.key, required this.decisions});

  final List<FeatureDecision> decisions;

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.debugDecisionPanelTitle,
      subtitle: AppStrings.debugDecisionPanelSubtitle,
      icon: Icons.rule_folder_outlined,
      accentColor: AppColors.debugPanelAccent,
      child: Column(
        children: decisions
            .map(
              (FeatureDecision decision) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _DecisionTile(decision: decision),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class _DecisionTile extends StatelessWidget {
  const _DecisionTile({required this.decision});

  final FeatureDecision decision;

  @override
  Widget build(BuildContext context) {
    final bool enabled = decision.enabled;
    final Color stateColor = enabled ? AppColors.success : AppColors.danger;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: stateColor.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _humanize(decision.featureKey),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: stateColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  enabled
                      ? AppStrings.enabledStatus
                      : AppStrings.disabledStatus,
                  style: TextStyle(
                    color: stateColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(decision.reason, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _InfoChip(label: AppStrings.keyLabel, value: decision.featureKey),
              _InfoChip(
                label: AppStrings.bucketLabel,
                value: decision.bucket?.toString() ?? AppStrings.notAvailable,
              ),
              _InfoChip(
                label: AppStrings.rolloutLabel,
                value: '${decision.rolloutPercentage}%',
              ),
              _InfoChip(
                label: AppStrings.killSwitchLabel,
                value: decision.killSwitch ? AppStrings.on : AppStrings.off,
              ),
              _InfoChip(
                label: AppStrings.variantLabel,
                value: decision.variant ?? AppStrings.notAvailable,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _humanize(String key) {
    if (key.isEmpty) {
      return AppStrings.unknownFeature;
    }

    return key
        .split('_')
        .map((String part) {
          return '${part[0].toUpperCase()}${part.substring(1)}';
        })
        .join(' ');
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.neutralChipBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
