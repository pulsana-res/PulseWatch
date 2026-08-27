// Smoke test for the EN/中文 language switcher (see main.dart's
// PulseWatchApp.setLocale and screens/landing_screen.dart's _LanguageToggle).
// Exercises the Landing screen's toggle specifically — it's the entry point
// every signed-out user hits, and uses the exact same setLocale mechanism
// Settings' language picker calls, so this covers the underlying switch
// without needing to fake a logged-in session to reach Settings.

import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pulsewatch_app/main.dart';

/// AuthService.isLoggedIn() (see services/auth_service.dart) reads
/// flutter_secure_storage on every app boot. That plugin talks to the OS
/// keychain via a real native call rather than a mockable MethodChannel on
/// Windows/desktop, so under `flutter test` it never returns — leaving
/// _AppEntry stuck on its loading spinner forever and every widget test that
/// boots PulseWatchApp with it. Swap in a fake in-memory platform for the
/// life of the test instead of touching real secure storage.
class _FakeSecureStorage extends FlutterSecureStoragePlatform {
  @override
  Future<void> write({required String key, required String value, required Map<String, String> options}) async {}

  @override
  Future<String?> read({required String key, required Map<String, String> options}) async => null;

  @override
  Future<bool> containsKey({required String key, required Map<String, String> options}) async => false;

  @override
  Future<void> delete({required String key, required Map<String, String> options}) async {}

  @override
  Future<Map<String, String>> readAll({required Map<String, String> options}) async => {};

  @override
  Future<void> deleteAll({required Map<String, String> options}) async {}
}

/// Not pumpAndSettle — the loading Scaffold's CircularProgressIndicator is
/// an indeterminate (never-ending) animation, so pumpAndSettle would wait
/// for it forever. A handful of bounded pumps is enough for _AppEntry's
/// _checkState() (secure-storage/shared-prefs reads, all mocked or caught)
/// to work through its microtask chain and resolve.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStoragePlatform.instance = _FakeSecureStorage();
  });

  testWidgets('Landing screen starts in English and switches to Chinese via the toggle', (tester) async {
    await tester.pumpWidget(const PulseWatchApp());
    await _settle(tester);

    expect(find.text('Get started'), findsOneWidget);
    expect(find.text('Understand your\nheart, over 48 hours'), findsOneWidget);

    await tester.tap(find.text('中文'));
    await _settle(tester);

    expect(find.text('开始使用'), findsOneWidget);
    expect(find.text('48小时，\n读懂你的心脏'), findsOneWidget);
    expect(find.text('Get started'), findsNothing);

    // Switching back to English should work too, not just the one-way trip.
    await tester.tap(find.text('English'));
    await _settle(tester);

    expect(find.text('Get started'), findsOneWidget);
  });
}
