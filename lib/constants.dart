import 'package:flutter/material.dart';

/// All of the app's colors, text styles, copy, and asset paths in
/// one place — so no screen hardcodes a hex value or a string.

class AppColors {
  AppColors._();

  // Brand — same in both modes
  static const Color primary = Color(0xFFF3A93B); // honey amber
  static const Color primaryDark = Color(0xFFB9791E);

  // Light mode surfaces
  static const Color lightBackground = Color(0xFFF1EEE6);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF1C1A16);
  static const Color lightTextSecondary = Color(0xFF7A756B);
  static const Color lightDivider = Color(0xFFE7E2D8);

  // Dark mode surfaces
  static const Color darkBackground = Color(0xFF15130E);
  static const Color darkSurface = Color(0xFF201C14);
  static const Color darkTextPrimary = Color(0xFFF5F2EA);
  static const Color darkTextSecondary = Color(0xFF9C9686);
  static const Color darkDivider = Color(0xFF322C1F);

  // Chrome that's always dark (bottom nav, login card, splash)
  static const Color chrome = Color(0xFF17150F);

  // Hive status card colors — always-dark backgrounds regardless of theme.
  static const Color statusHarvestReady = Color(0xFF544512); // olive/gold
  static const Color statusWarning = Color(0xFF5B2323); // maroon/red
  static const Color statusOptimal = Color(0xFF1B4332); // deep green
  static const Color statusRoutine = Color(0xFF1B2B4A); // navy blue

  // Accent colors used for text/icons on top of status cards or chips
  static const Color accentGold = Color(0xFFE0B341);
  static const Color accentRed = Color(0xFFE06666);
  static const Color accentGreen = Color(0xFF4CAF7D);
  static const Color accentBlue = Color(0xFF5C8DE0);

  // Insight tags on the Feed screen
  static const Color tagPriority = Color(0xFFC9A22B);
  static const Color tagWarning = Color(0xFFC0392B);
  static const Color tagRoutine = Color(0xFF2E7D5B);

  static Color statusColor(String label) {
    switch (label) {
      case 'Warning':
        return statusWarning;
      case 'Optimal':
        return statusOptimal;
      case 'Routine':
        return statusRoutine;
      default:
        return statusHarvestReady;
    }
  }

  static Color statusAccent(String label) {
    switch (label) {
      case 'Warning':
        return accentRed;
      case 'Optimal':
        return accentGreen;
      case 'Routine':
        return accentBlue;
      default:
        return accentGold;
    }
  }

  static Color insightColor(String tag) {
    switch (tag.toUpperCase()) {
      case 'PRIORITY':
        return tagPriority;
      case 'WARNING':
        return tagWarning;
      default:
        return tagRoutine;
    }
  }

  // ---- context-aware helpers so screens auto-switch with ThemeMode ----
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color background(BuildContext context) =>
      isDark(context) ? darkBackground : lightBackground;

  static Color surface(BuildContext context) =>
      isDark(context) ? darkSurface : lightSurface;

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? darkTextPrimary : lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      isDark(context) ? darkTextSecondary : lightTextSecondary;

  static Color divider(BuildContext context) =>
      isDark(context) ? darkDivider : lightDivider;
}

/// Static styles are theme-agnostic (weight/size only); use the
/// context-aware helpers below when color must flip with the theme.
class AppTextStyles {
  AppTextStyles._();

  static const TextStyle h1 = TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.15);
  static const TextStyle h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w800);
  static const TextStyle h3 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
  static const TextStyle body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle bodySecondary = TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
  static const TextStyle caption = TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.6);
  static const TextStyle statNumber = TextStyle(fontSize: 26, fontWeight: FontWeight.w800);
  static const TextStyle button = TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle h1c(BuildContext c) => h1.copyWith(color: AppColors.textPrimary(c));
  static TextStyle h2c(BuildContext c) => h2.copyWith(color: AppColors.textPrimary(c));
  static TextStyle h3c(BuildContext c) => h3.copyWith(color: AppColors.textPrimary(c));
  static TextStyle bodyc(BuildContext c) => body.copyWith(color: AppColors.textPrimary(c));
  static TextStyle bodySecondaryc(BuildContext c) => bodySecondary.copyWith(color: AppColors.textSecondary(c));
  static TextStyle captionc(BuildContext c) => caption.copyWith(color: AppColors.textSecondary(c));
  static TextStyle statNumberc(BuildContext c) => statNumber.copyWith(color: AppColors.textPrimary(c));
}

/// Static copy used across the app.
class AppStrings {
  AppStrings._();

  static const appName = 'Yumm';
  static const tagline = 'The Digital Apiary';

  // Welcome / marketing screen
  static const welcomeHeadline1 = 'The';
  static const welcomeHeadline2 = 'Intelligence';
  static const welcomeHeadline3 = 'Behind  the';
  static const welcomeHeadline4 = 'Hive.';
  static const welcomeSubtitle =
      "Harmonizing high-tech precision with the organic wisdom of nature. We don't just monitor data we nurture ecosystems.";
  static const welcomeCtaTitle = 'Ready to evolve\nyour apiary?';
  static const welcomeCtaSubtitle =
      'Join thousands of professional beekeepers leveraging the power of The Digital Apiary.';
  static const getStartedNow = 'Get Started Now';
  static const contactSales = 'Contact Sales';

