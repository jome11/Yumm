import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/viewmodels/deploy_hive_cubit.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/views/validators.dart';
import 'package:yumm/views/widgets/glass_card.dart';

class _HiveTypeOption {
  final String title;
  final String subtitle;
  final IconData icon;
  const _HiveTypeOption(this.title, this.subtitle, this.icon);
}

const _hiveTypes = [
  _HiveTypeOption('Langstroth', 'Standard vertical stack', Icons.hexagon_outlined),
  _HiveTypeOption('Top Bar', 'Horizontal management', Icons.remove_rounded),
  _HiveTypeOption('Warre', "Natural-comb \"People's Hive\"", Icons.menu_rounded),
];

const _apiaryLocations = [
  'North Field',
  'South Meadow',
  'East Grove',
  'West Slope',
  'Alpha Ridge',
  'North Valley Orchard',
];

class DeployHiveScreen extends StatelessWidget {
  const DeployHiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeployHiveCubit(),
      child: const _DeployHiveBody(),
    );
  }
}

class _DeployHiveBody extends StatefulWidget {
  const _DeployHiveBody();

  @override
  State<_DeployHiveBody> createState() => _DeployHiveBodyState();
}

class _DeployHiveBodyState extends State<_DeployHiveBody> {
  final _formKey = GlobalKey<FormState>();
  final _hiveNameController = TextEditingController(text: 'Hive-07');
  String _apiaryLocation = _apiaryLocations.first;
  int _selectedType = 0;

  @override
  void dispose() {
    _hiveNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.registerNewHive)),
      body: BlocConsumer<DeployHiveCubit, DeployHiveState>(
        listener: (context, state) {
          if (state.status == DeployHiveStatus.success) {
            Navigator.pop(context, true);
          } else if (state.status == DeployHiveStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Failed to deploy hive.')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.registerNewHiveSubtitle, style: AppTextStyles.bodySecondaryc(context)),
                  const SizedBox(height: 20),

                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.hiveIdentity,
                            style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                        const SizedBox(height: 16),
                        Text(AppStrings.hiveNameLabel, style: AppTextStyles.bodyc(context).copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _hiveNameController,
                          style: AppTextStyles.bodyc(context),
                          validator: (v) => Validators.required(v, field: 'Hive name'),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.background(context),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.divider(context))),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.divider(context))),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(AppStrings.apiaryLocationLabel, style: AppTextStyles.bodyc(context).copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.background(context),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.divider(context)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _apiaryLocation,
                              isExpanded: true,
                              dropdownColor: AppColors.surface(context),
                              style: AppTextStyles.bodyc(context),
                              items: _apiaryLocations.map((loc) => DropdownMenuItem(value: loc, child: Text(loc))).toList(),
                              onChanged: (v) => setState(() => _apiaryLocation = v ?? _apiaryLocation),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.selectHiveConfiguration,
                            style: TextStyle(color: AppColors.textSecondary(context), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
                        const SizedBox(height: 14),
                        ...List.generate(_hiveTypes.length, (i) {
                          final option = _hiveTypes[i];
                          final selected = i == _selectedType;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () => setState(() => _selectedType = i),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.background(context),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: selected ? AppColors.primary : AppColors.divider(context),
                                    width: selected ? 1.6 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      selected ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked_rounded,
                                      color: selected ? AppColors.primary : AppColors.textSecondary(context),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(option.title, style: AppTextStyles.h3c(context)),
                                          const SizedBox(height: 2),
                                          Text(option.subtitle, style: AppTextStyles.bodySecondaryc(context)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(AppStrings.expertTip,
                                  style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w700, fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(AppStrings.expertTipBody, style: AppTextStyles.bodySecondaryc(context)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status == DeployHiveStatus.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<DeployHiveCubit>().deploy(
                                      hiveName: _hiveNameController.text.trim(),
                                      apiaryLocation: _apiaryLocation,
                                      hiveType: _hiveTypes[_selectedType].title,
                                    );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: state.status == DeployHiveStatus.loading
                          ? const SizedBox(
                              height: 20, width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                          : const Text(AppStrings.deployNewHive, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      borderRadius: 20,
      child: child,
    );
  }
}
