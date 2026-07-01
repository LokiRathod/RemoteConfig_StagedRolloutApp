import 'package:flutter/material.dart';

import 'package:rcsr_app/core/remote_config/repository/remote_config_repository.dart';
import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class ConfigSwitcher extends StatelessWidget {
  const ConfigSwitcher({
    super.key,
    required this.selectedConfig,
    required this.onSelected,
  });

  final ConfigSelection selectedConfig;
  final ValueChanged<ConfigSelection> onSelected;

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.configSwitcherTitle,
      subtitle: AppStrings.configSwitcherSubtitle,
      icon: Icons.sync_alt,
      accentColor: AppColors.configSwitcherAccent,
      child: SegmentedButton<ConfigSelection>(
        segments: const <ButtonSegment<ConfigSelection>>[
          ButtonSegment<ConfigSelection>(
            value: ConfigSelection.configA,
            label: Text(AppStrings.configA),
            icon: Icon(Icons.looks_one_outlined),
          ),
          ButtonSegment<ConfigSelection>(
            value: ConfigSelection.configB,
            label: Text(AppStrings.configB),
            icon: Icon(Icons.looks_two_outlined),
          ),
        ],
        selected: <ConfigSelection>{selectedConfig},
        onSelectionChanged: (Set<ConfigSelection> values) {
          if (values.isNotEmpty) {
            onSelected(values.first);
          }
        },
      ),
    );
  }
}
