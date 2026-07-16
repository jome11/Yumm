import 'package:flutter/material.dart';

import 'package:yumm/views/analytics_screen.dart';
import 'package:yumm/views/feed_screen.dart';
import 'package:yumm/views/my_hives_screen.dart';
import 'package:yumm/views/settings_screen.dart';
import 'overview_screen.dart';
import 'package:yumm/constants.dart';

/// Bottom-nav shell hosting the five tabs: Home / Hives / Analytics / Feed / Settings.
/// The nav bar is always dark chrome, independent of the app's ThemeMode.
class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _index = 0;

  static const _tabs = [
    OverviewScreen(),
    MyHivesScreen(),
    AnalyticsScreen(),
    FeedScreen(),
    SettingsScreen(),
  ];

  static const _icons = [
    Icons.home_rounded,
    Icons.hexagon_rounded,
    Icons.bar_chart_rounded,
    Icons.podcasts_rounded,
    Icons.settings_rounded,
  ];

  static const _labels = ['Home', 'Hives', 'Analytics', 'Feed', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.chrome,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final selected = i == _index;
                final color = selected ? AppColors.primary : Colors.white38;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _index = i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_icons[i], color: color, size: 22),
                        const SizedBox(height: 4),
                        Text(
                          _labels[i],
                          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
