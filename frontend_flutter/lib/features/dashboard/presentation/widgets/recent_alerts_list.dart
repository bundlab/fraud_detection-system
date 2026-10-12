import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';

class RecentAlertsList extends StatelessWidget {
  const RecentAlertsList({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder data
    final alerts = [
      _AlertItem(
        merchant: 'Amazon Marketplace',
        amount: 1249.99,
        score: 0.92,
        time: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      _AlertItem(
        merchant: 'Unknown Merchant',
        amount: 899.00,
        score: 0.78,
        time: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      _AlertItem(
        merchant: 'Steam Games',
        amount: 59.99,
        score: 0.71,
        time: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: alerts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final riskColor = AppColors.riskColor(alert.score);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
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
              alert.merchant,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              DateFormat('MMM d, HH:mm').format(alert.time),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${alert.amount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: riskColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${(alert.score * 100).toInt()}%',
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
              // Navigate to alert detail
            },
          );
        },
      ),
    );
  }
}

class _AlertItem {
  final String merchant;
  final double amount;
  final double score;
  final DateTime time;

  _AlertItem({
    required this.merchant,
    required this.amount,
    required this.score,
    required this.time,
  });
}
