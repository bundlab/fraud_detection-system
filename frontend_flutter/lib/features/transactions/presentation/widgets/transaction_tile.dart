import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final score = transaction.riskScore ?? 0.0;
    final riskColor = AppColors.riskColor(score);
    final riskLabel = AppColors.riskLabel(score);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: CircleAvatar(
        backgroundColor: riskColor.withOpacity(0.12),
        child: Icon(
          _iconForCategory(transaction.merchantCategory),
          color: riskColor,
          size: 20,
        ),
      ),
      title: Text(
        transaction.merchantName,
        style: const TextStyle(fontWeight: FontWeight.w600),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormat('MMM d, HH:mm').format(transaction.timestamp),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              riskLabel,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: riskColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'shopping':
        return Icons.shopping_bag_outlined;
      case 'transport':
        return Icons.directions_car_outlined;
      case 'entertainment':
        return Icons.movie_outlined;
      case 'electronics':
        return Icons.devices_outlined;
      default:
        return Icons.storefront_outlined;
    }
  }
}
