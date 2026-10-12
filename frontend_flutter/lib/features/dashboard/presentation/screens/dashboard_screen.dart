import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/stat_card.dart';
import '../widgets/risk_distribution_chart.dart';
import '../widgets/recent_alerts_list.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isWide = width >= 900;
          final isMedium = width >= 600 && width < 900;

          // Cap content width on very large screens
          final contentWidth = width > 1200 ? 1200.0 : width;
          final horizontalPadding = width > 1200 ? (width - 1200) / 2 : 16.0;

          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                16,
                horizontalPadding,
                24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Real-time fraud monitoring',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 20),

                    // Stats grid – responsive
                    _buildStatsGrid(isWide: isWide, isMedium: isMedium),
                    const SizedBox(height: 24),

                    // Chart + Alerts – side by side on wide screens
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: _buildRiskSection(context),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 6,
                            child: _buildAlertsSection(context),
                          ),
                        ],
                      )
                    else ...[
                      _buildRiskSection(context),
                      const SizedBox(height: 24),
                      _buildAlertsSection(context),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsGrid({required bool isWide, required bool isMedium}) {
    final cards = [
      const StatCard(
        title: "Today's Txns",
        value: '1,248',
        icon: Icons.receipt_long,
        color: AppColors.primary,
        trend: '+8%',
        trendUp: true,
      ),
      const StatCard(
        title: 'Flagged',
        value: '37',
        icon: Icons.flag,
        color: AppColors.warning,
        trend: '+3',
        trendUp: false,
      ),
      const StatCard(
        title: 'Open Alerts',
        value: '12',
        icon: Icons.warning_amber,
        color: AppColors.danger,
        trend: '-2',
        trendUp: true,
      ),
      const StatCard(
        title: 'Avg Risk',
        value: '0.18',
        icon: Icons.speed,
        color: AppColors.success,
        trend: '-0.04',
        trendUp: true,
      ),
    ];

    // Wide: 4 columns | Medium: 2 columns | Narrow: 2 columns stacked
    final crossAxisCount = isWide ? 4 : 2;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: isWide ? 2.6 : (isMedium ? 2.4 : 2.2),
      children: cards,
    );
  }

  Widget _buildRiskSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Distribution',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        const RiskDistributionChart(),
      ],
    );
  }

  Widget _buildAlertsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Alerts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See all'),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const RecentAlertsList(),
      ],
    );
  }
}
