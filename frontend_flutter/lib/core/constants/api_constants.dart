class ApiConstants {
  ApiConstants._();

  // Change this to your backend URL
  static const String baseUrl = 'http://10.0.2.2:8000'; // Android emulator
  // static const String baseUrl = 'http://localhost:8000'; // iOS simulator / desktop
  // static const String baseUrl = 'https://api.yourdomain.com'; // Production

  static const String apiVersion = '/api/v1';

  // Auth
  static const String login = '$apiVersion/auth/login';
  static const String register = '$apiVersion/auth/register';
  static const String refreshToken = '$apiVersion/auth/refresh';
  static const String me = '$apiVersion/auth/me';

  // Transactions
  static const String transactions = '$apiVersion/transactions';
  static String transactionById(String id) => '$transactions/$id';

  // Fraud
  static const String scoreTransaction = '$apiVersion/fraud/score';
  static const String explainScore = '$apiVersion/fraud/explain';

  // Alerts
  static const String alerts = '$apiVersion/alerts';
  static String alertById(String id) => '$alerts/$id';

  // Cases
  static const String cases = '$apiVersion/cases';
  static String caseById(String id) => '$cases/$id';

  // Dashboard
  static const String dashboardStats = '$apiVersion/dashboard/stats';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 20);
}
