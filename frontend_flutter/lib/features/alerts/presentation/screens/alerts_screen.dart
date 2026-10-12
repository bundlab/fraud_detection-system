import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../models/alert_model.dart';

class AlertsScreen extends ConsumerStatefulWidget {
  const AlertsScreen({super.key});

  @override
  ConsumerState<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends ConsumerState<AlertsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Placeholder data
  final List<AlertModel> _alerts = [
    AlertModel(
      id: 'alt_001',
      transactionId: 'txn_001',
      riskScore: 0.92,
      riskLevel: 'critical',
      status: 'open',
      reason: 'Unusual amount + new merchant',
      topFeatures: ['amount_zscore', 'new_merchant', 'velocity_1h'],
      createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
      merchantName: 'Amazon Marketplace',
      amount: 1249.99,
      currency: 'USD',
    ),
    AlertModel(
      id: 'alt_002',
      transactionId: 'txn_003',
      riskScore: 0.78,
      riskLevel: 'high',
      status: 'investigating',
      reason: 'Unknown merchant pattern',
      topFeatures: ['merchant_risk', 'ip_risk'],
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      assignedTo: 'analyst_01',
      merchantName: 'Unknown Merchant',
      amount: 899.00,
      currency: 'USD',
    ),
    AlertModel(
      id: 'alt_003',
      transactionId: 'txn_006',
      riskScore: 0.71,
      riskLevel: 'high',
      status: 'resolved',
      reason: 'Confirmed false positive',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      resolvedAt: DateTime.now().subtract(const Duration(hours: 6)),
      merchantName: 'Steam Games',
      amount: 59.99,
      currency: 'USD',
    ),
  ];

  List<AlertModel> _filterByStatus(String status) {
    if (status == 'all') return _alerts;
    return _alerts.where((a) => a.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Open'),
            Tab(text: 'Investigating'),
            Tab(text: 'Resolved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AlertList(alerts: _filterByStatus('open')),
          _AlertList(alerts: _filterByStatus('investigating')),
          _AlertList(alerts: _filterByStatus('resolved')),
        ],
      ),
    );
  }
}

class _AlertList extends StatelessWidget {
  final List<AlertModel> alerts;

  const _AlertList({required this.alerts});

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No alerts here',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: alerts.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final alert = alerts[index];
        final riskColor = AppColors.riskColor(alert.riskScore);

        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.warning_amber, color: riskColor, size: 22),
          ),
          title: Text(
            alert.merchantName ?? 'Unknown',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(
                alert.reason ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat('MMM d, HH:mm').format(alert.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (alert.amount != null)
                Text(
                  '${alert.currency ?? 'USD'} ${alert.amount!.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${(alert.riskScore * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: riskColor,
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            // Navigate to alert / transaction detail
          },
        );
      },
    );
  }
}
