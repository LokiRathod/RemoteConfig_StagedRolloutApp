import 'package:flutter/material.dart';

import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class MarketNewsCard extends StatelessWidget {
  const MarketNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.marketNewsTitle,
      subtitle: AppStrings.marketNewsSubtitle,
      icon: Icons.feed_outlined,
      accentColor: AppColors.marketNewsAccent,
      child: Column(
        children: const <Widget>[
          _HeadlineRow(
            title: AppStrings.marketHeadlineOne,
            source: AppStrings.marketHeadlineOneSource,
          ),
          Divider(height: 24),
          _HeadlineRow(
            title: AppStrings.marketHeadlineTwo,
            source: AppStrings.marketHeadlineTwoSource,
          ),
        ],
      ),
    );
  }
}

class _HeadlineRow extends StatelessWidget {
  const _HeadlineRow({required this.title, required this.source});

  final String title;
  final String source;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(top: 6),
          decoration: const BoxDecoration(
            color: AppColors.marketNewsAccent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(source),
            ],
          ),
        ),
      ],
    );
  }
}
