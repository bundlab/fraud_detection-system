import 'package:equatable/equatable.dart';

class AlertModel extends Equatable {
  final String id;
  final String transactionId;
  final double riskScore;
  final String riskLevel;
  final String status; // open | investigating | resolved | false_positive
  final String? reason;
  final List<String> topFeatures;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? assignedTo;

  // Optional nested transaction summary
  final String? merchantName;
  final double? amount;
  final String? currency;

  const AlertModel({
    required this.id,
    required this.transactionId,
    required this.riskScore,
    required this.riskLevel,
    required this.status,
    this.reason,
    this.topFeatures = const [],
    required this.createdAt,
    this.resolvedAt,
    this.assignedTo,
    this.merchantName,
    this.amount,
    this.currency,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] as String,
      transactionId: json['transaction_id'] as String,
      riskScore: (json['risk_score'] as num).toDouble(),
      riskLevel: json['risk_level'] as String,
      status: json['status'] as String? ?? 'open',
      reason: json['reason'] as String?,
      topFeatures: (json['top_features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: DateTime.parse(json['created_at'] as String),
      resolvedAt: json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'] as String)
          : null,
      assignedTo: json['assigned_to'] as String?,
      merchantName: json['merchant_name'] as String?,
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      currency: json['currency'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        transactionId,
        riskScore,
        riskLevel,
        status,
        reason,
        topFeatures,
        createdAt,
        resolvedAt,
        assignedTo,
      ];
}
