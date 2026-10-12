import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';

class CasesScreen extends ConsumerWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Placeholder cases
    final cases = [
      _CaseItem(
        id: 'CASE-1042',
        title: 'High-value Amazon purchase',
        status: 'open',
        priority: 'critical',
        assignee: 'You',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        transactionCount: 1,
      ),
      _CaseItem(
        id: 'CASE-1038',
        title: 'Multiple failed logins + spend',
        status: 'investigating',
        priority: 'high',
        assignee: 'Sarah K.',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        transactionCount: 4,
      ),
      _CaseItem(
        id: 'CASE-1029',
        title: 'Card testing pattern',
        status: 'closed',
        priority: 'medium',
        assignee: 'John D.',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        transactionCount: 12,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Investigation Cases'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Create new case
        },
        icon: const Icon(Icons.add),
        label: const Text('New Case'),
      ),
      body: cases.isEmpty
          ? const Center(child: Text('No cases yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cases.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final c = cases[index];
                return _CaseCard(caseItem: c);
              },
            ),
    );
  }
}

class _CaseItem {
  final String id;
  final String title;
  final String status;
  final String priority;
  final String assignee;
  final DateTime createdAt;
  final int transactionCount;

  _CaseItem({
    required this.id,
    required this.title,
    required this.status,
    required this.priority,
    required this.assignee,
    required this.createdAt,
    required this.transactionCount,
  });
}

class _CaseCard extends StatelessWidget {
  final _CaseItem caseItem;

  const _CaseCard({required this.caseItem});

  Color get _priorityColor {
    switch (caseItem.priority) {
      case 'critical':
        return AppColors.riskCritical;
      case 'high':
        return AppColors.riskHigh;
      case 'medium':
        return AppColors.riskMedium;
      default:
        return AppColors.riskLow;
    }
  }

  Color get _statusColor {
    switch (caseItem.status) {
      case 'open':
        return AppColors.danger;
      case 'investigating':
        return AppColors.warning;
      case 'closed':
        return AppColors.success;
      default:
        return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigate to case detail
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    caseItem.id,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      caseItem.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                caseItem.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.person_outline,
                      size: 16, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(
                    caseItem.assignee,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.receipt_long,
                      size: 16, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(
                    '${caseItem.transactionCount} txns',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const Spacer(),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _priorityColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    caseItem.priority,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _priorityColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                DateFormat('MMM d, yyyy • HH:mm').format(caseItem.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textTertiary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
