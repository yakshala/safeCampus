import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/monitoring/live_monitoring_screen.dart';
import '../../features/alerts/alerts_screen.dart';
import '../../features/map/map_screen.dart';
import '../../features/admin/admin_dashboard_screen.dart';
import '../../features/reports/reports_screen.dart';
/// App router configuration with custom page transitions
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // Splash Screen
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      
      // Auth Routes
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignupScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      
      // Main App Routes
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DashboardScreen(),
          transitionsBuilder: _fadeSlideTransition,
        ),
      ),
      GoRoute(
        path: '/monitoring',
        name: 'monitoring',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LiveMonitoringScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/alerts',
        name: 'alerts',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AlertsScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/map',
        name: 'map',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MapScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AdminDashboardScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/reports',
        name: 'reports',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ReportsScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
    ],
  );
});
// Custom slide transition from right
Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    )),
    child: child,
  );
}
// Combined fade and slide transition for main screens
Widget _fadeSlideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.05),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    ),
  );
}