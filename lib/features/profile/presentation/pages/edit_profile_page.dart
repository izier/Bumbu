import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../core/firestore/users_public_sync.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _usernameController = TextEditingController();
  final _displayNameController = TextEditingController();

  String? _usernameError;
  var _saving = false;
  var _seededFields = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(authStateProvider);

    if (!_seededFields && user != null) {
      _seededFields = true;
      _usernameController.text = user.username;
      _displayNameController.text =
          user.displayName.isNotEmpty ? user.displayName : user.username;
    }

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.editProfile)),
        body: Center(child: Text(t.notAuthenticated)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: Text(t.editProfile),
            actions: [
              TextButton(
                onPressed: _saving ? null : () => _save(context, user.id),
                child: Text(t.save),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.groupedPadding,
              AppSpacing.base,
              AppSpacing.groupedPadding,
              AppSpacing.huge + MediaQuery.of(context).padding.bottom,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TextField(
                  controller: _displayNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: t.displayName,
                  ),
                ),
                const SizedBox(height: AppSpacing.base),
                TextField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
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
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save(BuildContext context, String uid) async {
    final t = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final username = _usernameController.text.trim().toLowerCase();
    final displayName = _displayNameController.text.trim();

    if (username.length < 3 || username.contains('@')) {
      setState(() => _usernameError = t.errorUsernameMinLength);
      return;
    }

    setState(() => _saving = true);
    try {
      final taken = await FirebaseFirestore.instance
          .collection(UsersPublicSync.collection)
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (taken.docs.isNotEmpty && taken.docs.first.id != uid) {
        if (mounted) {
          setState(() {
            _usernameError = t.errorUsernameAlreadyUsed;
            _saving = false;
          });
        }
        return;
      }

      final resolvedDisplay =
          displayName.isEmpty ? username : displayName;

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'username': username,
        'displayName': resolvedDisplay,
      });

      final authUser = FirebaseAuth.instance.currentUser;
      if (authUser != null) {
        await authUser.updateDisplayName(resolvedDisplay);
      }

      await UsersPublicSync.mergeFields(
        uid: uid,
        username: username,
        displayName: resolvedDisplay,
        email: authUser?.email ?? '',
      );

      await ref.read(authStateProvider.notifier).refreshProfile();

      if (!context.mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(t.profileUpdated)));
      context.pop();
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(content: Text(t.errorSomethingWentWrong)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
