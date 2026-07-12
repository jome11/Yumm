import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../data/repositories/auth_repository.dart';
import '../viewmodel/signup_bloc.dart';
import '../viewmodel/signup_event.dart';
import '../viewmodel/signup_state.dart';
import '../widgets/auth_form_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(authRepository: sl<AuthRepository>()),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.black, elevation: 0),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.success) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboard,
              (route) => false,
            );
          } else if (state.status == SignupStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Signup failed')),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: AppColors.chrome, borderRadius: BorderRadius.circular(28)),
              child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(AppStrings.signup, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(height: 6),
                  const Text(AppStrings.createAccount, style: TextStyle(fontSize: 13, color: Colors.white60)),
                  const SizedBox(height: 28),
                  AuthFormField(
                    label: AppStrings.fullName,
                    hint: 'Natnael Behaylu',
                    controller: _nameController,
                    validator: (v) => Validators.required(v, field: 'Name'),
                  ),
                  const SizedBox(height: 18),
                  AuthFormField(
                    label: AppStrings.email,
                    hint: 'you@apiary.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                  ),
                  const SizedBox(height: 18),
                  AuthFormField(
                    label: AppStrings.password,
                    hint: '••••••••',
                    controller: _passwordController,
                    obscureText: _obscure,
                    validator: Validators.password,
                    suffixIcon: IconButton(
                      icon: Icon(_obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  const SizedBox(height: 18),
                  AuthFormField(
                    label: AppStrings.confirmPassword,
                    hint: '••••••••',
                    controller: _confirmController,
                    obscureText: _obscure,
                    validator: (v) =>
                        Validators.confirmPassword(v, _passwordController.text),
                  ),
                  const SizedBox(height: 28),
                  BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return AppButton(
                        label: AppStrings.signup,
                        isLoading: state.status == SignupStatus.loading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignupBloc>().add(
                                  SignupSubmitted(
                                    name: _nameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.white60, fontSize: 13),
                          children: [
                            TextSpan(text: '${AppStrings.alreadyHaveAccount} '),
                            TextSpan(
                              text: AppStrings.login,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
