import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../models/transaction_model.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/risk_filter_chips.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  String _selectedFilter = 'all';

  // Placeholder data – will come from provider later
  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: 'txn_001',
      userId: 'usr_1',
      amount: 1249.99,
      currency: 'USD',
      merchantName: 'Amazon Marketplace',
      merchantCategory: 'Shopping',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      status: 'flagged',
      riskScore: 0.92,
      riskLevel: 'critical',
      location: 'Lagos, NG',
    ),
    TransactionModel(
      id: 'txn_002',
      userId: 'usr_1',
      amount: 45.00,
      currency: 'USD',
      merchantName: 'Uber',
      merchantCategory: 'Transport',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'completed',
      riskScore: 0.12,
      riskLevel: 'low',
      location: 'Lagos, NG',
    ),
    TransactionModel(
      id: 'txn_003',
      userId: 'usr_2',
      amount: 899.00,
      currency: 'USD',
      merchantName: 'Unknown Merchant',
      merchantCategory: 'Other',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      status: 'flagged',
      riskScore: 0.78,
      riskLevel: 'high',
      location: 'Abuja, NG',
    ),
    TransactionModel(
      id: 'txn_004',
      userId: 'usr_1',
      amount: 19.99,
      currency: 'USD',
      merchantName: 'Netflix',
      merchantCategory: 'Entertainment',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: 'completed',
      riskScore: 0.08,
      riskLevel: 'low',
    ),
    TransactionModel(
      id: 'txn_005',
      userId: 'usr_3',
      amount: 320.50,
      currency: 'USD',
      merchantName: 'Apple Store',
      merchantCategory: 'Electronics',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
      status: 'completed',
      riskScore: 0.41,
      riskLevel: 'medium',
    ),
  ];

  List<TransactionModel> get _filtered {
    if (_selectedFilter == 'all') return _transactions;
    return _transactions
        .where((t) => t.riskLevel == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Search
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          RiskFilterChips(
            selected: _selectedFilter,
            onSelected: (value) {
              setState(() => _selectedFilter = value);
            },
          ),
          const Divider(height: 1),

          // List
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No transactions found',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final txn = _filtered[index];
                        return TransactionTile(
                          transaction: txn,
                          onTap: () {
                            context.push('/transactions/${txn.id}');
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
