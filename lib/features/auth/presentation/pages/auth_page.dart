import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/auth_exceptions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_state_panel.dart';
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
  final _passwordConfirmController = TextEditingController();
  final _usernameController = TextEditingController();
  final _displayNameController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _passwordConfirmError;
  String? _usernameError;

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
    _passwordConfirmController.dispose();
    _usernameController.dispose();
    _displayNameController.dispose();
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
        leading: context.canPop()
            ? IconButton(
                onPressed: () => context.pop(),
                icon: Icon(CupertinoIcons.back),
              )
            : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                AppSpacing.screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _isLogin ? t.logInToYourAccount : t.createANewAccount,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.sectionSpacing),


                  TextField(
                    controller: _emailController,
                    autofocus: _isLogin,
                    keyboardType: _isLogin
                        ? TextInputType.text
                        : TextInputType.emailAddress,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText:
                          _isLogin ? t.emailOrUsernameLogin : t.email,
                      errorText: _emailError,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.base),

                  if (!_isLogin) ...[
                    TextField(
                      controller: _usernameController,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if (_usernameError != null) {
                          setState(() => _usernameError = null);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: t.username,
                        errorText: _usernameError,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.base),
                    TextField(
                      controller: _displayNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: t.displayName,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.base),
                  ],

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() => _passwordError = null);
                      }
                      if (_passwordConfirmError != null) {
                        setState(() => _passwordConfirmError = null);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: t.password,
                      errorText: _passwordError,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.base),

                  if (!_isLogin) ...[
                    TextField(
                      controller: _passwordConfirmController,
                      obscureText: true,
                      onChanged: (_) {
                        if (_passwordConfirmError != null) {
                          setState(() => _passwordConfirmError = null);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: t.confirmPassword,
                        errorText: _passwordConfirmError,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.base),
                  ],

                  if (serverError != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .error
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.sm),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .error
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.exclamationmark_circle,
                            color: Theme.of(context).colorScheme.error,
                            size: 20,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              serverError,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.base),
                  ],

                  ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    child: Text(_isLogin ? t.login : t.createAccount),
                  ),

                  const SizedBox(height: AppSpacing.huge),

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
                              Text(t.brandGoogle),
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
                              Text(t.brandApple),
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
                            _passwordConfirmController.clear();
                            setState(() => _isLogin = !_isLogin);
                          },
                    child: Text(
                      _isLogin ? t.dontHaveAnAccount : t.alreadyHaveAnAccount,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (isLoading) ...[
            const ModalBarrier(dismissible: false, color: Colors.black38),
            Center(
              child: AppStatePanel.loading(title: t.loading),
            ),
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
    final username = _usernameController.text.trim();
    final displayName = _displayNameController.text.trim();

    bool hasError = false;

    // --- LOCAL VALIDATION ---
    if (email.isEmpty) {
      _emailError = t.errorEmailEmpty;
      hasError = true;
    } else if (!_isLogin && !email.contains('@')) {
      _emailError = t.errorInvalidEmail;
      hasError = true;
    } else {
      _emailError = null;
    }

    if (!_isLogin && username.length < 3) {
      _usernameError = t.errorUsernameMinLength;
      hasError = true;
    } else {
      _usernameError = null;
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

    if (!_isLogin) {
      final confirm = _passwordConfirmController.text.trim();
      if (confirm != password) {
        _passwordConfirmError = t.errorPasswordMismatch;
        hasError = true;
      } else {
        _passwordConfirmError = null;
      }
    } else {
      _passwordConfirmError = null;
    }

    setState(() {});

    if (hasError) return;

    // --- SERVER CALL ---
    if (_isLogin) {
      await notifier.signInEmail(email, password);
    } else {
      await notifier.registerEmail(
        email: email,
        password: password,
        username: username,
        displayName: displayName,
      );
    }
  }
}
