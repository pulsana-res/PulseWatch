import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'app_bottom_sheet.dart';

/// Redeems a researcher-issued reset code for a new password, for a user
/// who's locked out and doesn't have a current password to change from
/// (that's [showChangePasswordSheet] instead). On success this logs the
/// user straight in, so [onLoggedIn] should do whatever LoginScreen's own
/// onLoggedIn does — route away from the login flow into the main app.
Future<void> showForgotPasswordSheet(BuildContext context, {required VoidCallback onLoggedIn}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _ForgotPasswordSheetBody(onLoggedIn: onLoggedIn),
  );
}

class _ForgotPasswordSheetBody extends StatefulWidget {
  final VoidCallback onLoggedIn;

  const _ForgotPasswordSheetBody({required this.onLoggedIn});

  @override
  State<_ForgotPasswordSheetBody> createState() => _ForgotPasswordSheetBodyState();
}

class _ForgotPasswordSheetBodyState extends State<_ForgotPasswordSheetBody> {
  final _codeController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscureNew = true;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final code = _codeController.text;
    final next = _newController.text;
    final confirm = _confirmController.text;

    if (code.trim().isEmpty) {
      setState(() => _error = l10n.forgotPasswordEnterCode);
      return;
    }
    if (next.length < 8) {
      setState(() => _error = l10n.changePasswordTooShort);
      return;
    }
    if (next != confirm) {
      setState(() => _error = l10n.changePasswordMismatch);
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });

    final result = await AuthService.instance.resetPassword(code: code, newPassword: next);

    if (!mounted) return;
    if (result.success) {
      Navigator.of(context).pop();
      widget.onLoggedIn();
    } else {
      setState(() {
        _busy = false;
        _error = result.error ?? l10n.commonSomethingWentWrong;
      });
    }
  }

  InputDecoration _fieldDecoration(String label, {Widget? suffixIcon}) {
    return InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppBottomSheetChrome(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppSheetIconBadge(icon: Icons.key_outlined, color: AppColors.primaryGreen),
            const SizedBox(height: 16),
            Text(
              l10n.forgotPasswordTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.forgotPasswordSubtitle,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              textCapitalization: TextCapitalization.characters,
              decoration: _fieldDecoration(l10n.forgotPasswordCodeLabel),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _newController,
              obscureText: _obscureNew,
              decoration: _fieldDecoration(
                l10n.changePasswordNewLabel,
                suffixIcon: IconButton(
                  icon: Icon(_obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmController,
              obscureText: _obscureNew,
              decoration: _fieldDecoration(l10n.changePasswordConfirmLabel),
            ),
            if (_error != null) ...[
              const SizedBox(height: 10),
              Text(_error!, style: const TextStyle(color: AppColors.error, fontSize: 12.5)),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _busy ? null : _submit,
                child: _busy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Text(l10n.forgotPasswordButton),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _busy ? null : () => Navigator.of(context).pop(),
                child: Text(l10n.commonCancel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
