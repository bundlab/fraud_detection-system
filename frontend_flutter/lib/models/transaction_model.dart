import 'package:equatable/equatable.dart';

class TransactionModel extends Equatable {
  final String id;
  final String userId;
  final double amount;
  final String currency;
  final String merchantName;
  final String? merchantCategory;
  final DateTime timestamp;
  final String? deviceId;
  final String? ipAddress;
  final String? location;
  final String status; // pending | completed | failed | flagged
  final double? riskScore;
  final String? riskLevel; // low | medium | high | critical

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.merchantName,
    this.merchantCategory,
    required this.timestamp,
    this.deviceId,
    this.ipAddress,
    this.location,
    required this.status,
    this.riskScore,
    this.riskLevel,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      merchantName: json['merchant_name'] as String,
      merchantCategory: json['merchant_category'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      deviceId: json['device_id'] as String?,
      ipAddress: json['ip_address'] as String?,
      location: json['location'] as String?,
      status: json['status'] as String? ?? 'completed',
      riskScore: json['risk_score'] != null
          ? (json['risk_score'] as num).toDouble()
          : null,
      riskLevel: json['risk_level'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'currency': currency,
      'merchant_name': merchantName,
      'merchant_category': merchantCategory,
      'timestamp': timestamp.toIso8601String(),
      'device_id': deviceId,
      'ip_address': ipAddress,
      'location': location,
      'status': status,
      'risk_score': riskScore,
      'risk_level': riskLevel,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        currency,
        merchantName,
        merchantCategory,
        timestamp,
        deviceId,
        ipAddress,
        location,
        status,
        riskScore,
        riskLevel,
      ];
}
