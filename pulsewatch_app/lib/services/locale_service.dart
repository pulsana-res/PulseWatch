import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the user's explicit English/Chinese choice (from the Landing
/// screen toggle or Settings' language picker — see main.dart's
/// PulseWatchApp.setLocale and settings_screen.dart). Deliberately not
/// scoped per-account (unlike most other settings here, e.g.
/// NotificationService) — language is a device-level preference the user
/// would expect to stick across sign-out/sign-in, not something tied to
/// which research participant is logged in.
class LocaleService {
  LocaleService._();

  static const _kLocaleKey = 'app_locale_code';

  /// Null means "no explicit choice yet" — MaterialApp then falls back to
  /// resolving the device's own locale against supportedLocales.
  static Future<Locale?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_kLocaleKey);
    if (code == null) return null;
    return Locale(code);
  }

  static Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, locale.languageCode);
  }
}
