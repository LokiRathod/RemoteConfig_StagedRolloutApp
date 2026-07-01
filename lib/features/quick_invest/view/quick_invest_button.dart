import 'package:flutter/material.dart';

import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class QuickInvestButton extends StatelessWidget {
  const QuickInvestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.quickInvestTitle,
      subtitle: AppStrings.quickInvestSubtitle,
      icon: Icons.flash_on_outlined,
      accentColor: AppColors.quickInvestAccent,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.bolt),
          label: const Text(AppStrings.quickInvestCta),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.quickInvestAccent,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
