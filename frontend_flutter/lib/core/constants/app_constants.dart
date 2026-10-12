class AppConstants {
  AppConstants._();

  static const String appName = 'FraudGuard';
  static const String appVersion = '1.0.0';

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';

  // Pagination
  static const int defaultPageSize = 20;

  // Risk thresholds (must match backend)
  static const double riskLowMax = 0.35;
  static const double riskMediumMax = 0.65;
  static const double riskHighMax = 0.85;
}
