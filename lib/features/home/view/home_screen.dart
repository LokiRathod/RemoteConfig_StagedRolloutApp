import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rcsr_app/core/constants/feature_keys.dart';
import 'package:rcsr_app/core/remote_config/models/feature_decision.dart';
import 'package:rcsr_app/core/remote_config/providers/remote_config_providers.dart';
import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/charts/view/advanced_chart_widget.dart';
import 'package:rcsr_app/features/home/view_model/home_view_model.dart';
import 'package:rcsr_app/features/home/widgets/config_switcher.dart';
import 'package:rcsr_app/features/home/widgets/debug_decision_panel.dart';
import 'package:rcsr_app/features/market_news/view/market_news_card.dart';
import 'package:rcsr_app/features/portfolio/view/new_portfolio_widget.dart';
import 'package:rcsr_app/features/portfolio/view/old_portfolio_widget.dart';
import 'package:rcsr_app/features/quick_invest/view/quick_invest_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel viewModel = ref.watch(homeViewModelProvider);
    final List<FeatureDecision> decisions = FeatureKeys.all
        .map((String key) => viewModel.featureDecisions[key])
        .whereType<FeatureDecision>()
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _SummaryHeader(viewModel: viewModel),
              const SizedBox(height: 16),
              Text(
                AppStrings.currentUserSectionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: AppStrings.demoUsers
                    .map((String userId) {
                      return ChoiceChip(
                        label: Text(userId),
                        selected: viewModel.currentUserId == userId,
                        onSelected: (_) => viewModel.switchUser(userId),
                      );
                    })
                    .toList(growable: false),
              ),
              const SizedBox(height: 16),
              ConfigSwitcher(
                selectedConfig: viewModel.selectedConfig,
                onSelected: viewModel.switchConfig,
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.portfolioSectionTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              viewModel.isFeatureEnabled(FeatureKeys.newPortfolioDashboard)
                  ? const NewPortfolioWidget()
                  : const OldPortfolioWidget(),
              const SizedBox(height: 24),
              if (viewModel.isFeatureEnabled(
                FeatureKeys.marketNewsCard,
              )) ...<Widget>[
                Text(
                  AppStrings.marketNewsSectionTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                const MarketNewsCard(),
                const SizedBox(height: 24),
              ],
              if (viewModel.isFeatureEnabled(
                FeatureKeys.advancedChart,
              )) ...<Widget>[
                Text(
                  AppStrings.advancedChartSectionTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                const AdvancedChartWidget(),
                const SizedBox(height: 24),
              ],
              if (viewModel.isFeatureEnabled(
                FeatureKeys.quickInvestButton,
              )) ...<Widget>[
                Text(
                  AppStrings.quickInvestSectionTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                const QuickInvestButton(),
                const SizedBox(height: 24),
              ],
              DebugDecisionPanel(decisions: decisions),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: <Color>[
            AppColors.headerGradientStart,
            AppColors.headerGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppStrings.appTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.appTagline,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _HeaderChip(
                label: AppStrings.userLabel,
                value: viewModel.currentUserId,
              ),
              _HeaderChip(
                label: AppStrings.configLabel,
                value: viewModel.selectedConfigName,
              ),
              _HeaderChip(
                label: AppStrings.versionLabel,
                value: viewModel.activeConfig.configVersion,
              ),
              _HeaderChip(
                label: AppStrings.environmentLabel,
                value: viewModel.activeConfig.environment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  const _HeaderChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: <InlineSpan>[
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