  // Auth
  static const login = 'Login';
  static const signup = 'Sign Up';
  static const email = 'Email';
  static const emailAddress = 'EMAIL ADDRESS';
  static const password = 'PASSWORD';
  static const confirmPassword = 'Confirm Password';
  static const fullName = 'Full Name';
  static const dontHaveAccount = "Don't have an account?";
  static const alreadyHaveAccount = 'Already have an account?';
  static const welcomeBack = 'Nurturing the digital ecosystem';
  static const createAccount = 'Join thousands of professional beekeepers.';
  static const rememberMe = 'Remember me';
  static const forgotPassword = 'Forgot Password?';
  static const signIn = 'Sign In';
  static const newToApiary = 'New to the apiary?';

  // Dashboard / bottom nav
  static const home = 'Home';
  static const overview = 'Overview';
  static const myHives = 'My Hives';
  static const hives = 'Hives';
  static const analytics = 'Analytics';
  static const feed = 'Feed';
  static const recommendations = 'Recommendations';
  static const settings = 'Settings';
  static const help = 'Help';
  static const logout = 'Logout';

  static const goodMorning = 'GOOD MORNING';
  static const seasonYield = 'SEASON YIELD';
  static const scanQrCode = 'Scan QR code';
  static const scanQrCodeSubtitle = 'Get hive Information';
  static const fleetStatus = 'Fleet Status';
  static const viewAll = 'View  All';
  static const latestAlert = 'Latest Alert';

  static const digitalApiaryManagement = 'DIGITAL APIARY MANAGEMENT';
  static const deployNewHive = 'Deploy New Hive';
  static const registerNewHive = 'Register New Hive';
  static const registerNewHiveSubtitle = 'Extend your apiary network with detailed colony parameters.';
  static const hiveIdentity = 'HIVE IDENTITY';
  static const hiveNameLabel = 'Hive Name';
  static const apiaryLocationLabel = 'Apiary Location';
  static const selectHiveConfiguration = 'SELECT HIVE CONFIGURATION';
  static const expertTip = 'Expert Tip';
  static const expertTipBody =
      'Placing your hive near a water source can increase initial colony strength by up to 15% in the first month.';
  static const searchHint = 'Search apiaries or hive IDs..';
  static const initializeSensorArray = 'Initialize sensor array';
  static const viewDetails = 'View Details';

  static const totalYield = 'TOTAL YIELD';
  static const vsLastMonth = 'VS LAST MONTH';
  static const envRisk = 'ENV RISK';
  static const totalHives = 'TOTAL HIVES';
  static const avgHealth = 'AVG HEALTH';
  static const apiaryEfficiency = 'Apiary Efficiency';
  static const yieldPrediction = 'YIELD PREDICTION';

  static const healthScore = 'HEALTH SCORE';
  static const productivityAnalysis = 'PRODUCTIVITY ANALYSIS';
  static const estHoneyYield = 'EST .HONEY YIELD';
  static const preGeneratedHiveId = 'Pre Generated Hive ID';
  static const hiveIdNote =
      'This unique identifier is linked to your hardware tag and cannot be changed after registration.';
  static const viewLocation = 'View Location';

  static const intelligence = 'Intelligence';
  static const askAi = 'Ask YummBeeGuard Ai anthing...';

  static const systemPreferences = 'System Preferences';
  static const darkMode = 'Dark Mode';
  static const darkModeSubtitle = 'Switch UI appearance';
  static const notifications = 'Notifications';
  static const notificationsSubtitle = 'Enable Email Alerts';
  static const healthReports = 'Health Reports';
  static const healthReportsSubtitle = 'Weekly hive analytics';
  static const helpAndSupport = 'Help  & Support';
  static const liveChatSupport = 'Live Chat Support';
  static const liveChatSubtitle = 'avg . response time : 3 min';
  static const documentation = 'Documentation';
  static const documentationSubtitle = 'Guides ,API docs & tutorials';
  static const emailSupport = 'Email Support';
  static const emailSupportAddress = 'Support@yumm-hive.io';

  static const gettingStarted = 'Getting Started';
  static const gettingStartedBody =
      'Understand dashboard navigation, hive onboarding , and daily monitoring basics.';
  static const sensorDiagnostics = 'Sensor Diagnostics';
  static const sensorDiagnosticsBody =
      'Learn how to interpret signal issues, delayed telemetry, and data quality alerts.';
  static const accessAndSecurity = 'Access and Security';
  static const accessAndSecurityBody =
      'Manage account protection, password resets, and safe team collaboration practices.';
  static const aiConfiguration = 'AI Configuration';
  static const apiKey = 'Api Key';
  static const model = 'MODEL';
}

/// Asset path constants, matching the exact filenames in /assets.
class AppAssets {
  AppAssets._();

  /// Hexagon honey-drip mark, transparent background.
  static const iconTransparent = 'assets/659135f7-fdf0-4ac9-90a4-8ef49ef1c858_1.png';

  /// Hexagon honey-drip mark, pre-composited on amber (app icon/favicon).
  static const iconOnAmber = 'assets/Yumm_Favicon 1.png';

  /// "Yumm" wordmark, transparent background, bubble lettering.
  static const wordmarkTransparent = 'assets/3bcb98cd-8569-493d-b791-7947e557b2d8_1.png';

  /// "Yumm" wordmark, pre-composited on amber.
  static const wordmarkOnAmber = 'assets/Yumm 1.png';
}
