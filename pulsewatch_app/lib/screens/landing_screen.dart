import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../theme/app_theme.dart';

/// First screen a new participant sees, before Enroll/Login — explains what
/// PulseWatch AI is and sets expectations for the 48h commitment up front,
/// so the enrollment form isn't the first thing that hits them.
class LandingScreen extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onSignIn;

  const LandingScreen({
    super.key,
    required this.onGetStarted,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.monitor_heart_outlined, color: AppColors.primaryGreen, size: 28),
                  ),
                  const _LanguageToggle(),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                l10n.landingTitle,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.landingSubtitle,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 36),

              _buildStep(
                icon: Icons.bluetooth,
                iconColor: AppColors.primaryGreen,
                title: l10n.landingStep1Title,
                subtitle: l10n.landingStep1Subtitle,
              ),
              const SizedBox(height: 20),
              _buildStep(
                icon: Icons.schedule_rounded,
                iconColor: AppColors.secondaryCoral,
                title: l10n.landingStep2Title,
                subtitle: l10n.landingStep2Subtitle,
              ),
              const SizedBox(height: 20),
              _buildStep(
                icon: Icons.description_outlined,
                iconColor: AppColors.primaryGreen,
                title: l10n.landingStep3Title,
                subtitle: l10n.landingStep3Subtitle,
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onGetStarted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(l10n.landingGetStarted,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: onSignIn,
                  child: Text(
                    l10n.landingSignIn,
                    style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.13),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// EN / 中文 switch shown in the corner of the Landing screen — the other
/// entry point is the "Language" row in Settings (see settings_screen.dart),
/// for users who are already signed in and never see this screen again.
class _LanguageToggle extends StatelessWidget {
  const _LanguageToggle();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final current = Localizations.localeOf(context).languageCode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(context, label: l10n.languageEnglishName, code: 'en', isActive: current == 'en'),
          _buildOption(context, label: l10n.languageChineseName, code: 'zh', isActive: current == 'zh'),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, {required String label, required String code, required bool isActive}) {
    return GestureDetector(
      onTap: isActive ? null : () => PulseWatchApp.setLocale(context, Locale(code)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
