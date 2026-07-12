import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/theme_cubit.dart';
import '../../../data/repositories/auth_repository.dart';
import '../viewmodel/settings_cubit.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(authRepository: sl<AuthRepository>())..loadUser(),
      child: const _SettingsBody(),
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            final user = state.user;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                Text(AppStrings.settings,
                    style: AppTextStyles.h1c(context).copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 18),
                if (user != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: const Color(0xFFE3D9F5),
                          backgroundImage: user.avatarUrl.isNotEmpty ? NetworkImage(user.avatarUrl) : null,
                          child: user.avatarUrl.isEmpty
                              ? const Icon(Icons.person, color: Color(0xFF7C6FE0))
                              : null,
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name, style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                            Text(user.role, style: AppTextStyles.bodySecondaryc(context)),
                            Text(user.email, style: AppTextStyles.bodySecondaryc(context)),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 22),
                Text(AppStrings.systemPreferences,
                    style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 12),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  bloc: sl<ThemeCubit>(),
                  builder: (context, mode) {
                    return SettingsTile(
                      title: AppStrings.darkMode,
                      subtitle: AppStrings.darkModeSubtitle,
                      trailing: Switch(
                        value: mode == ThemeMode.dark,
                        activeColor: AppColors.primary,
                        onChanged: (v) => sl<ThemeCubit>().toggle(v),
                      ),
                    );
                  },
                ),
                SettingsTile(
                  title: AppStrings.notifications,
                  subtitle: AppStrings.notificationsSubtitle,
                  trailing: Switch(
                    value: state.notificationsEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (v) => context.read<SettingsCubit>().toggleNotifications(v),
                  ),
                ),
                SettingsTile(
                  title: AppStrings.healthReports,
                  subtitle: AppStrings.healthReportsSubtitle,
                  trailing: Switch(
                    value: state.healthReportsEnabled,
                    activeColor: AppColors.primary,
                    onChanged: (v) => context.read<SettingsCubit>().toggleHealthReports(v),
                  ),
                ),
                const SizedBox(height: 12),
                Text(AppStrings.helpAndSupport,
                    style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(height: 12),
                SettingsTile(
                  title: AppStrings.liveChatSupport,
                  subtitle: AppStrings.liveChatSubtitle,
                  onTap: () {},
                ),
                SettingsTile(
                  title: AppStrings.documentation,
                  subtitle: AppStrings.documentationSubtitle,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.documentation),
                ),
                SettingsTile(
                  title: AppStrings.emailSupport,
                  subtitle: AppStrings.emailSupportAddress,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await sl<AuthRepository>().logout();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
                      }
                    },
                    icon: const Icon(Icons.logout_rounded, color: AppColors.accentRed),
                    label: const Text(AppStrings.logout, style: TextStyle(color: AppColors.accentRed, fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.accentRed),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
