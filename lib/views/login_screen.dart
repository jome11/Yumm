import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/viewmodels/login_bloc.dart';
import 'package:yumm/viewmodels/login_event.dart';
import 'package:yumm/viewmodels/login_state.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/views/dashboard_shell.dart';
import 'package:yumm/views/signup_screen.dart';
import 'package:yumm/views/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB08A4A)),
      prefixIcon: Icon(icon, color: const Color(0xFF7A5A22), size: 20),
      filled: true,
      fillColor: const Color(0xFFF5DFAE),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashboardShell()), (route) => false);
          } else if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
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
                      children: [
                        const Text(AppStrings.login,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
                        const SizedBox(height: 6),
                        const Text(AppStrings.welcomeBack,
                            style: TextStyle(fontSize: 13, color: Colors.white60), textAlign: TextAlign.center),
                        const SizedBox(height: 28),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppStrings.emailAddress,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.6)),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                          style: const TextStyle(color: Color(0xFF1C1A16)),
                          decoration: _decoration('john@yumm.com', Icons.mail_outline_rounded),
                        ),
                        const SizedBox(height: 18),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(AppStrings.password,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.6)),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscure,
                          validator: Validators.password,
                          style: const TextStyle(color: Color(0xFF1C1A16)),
                          decoration: _decoration('••••••••', Icons.lock_outline_rounded).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  color: const Color(0xFF7A5A22)),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (v) => setState(() => _rememberMe = v ?? false),
                                    activeColor: AppColors.primary,
                                    side: const BorderSide(color: Colors.white38),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(AppStrings.rememberMe, style: TextStyle(color: Colors.white70, fontSize: 13)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(AppStrings.forgotPassword,
                                  style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state.status == LoginStatus.loading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<LoginBloc>().add(LoginSubmitted(
                                                email: _emailController.text.trim(),
                                                password: _passwordController.text,
                                              ));
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  minimumSize: const Size.fromHeight(54),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                ),
                                child: state.status == LoginStatus.loading
                                    ? const SizedBox(
                                        height: 20, width: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text(AppStrings.signIn, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                                          SizedBox(width: 6),
                                          Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.white),
                                        ],
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.white12),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen())),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Colors.white60, fontSize: 13),
                              children: [
                                TextSpan(text: '${AppStrings.newToApiary} '),
                                TextSpan(text: AppStrings.signup, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
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
        ),
      ),
    );
  }
}
