import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumm/theme/app_colors.dart' as new_colors;

class AppColors {
  AppColors._();

  static const Color primary = new_colors.AppColors.gold;
  static const Color primaryDark = new_colors.AppColors.goldMuted;

  static const Color lightBackground = new_colors.AppColors.lightBackground;
  static const Color lightSurface = new_colors.AppColors.lightSurface;
  static const Color lightTextPrimary = new_colors.AppColors.lightTextPrimary;
  static const Color lightTextSecondary = new_colors.AppColors.lightTextSecondary;
  static const Color lightDivider = new_colors.AppColors.lightSurfaceBorder;

  static const Color darkBackground = new_colors.AppColors.darkBackground;
  static const Color darkSurface = new_colors.AppColors.darkSurface;
  static const Color darkTextPrimary = new_colors.AppColors.darkTextPrimary;
  static const Color darkTextSecondary = new_colors.AppColors.darkTextSecondary;
  static const Color darkDivider = new_colors.AppColors.darkSurfaceBorder;

  static const Color chrome = Color(0xFF070B08); // Darker version of darkBackground

  static const Color honeycombGold = Color(0xFFFDB827);
  static const Color authBackground = Color(0xFFFDB827);

  static const Color statusHarvestReady = new_colors.AppColors.gold;
  static const Color statusWarning = new_colors.AppColors.warning;
  static const Color statusOptimal = new_colors.AppColors.success;
  static const Color statusRoutine = new_colors.AppColors.info;

  static const Color accentGold = new_colors.AppColors.gold;
  static const Color accentRed = new_colors.AppColors.warning;
  static const Color accentGreen = new_colors.AppColors.success;
  static const Color accentBlue = new_colors.AppColors.info;

  static const Color tagPriority = new_colors.AppColors.gold;
  static const Color tagWarning = new_colors.AppColors.warning;
  static const Color tagRoutine = new_colors.AppColors.success;

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

class AppTextStyles {
  AppTextStyles._();

  static TextStyle h1 = GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w700, height: 1.15);
  static TextStyle h2 = GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700);
  static TextStyle h3 = GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w600);
  static TextStyle body = GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle bodySecondary = GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400);
  static TextStyle caption = GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 1.6);
  static TextStyle statNumber = GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700);
  static TextStyle button = GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);

  static TextStyle h1c(BuildContext c) => h1.copyWith(color: AppColors.textPrimary(c));
  static TextStyle h2c(BuildContext c) => h2.copyWith(color: AppColors.textPrimary(c));
  static TextStyle h3c(BuildContext c) => h3.copyWith(color: AppColors.textPrimary(c));
  static TextStyle bodyc(BuildContext c) => body.copyWith(color: AppColors.textPrimary(c));
  static TextStyle bodySecondaryc(BuildContext c) => bodySecondary.copyWith(color: AppColors.textSecondary(c));
  static TextStyle captionc(BuildContext c) => caption.copyWith(color: AppColors.textSecondary(c));
  static TextStyle statNumberc(BuildContext c) => statNumber.copyWith(color: AppColors.textPrimary(c));
}

class AppStrings {
  AppStrings._();

  static const appName = 'Yumm';
  static const tagline = 'The Digital Apiary';

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

class AppAssets {
  AppAssets._();

  static const iconTransparent = 'assets/659135f7-fdf0-4ac9-90a4-8ef49ef1c858_1.png';

  static const iconOnAmber = 'assets/Yumm_Favicon 1.png';

  static const wordmarkTransparent = 'assets/3bcb98cd-8569-493d-b791-7947e557b2d8_1.png';

  static const wordmarkOnAmber = 'assets/Yumm 1.png';
}
