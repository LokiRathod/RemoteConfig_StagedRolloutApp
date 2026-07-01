import 'package:flutter/material.dart';

import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/widgets/feature_card.dart';

class AdvancedChartWidget extends StatelessWidget {
  const AdvancedChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      title: AppStrings.advancedChartTitle,
      subtitle: AppStrings.advancedChartSubtitle,
      icon: Icons.candlestick_chart,
      accentColor: AppColors.advancedChartAccent,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const <Widget>[
                Expanded(
                  child: _ChartBar(
                    height: 62,
                    color: AppColors.advancedChartBar1,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _ChartBar(
                    height: 88,
                    color: AppColors.advancedChartBar2,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _ChartBar(
                    height: 74,
                    color: AppColors.advancedChartBar3,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _ChartBar(
                    height: 112,
                    color: AppColors.advancedChartBar4,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _ChartBar(
                    height: 94,
                    color: AppColors.advancedChartBar5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(AppStrings.chartRange5d),
              Text(AppStrings.chartRange1m),
              Text(AppStrings.chartRange6m),
              Text(AppStrings.chartRange1y),
              Text(AppStrings.chartRangeMax),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  const _ChartBar({required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
