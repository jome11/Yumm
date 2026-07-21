import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/views/widgets/app_button.dart';
import 'package:yumm/viewmodels/signup_bloc.dart';
import 'package:yumm/viewmodels/signup_event.dart';
import 'package:yumm/viewmodels/signup_state.dart';
import 'package:yumm/views/widgets/auth_form_field.dart';
import 'package:yumm/views/widgets/honeycomb_pattern.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/views/dashboard_shell.dart';
import 'package:yumm/views/validators.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
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
      backgroundColor: AppColors.authBackground,
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.success) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashboardShell()),
              (route) => false,
            );
          } else if (state.status == SignupStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Signup failed')),
            );
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: -30,
              left: -30,
              child: HoneycombPattern(size: 160, color: Colors.black.withOpacity(0.15)),
            ),
            Positioned(
              bottom: -30,
              right: -30,
              child: HoneycombPattern(size: 160, color: Colors.black.withOpacity(0.15)),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.black),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(AppAssets.iconTransparent, width: 30, height: 30, fit: BoxFit.contain),
                        const SizedBox(width: 8),
                        const Text(AppStrings.appName,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
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
                            prefixIcon: const Icon(Icons.person_outline_rounded, color: Color(0xFF7A5A22), size: 20),
                            validator: (v) => Validators.required(v, field: 'Name'),
                          ),
                          const SizedBox(height: 18),
                          AuthFormField(
                            label: AppStrings.email,
                            hint: 'you@apiary.com',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.mail_outline_rounded, color: Color(0xFF7A5A22), size: 20),
                            validator: Validators.email,
                          ),
                          const SizedBox(height: 18),
                          AuthFormField(
                            label: AppStrings.password,
                            hint: '••••••••',
                            controller: _passwordController,
                            obscureText: _obscure,
                            prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF7A5A22), size: 20),
                            validator: Validators.password,
                            suffixIcon: IconButton(
                              icon: Icon(_obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                                  color: const Color(0xFF7A5A22)),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          const SizedBox(height: 18),
                          AuthFormField(
                            label: AppStrings.confirmPassword,
                            hint: '••••••••',
                            controller: _confirmController,
                            obscureText: _obscure,
                            prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF7A5A22), size: 20),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
