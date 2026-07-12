import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/hive_model.dart';
import '../viewmodel/my_hives_event.dart';

/// Bottom sheet for the "Filter" action on My Hives.
/// Returns the selected status (or null for "All") via Navigator.pop.
class HiveFilterSheet extends StatelessWidget {
  final HiveStatus? currentFilter;
  const HiveFilterSheet({super.key, required this.currentFilter});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filter by status', style: AppTextStyles.h3c(context)),
            const SizedBox(height: 12),
            _option(context, 'All', null),
            _option(context, 'Optimal', HiveStatus.optimal),
            _option(context, 'Harvest Ready', HiveStatus.harvestReady),
            _option(context, 'Warning', HiveStatus.warning),
            _option(context, 'Routine', HiveStatus.routine),
          ],
        ),
      ),
    );
  }

  Widget _option(BuildContext context, String label, HiveStatus? value) {
    final selected = currentFilter == value;
    return ListTile(
      title: Text(label, style: TextStyle(color: AppColors.textPrimary(context))),
      trailing: selected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () => Navigator.pop(context, value),
    );
  }
}

/// Bottom sheet for the "Sort" action on My Hives.
class HiveSortSheet extends StatelessWidget {
  final MyHivesSort currentSort;
  const HiveSortSheet({super.key, required this.currentSort});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sort by', style: AppTextStyles.h3c(context)),
            const SizedBox(height: 12),
            _option(context, 'Hive ID', MyHivesSort.idAscending),
            _option(context, 'Colony strength', MyHivesSort.strengthDescending),
            _option(context, 'Temperature', MyHivesSort.temperatureDescending),
          ],
        ),
      ),
    );
  }

  Widget _option(BuildContext context, String label, MyHivesSort value) {
    final selected = currentSort == value;
    return ListTile(
      title: Text(label, style: TextStyle(color: AppColors.textPrimary(context))),
      trailing: selected ? const Icon(Icons.check, color: AppColors.primary) : null,
      onTap: () => Navigator.pop(context, value),
    );
  }
}
