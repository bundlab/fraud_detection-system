import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/transactions/presentation/screens/transactions_screen.dart';
import '../features/transactions/presentation/screens/transaction_detail_screen.dart';
import '../features/alerts/presentation/screens/alerts_screen.dart';
import '../features/cases/presentation/screens/cases_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../widgets/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Auth
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: '/transactions',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TransactionsScreen(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return TransactionDetailScreen(transactionId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/alerts',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AlertsScreen(),
            ),
          ),
          GoRoute(
            path: '/cases',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CasesScreen(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
