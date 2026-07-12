import 'package:flutter/material.dart';

import '../../features/auth/view/login_screen.dart';
import '../../features/auth/view/signup_screen.dart';
import '../../features/dashboard/view/dashboard_shell.dart';
import '../../features/my_hives/view/deploy_hive_screen.dart';
import '../../features/my_hives/view/hive_detail_screen.dart';
import '../../features/my_hives/view/hive_location_screen.dart';
import '../../features/onboarding/view/welcome_screen.dart';
import '../../features/settings/view/documentation_screen.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../data/models/hive_model.dart';
import 'app_routes.dart';

/// Single source of truth mapping route names -> screens.
/// Used by MaterialApp's onGenerateRoute, so every navigation call
/// elsewhere in the app stays a plain Navigator.pushNamed/push/pop.
class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      // The main tabs (My Hives / Analytics / Feed / Settings) live as
      // tabs inside DashboardShell; these routes are kept for deep
      // links (e.g. a notification) and simply land on the shell.
      case AppRoutes.dashboard:
      case AppRoutes.myHives:
      case AppRoutes.analytics:
      case AppRoutes.feed:
        return MaterialPageRoute(builder: (_) => const DashboardShell());

      case AppRoutes.hiveDetail:
        final hiveId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => HiveDetailScreen(hiveId: hiveId));

      case AppRoutes.hiveLocation:
        final hive = settings.arguments as HiveModel;
        return MaterialPageRoute(builder: (_) => HiveLocationScreen(hive: hive));

      case AppRoutes.deployHive:
        return MaterialPageRoute(builder: (_) => const DeployHiveScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const DashboardShell());

      case AppRoutes.documentation:
        return MaterialPageRoute(builder: (_) => const DocumentationScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
