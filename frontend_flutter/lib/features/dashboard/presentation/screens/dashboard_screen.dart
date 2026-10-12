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
          const SizedBox(width: 4),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isWide = width >= 900;
          final isMedium = width >= 600;

          // Cap content and center on large screens
          final maxContent = 1100.0;
          final hPad = width > maxContent ? (width - maxContent) / 2 : 16.0;

          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Overview',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Real-time fraud monitoring',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 16),

                    // Stats
                    _StatsGrid(isWide: isWide, isMedium: isMedium),
                    const SizedBox(height: 20),

                    // Chart + Alerts
                    if (isWide)
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 5, child: _RiskBlock()),
                          SizedBox(width: 16),
                          Expanded(flex: 6, child: _AlertsBlock()),
                        ],
                      )
                    else ...[
                      const _RiskBlock(),
                      const SizedBox(height: 20),
                      const _AlertsBlock(),
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
}

class _StatsGrid extends StatelessWidget {
  final bool isWide;
  final bool isMedium;

  const _StatsGrid({required this.isWide, required this.isMedium});

  @override
  Widget build(BuildContext context) {
    final cards = const [
      StatCard(
        title: "Today's Txns",
        value: '1,248',
        icon: Icons.receipt_long,
        color: AppColors.primary,
        trend: '+8%',
        trendUp: true,
      ),
      StatCard(
        title: 'Flagged',
        value: '37',
        icon: Icons.flag,
        color: AppColors.warning,
        trend: '+3',
        trendUp: false,
      ),
      StatCard(
        title: 'Open Alerts',
        value: '12',
        icon: Icons.warning_amber,
        color: AppColors.danger,
        trend: '-2',
        trendUp: true,
      ),
      StatCard(
        title: 'Avg Risk',
        value: '0.18',
        icon: Icons.speed,
        color: AppColors.success,
        trend: '-0.04',
        trendUp: true,
      ),
    ];

    final crossAxisCount = isWide ? 4 : 2;
    final aspect = isWide ? 2.8 : (isMedium ? 2.5 : 2.3);

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: aspect,
      children: cards,
    );
  }
}

class _RiskBlock extends StatelessWidget {
  const _RiskBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Distribution',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 10),
        const RiskDistributionChart(),
      ],
    );
  }
}

class _AlertsBlock extends StatelessWidget {
  const _AlertsBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Alerts',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
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