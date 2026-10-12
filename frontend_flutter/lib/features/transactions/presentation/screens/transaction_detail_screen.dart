import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String transactionId;

  const TransactionDetailScreen({
    super.key,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Fetch real transaction by id
    // Placeholder
    final score = 0.92;
    final riskColor = AppColors.riskColor(score);
    final riskLabel = AppColors.riskLabel(score);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Risk score banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: riskColor.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'Risk Score',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(score * 100).toInt()}%',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: riskColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: riskColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    riskLabel.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Transaction info
          _SectionTitle(title: 'Transaction Info'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                _InfoRow(label: 'ID', value: transactionId),
                const Divider(height: 1),
                _InfoRow(label: 'Merchant', value: 'Amazon Marketplace'),
                const Divider(height: 1),
                _InfoRow(label: 'Amount', value: 'USD 1,249.99'),
                const Divider(height: 1),
                _InfoRow(
                  label: 'Date',
                  value: DateFormat('MMM d, yyyy • HH:mm')
                      .format(DateTime.now().subtract(const Duration(minutes: 15))),
                ),
                const Divider(height: 1),
                _InfoRow(label: 'Status', value: 'Flagged'),
                const Divider(height: 1),
                _InfoRow(label: 'Location', value: 'Lagos, Nigeria'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Top contributing features (SHAP)
          _SectionTitle(title: 'Top Risk Factors'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                _FeatureRow(
                  feature: 'Unusual amount for user',
                  impact: 0.28,
                ),
                const Divider(height: 1),
                _FeatureRow(
                  feature: 'New merchant',
                  impact: 0.21,
                ),
                const Divider(height: 1),
                _FeatureRow(
                  feature: 'High velocity (last 1h)',
                  impact: 0.18,
                ),
                const Divider(height: 1),
                _FeatureRow(
                  feature: 'Device not recognized',
                  impact: 0.15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Mark Safe'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.success,
                    side: const BorderSide(color: AppColors.success),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.report_outlined),
                  label: const Text('Confirm Fraud'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.folder_open),
              label: const Text('Open Investigation Case'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String feature;
  final double impact;

  const _FeatureRow({required this.feature, required this.impact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(feature),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: LinearProgressIndicator(
              value: impact,
              backgroundColor: AppColors.border,
              color: AppColors.riskHigh,
              minHeight: 6,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '+${(impact * 100).toInt()}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.riskHigh,
            ),
          ),
        ],
      ),
    );
  }
}
