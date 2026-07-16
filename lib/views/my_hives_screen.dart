import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/views/widgets/error_view.dart';
import 'package:yumm/views/widgets/loading_indicator.dart';
import 'package:yumm/repositories/hive_repository.dart';
import 'package:yumm/viewmodels/my_hives_bloc.dart';
import 'package:yumm/viewmodels/my_hives_event.dart';
import 'package:yumm/viewmodels/my_hives_state.dart';
import 'package:yumm/views/widgets/hive_filter_sheet.dart';
import 'package:yumm/views/widgets/hive_list_tile.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/routes.dart';

class MyHivesScreen extends StatelessWidget {
  const MyHivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyHivesBloc(hiveRepository: context.read<HiveRepository>())..add(const MyHivesRequested()),
      child: const _MyHivesBody(),
    );
  }
}

class _MyHivesBody extends StatefulWidget {
  const _MyHivesBody();

  @override
  State<_MyHivesBody> createState() => _MyHivesBodyState();
}

class _MyHivesBodyState extends State<_MyHivesBody> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.digitalApiaryManagement, style: AppTextStyles.captionc(context)),
              Text(AppStrings.myHives,
                  style: AppTextStyles.h1c(context).copyWith(fontStyle: FontStyle.italic)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final deployed = await Navigator.pushNamed(context, AppRoutes.deployHive);
                    if (deployed == true && context.mounted) {
                      context.read<MyHivesBloc>().add(const MyHivesRequested());
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const Text(AppStrings.deployNewHive, style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v.toLowerCase()),
                style: TextStyle(color: AppColors.textPrimary(context)),
                decoration: InputDecoration(
                  hintText: AppStrings.searchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: AppColors.surface(context),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 14),
              BlocBuilder<MyHivesBloc, MyHivesState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      _pillButton(
                        context,
                        icon: Icons.filter_list_rounded,
                        label: 'Filter',
                        onTap: () async {
                          final result = await showModalBottomSheet(
                            context: context,
                            backgroundColor: AppColors.surface(context),
                            builder: (_) => HiveFilterSheet(currentFilter: state.filter),
                          );
                          if (context.mounted) {
                            context.read<MyHivesBloc>().add(MyHivesFilterChanged(result));
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      _pillButton(
                        context,
                        icon: Icons.swap_vert_rounded,
                        label: 'Sort',
                        onTap: () async {
                          final result = await showModalBottomSheet<MyHivesSort>(
                            context: context,
                            backgroundColor: AppColors.surface(context),
                            builder: (_) => HiveSortSheet(currentSort: state.sort),
                          );
                          if (result != null && context.mounted) {
                            context.read<MyHivesBloc>().add(MyHivesSortChanged(result));
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<MyHivesBloc, MyHivesState>(
                  builder: (context, state) {
                    if (state.status == MyHivesStatus.loading || state.status == MyHivesStatus.initial) {
                      return const LoadingIndicator();
                    }
                    if (state.status == MyHivesStatus.failure) {
                      return ErrorView(
                        message: state.errorMessage ?? 'Failed to load hives.',
                        onRetry: () => context.read<MyHivesBloc>().add(const MyHivesRequested()),
                      );
                    }

                    final hives = state.visibleHives
                        .where((h) =>
                            _query.isEmpty ||
                            h.id.toLowerCase().contains(_query) ||
                            h.apiaryName.toLowerCase().contains(_query))
                        .toList();

                    if (hives.isEmpty) {
                      return Center(child: Text('No hives match this search.', style: AppTextStyles.bodySecondaryc(context)));
                    }

                    return RefreshIndicator(
                      onRefresh: () async => context.read<MyHivesBloc>().add(const MyHivesRequested()),
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 4, bottom: 24),
                        itemCount: hives.length,
                        itemBuilder: (context, i) {
                          final hive = hives[i];
                          return HiveListTile(
                            hive: hive,
                            onTap: () => Navigator.pushNamed(context, AppRoutes.hiveDetail, arguments: hive.id),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pillButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: AppColors.textPrimary(context)),
        label: Text(label, style: TextStyle(color: AppColors.textPrimary(context))),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface(context),
          side: BorderSide(color: AppColors.divider(context)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
      ),
    );
  }
}
