import 'package:flutter/material.dart';
import 'package:yumm/constants.dart';

class DocumentationScreen extends StatefulWidget {
  const DocumentationScreen({super.key});

  @override
  State<DocumentationScreen> createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  bool _obscureKey = true;
  String _model = 'GPT-5.4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.documentation,
            style: AppTextStyles.h2c(context).copyWith(fontStyle: FontStyle.italic)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        children: [
          _DocCard(title: AppStrings.gettingStarted, body: AppStrings.gettingStartedBody),
          _DocCard(title: AppStrings.sensorDiagnostics, body: AppStrings.sensorDiagnosticsBody),
          _DocCard(title: AppStrings.accessAndSecurity, body: AppStrings.accessAndSecurityBody),
          const SizedBox(height: 12),
          Text(AppStrings.aiConfiguration, style: AppTextStyles.h3c(context)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.apiKey, style: AppTextStyles.bodyc(context).copyWith(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(color: AppColors.background(context), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _obscureKey ? '••••••••••••••••••••' : 'sk-yumm-8ad2f91c3e77',
                          style: AppTextStyles.bodyc(context),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(_obscureKey ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary(context), size: 20),
                        onPressed: () => setState(() => _obscureKey = !_obscureKey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(18)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.model, style: AppTextStyles.captionc(context)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(color: AppColors.background(context), borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _model,
                      isExpanded: true,
                      dropdownColor: AppColors.surface(context),
                      style: AppTextStyles.bodyc(context),
                      items: ['GPT-5.4', 'GPT-5.1 Mini', 'Claude Sonnet 5']
                          .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                          .toList(),
                      onChanged: (v) => setState(() => _model = v ?? _model),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocCard extends StatelessWidget {
  final String title;
  final String body;
  const _DocCard({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.surface(context), borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h3c(context).copyWith(fontStyle: FontStyle.italic)),
          const SizedBox(height: 8),
          Text(body, style: AppTextStyles.bodySecondaryc(context)),
        ],
      ),
    );
  }
}
