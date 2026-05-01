import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../utils/auth_error_localizer.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool _isLogin = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mode = GoRouterState.of(context).uri.queryParameters['mode'];
    if (mode == 'register') _isLogin = false;
    if (mode == 'login') _isLogin = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInStateProvider);
    final notifier = ref.read(signInStateProvider.notifier);

    final isLoading = signInState.isLoading;
    final t = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    String? serverError;
    if (signInState.hasError) {
      final error = signInState.error;
      if (error is AuthException) {
        serverError = localizeAuthError(error, t);
      } else {
        serverError = t.errorUnknown;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.go(RouteNames.landing),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  Text(
                    _isLogin ? t.logInToYourAccount : t.createANewAccount,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),

                  const SizedBox(height: AppSpacing.huge),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: t.email,
                      errorText: _emailError,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.base),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() => _passwordError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: t.password,
                      errorText: _passwordError,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.base),

                  if (serverError != null) ...[
                    Text(
                      serverError,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.base),
                  ],

                  ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    child: Text(_isLogin ? t.login : t.createAccount),
                  ),

                  const Spacer(),

                  Center(child: Text(t.orContinueWith)),

                  const SizedBox(height: AppSpacing.base),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading ? null : notifier.signInGoogle,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppConstants.google, width: 24),
                              const SizedBox(width: AppSpacing.base),
                              const Text('Google'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.base),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading ? null : notifier.signInApple,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                isDarkMode
                                    ? AppConstants.appleDark
                                    : AppConstants.appleLight,
                                width: 24,
                              ),
                              const SizedBox(width: AppSpacing.base),
                              const Text('Apple'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.base),

                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      notifier.clearError();
                      setState(() => _isLogin = !_isLogin);
                    },
                    child: Text(
                      _isLogin
                          ? t.dontHaveAnAccount
                          : t.alreadyHaveAnAccount,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isLoading) ...[
            const ModalBarrier(dismissible: false, color: Colors.black38),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context)!;
    final notifier = ref.read(signInStateProvider.notifier);

    notifier.clearError();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    bool hasError = false;

    // --- LOCAL VALIDATION ---
    if (email.isEmpty) {
      _emailError = t.errorEmailEmpty;
      hasError = true;
    } else if (!email.contains('@')) {
      _emailError = t.errorInvalidEmail;
      hasError = true;
    } else {
      _emailError = null;
    }

    if (password.isEmpty) {
      _passwordError = t.errorPasswordEmpty;
      hasError = true;
    } else if (password.length < 6) {
      _passwordError = t.errorWeakPassword;
      hasError = true;
    } else {
      _passwordError = null;
    }

    setState(() {});

    if (hasError) return;

    // --- SERVER CALL ---
    if (_isLogin) {
      await notifier.signInEmail(email, password);
    } else {
      await notifier.registerEmail(email, password);
    }
  }
}
