import 'package:flutter/material.dart';

import 'package:yumm/views/login_screen.dart';
import 'package:yumm/views/signup_screen.dart';
import 'package:yumm/views/dashboard_shell.dart';
import 'package:yumm/views/deploy_hive_screen.dart';
import 'package:yumm/views/hive_detail_screen.dart';
import 'package:yumm/views/hive_location_screen.dart';
import 'package:yumm/views/welcome_screen.dart';
import 'package:yumm/views/documentation_screen.dart';
import 'package:yumm/views/splash_screen.dart';
import 'package:yumm/models/hive_model.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const signup = '/signup';

  static const dashboard = '/dashboard';
  static const myHives = '/dashboard/my-hives';
  static const hiveDetail = '/dashboard/my-hives/detail';
  static const hiveLocation = '/dashboard/my-hives/location';
  static const deployHive = '/dashboard/my-hives/new';
  static const analytics = '/dashboard/analytics';
  static const feed = '/dashboard/feed';
  static const recommendations = '/dashboard/recommendations';

  static const settings = '/dashboard/settings';
  static const help = '/dashboard/help';
  static const documentation = '/dashboard/settings/documentation';
}

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
