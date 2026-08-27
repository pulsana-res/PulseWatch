import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart';
import 'services/locale_service.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/insights_screen.dart';
import 'screens/device_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/enroll_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/lock_screen.dart';
import 'onboarding/coach_mark_overlay.dart';
import 'services/auth_service.dart';
import 'services/autostart_service.dart';
import 'services/background_sync_service.dart';
import 'services/biometric_lock_service.dart';
import 'services/connection_status_service.dart';
import 'services/server_service.dart';
import 'services/ble_service.dart';
import 'services/inference_service.dart';
import 'services/notification_service.dart';
import 'services/report_service.dart';
import 'services/upload_consent_service.dart';
import 'widgets/app_bottom_sheet.dart';
import 'widgets/health_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Needed for DateFormat (home_screen.dart's greeting/date/time strings)
  // to work in Chinese — without it, intl throws for any locale other than
  // the implicit default the moment a non-English DateFormat runs.
  await initializeDateFormatting();
  // Required once, before runApp, for FlutterForegroundTask's main-isolate
  // <-> TaskHandler-isolate messaging to work (see foreground_task_handler.dart).
  FlutterForegroundTask.initCommunicationPort();
  // Registers callbackDispatcher with the Android WorkManager plugin so a
  // periodic background sync task (scheduled from BleService once a watch
  // is connected — see BackgroundSyncService.ensureScheduled) can actually
  // fire later, including after the app isn't running at all. Must happen
  // before runApp for the same reason as initCommunicationPort() above:
  // the plugin needs to be wired up before anything could try to use it.
  if (Platform.isAndroid) {
    await BackgroundSyncService.instance.init();
  }
  try {
    await InferenceService.initialize();
  } catch (e) {
    // Same defensive reasoning as _checkState's try/catch below: a device
    // that can't load the ONNX native library (e.g. an ABI it wasn't built
    // for) shouldn't leave the user stuck on a blank screen forever just
    // because this one await never returned. Report generation will fail
    // later (InferenceService.isInitialized stays false) instead of the
    // whole app failing to start.
    print('InferenceService failed to initialize, continuing without it: $e');
  }
  runApp(const PulseWatchApp());
}


class PulseWatchApp extends StatefulWidget {
  const PulseWatchApp({super.key});

  /// Switches the app's language at runtime — called from the Landing
  /// screen's toggle and Settings' language picker. Persists the choice via
  /// LocaleService so it survives a restart, then rebuilds MaterialApp with
  /// the new locale immediately (no restart needed).
  static Future<void> setLocale(BuildContext context, Locale locale) async {
    await LocaleService.setLocale(locale);
    context.findAncestorStateOfType<_PulseWatchAppState>()?._applyLocale(locale);
  }

  @override
  State<PulseWatchApp> createState() => _PulseWatchAppState();
}

class _PulseWatchAppState extends State<PulseWatchApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    LocaleService.getLocale().then((locale) {
      if (mounted && locale != null) setState(() => _locale = locale);
    });
  }

  void _applyLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PulseWatch AI',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const _AppEntry(),
    );
  }
}

/// Routes between account setup and the main app based on whether the
/// device has a logged-in account. Owns the enroll/login toggle directly
/// (rather than pushing routes for it) so its own state — and the
/// onLoggedIn callback those screens hold — never gets torn down mid-flow.
class _AppEntry extends StatefulWidget {
  const _AppEntry();

  @override
  State<_AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<_AppEntry> with WidgetsBindingObserver {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _showLanding = true;
  bool _showLogin = false;
  bool _lockEnabled = false;
  bool _isUnlocked = true;
  // True only when this session's own EnrollScreen just created the
  // account — not on an ordinary sign-in — so the one-time walkthrough
  // (see MainNavigation) never replays for a returning user.
  bool _justEnrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Re-lock whenever the app leaves the foreground, so a stolen/borrowed
  // unlocked phone doesn't leave health data exposed after backgrounding.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _lockEnabled) {
      setState(() => _isUnlocked = false);
    }
  }

  Future<void> _checkState() async {
    bool loggedIn = false;
    bool lockEnabled = false;

    // This gates every app launch — nothing renders until it finishes. It's
    // not just AuthService.isLoggedIn() that's been hardened against a bad
    // secure-storage read; this try/catch is a backstop so that *any*
    // unexpected exception here falls back to "not logged in" instead of
    // leaving the user stuck on the loading spinner forever, which is what
    // happened when this had no error handling at all.
    try {
      loggedIn = await AuthService.instance.isLoggedIn();
      if (loggedIn) {
        // Points DatabaseHelper at this account's own file before Home (or
        // anything else) gets a chance to read from whatever database was
        // last open — see AuthService.switchActiveUser.
        await AuthService.instance.switchActiveUser(await AuthService.instance.getPatientId());
      }
      lockEnabled = await BiometricLockService.instance.isEnabled() &&
          await BiometricLockService.instance.isDeviceSupported();
    } catch (e) {
      print('Startup check failed, defaulting to logged-out: $e');
    }

    if (mounted) {
      setState(() {
        _isLoggedIn = loggedIn;
        _lockEnabled = lockEnabled;
        _isUnlocked = !lockEnabled;
        _isLoading = false;
      });
    }
  }

  void _onLoggedIn() {
    setState(() => _isLoggedIn = true);
  }

  void _onEnrolled() {
    setState(() {
      _isLoggedIn = true;
      _justEnrolled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primaryGreen),
        ),
      );
    }

    if (!_isLoggedIn) {
      if (_showLanding) {
        return LandingScreen(
          onGetStarted: () => setState(() => _showLanding = false),
          onSignIn: () => setState(() {
            _showLanding = false;
            _showLogin = true;
          }),
        );
      }

      return _showLogin
          ? LoginScreen(
              onLoggedIn: _onLoggedIn,
              onSwitchToEnroll: () => setState(() => _showLogin = false),
              onBack: () => setState(() => _showLanding = true),
            )
          : EnrollScreen(
              onEnrolled: _onEnrolled,
              onSwitchToLogin: () => setState(() => _showLogin = true),
              onBack: () => setState(() => _showLanding = true),
            );
    }

    if (_lockEnabled && !_isUnlocked) {
      return LockScreen(onUnlocked: () => setState(() => _isUnlocked = true));
    }

    return MainNavigation(showWalkthrough: _justEnrolled);
  }
}

class MainNavigation extends StatefulWidget {
  final bool showWalkthrough;

  const MainNavigation({super.key, this.showWalkthrough = false});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  bool _showingWalkthrough = false;

  // Spotlight anchors for the new-signup coach-mark walkthrough.
  final _watchStatusKey = GlobalKey();
  final _progressCardKey = GlobalKey();
  final _navBarKey = GlobalKey();

  // Lives here rather than on HomeScreen — HomeScreen is unmounted whenever
  // the user is on another tab (each tab replaces the previous one in
  // `body:` below, it isn't an IndexedStack), so a subscription living
  // there missed the "connected" event entirely whenever the watch was
  // connected from the Device tab, and wouldn't retroactively fire just
  // from navigating back to Home afterward (the stream only emits on
  // transitions, and the transition had already happened). This widget is
  // never unmounted for the life of the session, so it can't miss it.
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  // FlutterBluePlus.adapterState is the OS radio's own on/off state — a
  // different thing from a device *connection* dropping (that's
  // _connectionSubscription above). The user turning Bluetooth off
  // entirely is common (airplane mode, accidentally toggling it from the
  // quick-settings tray) and previously had no app-wide signal at all.
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  // Same cadence Home's own upload-health banner already used — kept here
  // too (a little redundant with Home's, not harmful) so "can't reach the
  // server" is visible no matter which tab is open, not just Home.
  Timer? _uploadHealthToastTimer;

  // The dismissible top-of-screen banner for "something needs attention
  // right now" conditions (unexpected disconnect, background running
  // disabled) — see widgets/health_toast.dart. Lives here for the same
  // reason _connectionSubscription does: it has to survive tab switches.
  HealthIssue? _activeIssue;
  static const _toastCooldown = Duration(minutes: 30);

  List<Widget> get _screens => [
        HomeScreen(
          onNavigateToTab: _navigateToTab,
          watchStatusKey: _watchStatusKey,
          progressCardKey: _progressCardKey,
        ),
        const InsightsScreen(),
        const DeviceScreen(),
        const SettingsScreen(),
      ];

  void _navigateToTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _showingWalkthrough = widget.showWalkthrough;
    WidgetsBinding.instance.addObserver(this);

    _connectionSubscription = BleService().connectionStateStream.listen((state) {
      if (state == BluetoothConnectionState.connected) {
        _maybeShowBatteryExemptionPrompt();
        _maybeShowAutostartPrompt();
        _clearIssue('watch_disconnected');
      } else if (state == BluetoothConnectionState.disconnected) {
        _maybeShowUnexpectedDisconnectToast();
      }
    });

    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.on) {
        _clearIssue('bluetooth_off');
      } else {
        _maybeShowBluetoothOffToast();
      }
    });

    _uploadHealthToastTimer = Timer.periodic(const Duration(minutes: 5), (_) => _maybeShowNoConnectionToast());
    _maybeShowNoConnectionToast();

    // Also try on first load, not only on resume — didChangeAppLifecycleState
    // only fires on a background->foreground *transition*, which a cold
    // start (app fully closed, then reopened) never triggers. Without this,
    // reopening the app after the BLE connection had already died left it
    // disconnected until the user noticed and manually reconnected.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _triggerAutoUpload();
      _tryAutoReconnectUnlessPaused();
      // Sequenced (see _runHealthPromptChecks' doc comment) rather than
      // fired alongside the first-run prompts below — covers "already
      // connected by the time this mounted" too (e.g. the foreground
      // service survived from before a cold restart), since the
      // connection-state subscription only catches a *transition*.
      await _runHealthPromptChecks();
      // New signups get asked once the walkthrough finishes (see
      // onFinished below) so it doesn't compete with the coach marks;
      // everyone else (including existing users who've never seen these
      // prompts) gets asked here, on their next normal Home landing —
      // after the checks above, not alongside them, for the same
      // one-dialog-at-a-time reason.
      if (!_showingWalkthrough) {
        await _maybeShowFirstRunPrompts();
      }
    });
  }

  /// Runs the app's one-time opt-in prompts in order. Each one is asked
  /// exactly once ever (regardless of the answer) and none of them are
  /// bundled with the OS permission dialogs or the coach-mark walkthrough,
  /// so a new user isn't hit with everything at once.
  ///
  /// _maybeShowUploadConsentPrompt is intentionally NOT called here right
  /// now — automatic upload ships on-by-default for this launch (see
  /// UploadConsentService's doc comment for the reasoning and how to
  /// switch back to an opt-in flow later). The method is kept below,
  /// fully working, for exactly that switch — just add the call back.
  Future<void> _maybeShowFirstRunPrompts() async {
    await _maybeShowNotificationPrompt();
    await _maybeShowBiometricLockPrompt();
  }

  /// One-time notification-permission rationale — this used to be requested
  /// unconditionally the instant Home first rendered, with no explanation
  /// (see NotificationService.initialize's doc comment). Declining here
  /// skips the OS dialog entirely rather than firing it anyway; like the
  /// other first-run prompts, there's no in-app way to re-ask afterward —
  /// changing your mind means the OS app settings, same as anywhere else.
  Future<void> _maybeShowNotificationPrompt() async {
    if (await NotificationService.hasAskedPermission()) return;
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final proceed = await showAppConfirmSheet(
      context: context,
      icon: Icons.notifications_active_outlined,
      iconColor: AppColors.primaryGreen,
      title: l10n.mainNotifTitle,
      body: l10n.mainNotifBody,
      primaryLabel: l10n.commonAllow,
      secondaryLabel: l10n.commonNotNow,
    );

    if (proceed == true) {
      await NotificationService.requestPermission();
    }
    await NotificationService.markPermissionAsked();
  }

  /// One-time opt-in for automatic background upload — currently unused
  /// by the flow above (see that method's doc comment), kept working for
  /// when this becomes an opt-in prompt again later.
  // ignore: unused_element
  Future<void> _maybeShowUploadConsentPrompt() async {
    final consent = UploadConsentService.instance;
    if (await consent.hasAsked()) return;
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final allow = await showAppConfirmSheet(
      context: context,
      icon: Icons.cloud_upload_rounded,
      iconColor: AppColors.primaryGreen,
      title: l10n.mainUploadConsentTitle,
      body: l10n.mainUploadConsentBody,
      primaryLabel: l10n.commonAllow,
      secondaryLabel: l10n.commonNotNow,
      isDismissible: false,
      extra: [
        AppSheetHint(
          icon: Icons.shield_outlined,
          text: l10n.mainUploadConsentHint1,
        ),
        AppSheetHint(
          icon: Icons.settings_outlined,
          text: l10n.mainChangeAnytimeSettings,
        ),
      ],
    );

    await consent.setConsent(allow ?? false);
    await consent.markAsked();

    if (allow == true) {
      // The prompt itself only decides the setting; kick off an upload
      // right away if there's already a backlog waiting instead of
      // leaving it for the next launch/resume.
      _triggerAutoUpload();
    }
  }

  /// One-time opt-in for the app lock, asked once ever regardless of the
  /// answer — never re-shown, and never bundled with the OS permission
  /// dialogs or the coach-mark walkthrough so it doesn't add to that pile.
  Future<void> _maybeShowBiometricLockPrompt() async {
    final lock = BiometricLockService.instance;
    if (await lock.hasAskedToEnable()) return;
    if (!await lock.isDeviceSupported()) {
      await lock.markAskedToEnable();
      return;
    }
    if (!mounted) return;

    // Enabling requires a real, successful check first — never flip the
    // setting on trust alone. See _BiometricLockPromptDialog for the
    // verify-then-enable flow.
    final enabled = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const _BiometricLockPromptDialog(),
    );

    if (enabled == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.mainAppLockEnabled)),
      );
    }
    await lock.markAskedToEnable();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectionSubscription?.cancel();
    _adapterStateSubscription?.cancel();
    _uploadHealthToastTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _triggerAutoUpload();
      _tryAutoReconnectUnlessPaused(); // reconnect watch silently, unless the user stopped recording
      _runHealthPromptChecks();
    }
  }

  /// Runs every check that can pop a modal sheet (upload backlog,
  /// battery-exemption ask, battery-exemption re-check) one at a time
  /// instead of firing them concurrently — the earlier version fired each
  /// independently, which let two or three sheets stack on top of each
  /// other whenever more than one happened to need showing at once
  /// (confirmed live: dismissing the battery sheet revealed the
  /// notification sheet already sitting there underneath, no transition,
  /// on a build where both were still unanswered). Awaiting each in turn
  /// guarantees at most one is ever on screen. Shared by both the initial
  /// launch check and every resume, since the same collision risk exists
  /// on either.
  /// Skips reconnecting while the user has stopped recording (see
  /// ReportService.isPaused / HomeScreen's "Save & stop for now") — without
  /// this, a cold start or every app resume would keep silently pulling the
  /// watch back into an active link behind their back, undoing the whole
  /// point of "stop everything until I explicitly start a new recording".
  Future<void> _tryAutoReconnectUnlessPaused() async {
    if (await ReportService.isPaused()) return;
    await BleService().tryAutoReconnect();
  }

  Future<void> _runHealthPromptChecks() async {
    await _maybeCheckUploadHealth();
    await _maybeShowBatteryExemptionPrompt();
    await _maybeShowAutostartPrompt();
    await _maybeShowBatteryRevokedToast();
  }

  /// Explains why the app needs the battery-optimization exemption before
  /// sending the user to the OS settings screen for it — asked once ever,
  /// the first time a connection completes, regardless of which tab
  /// happens to be open when that happens (see _connectionSubscription's
  /// doc comment above for why this can't live on a tab screen).
  Future<void> _maybeShowBatteryExemptionPrompt() async {
    if (!await BleService().needsBatteryExemptionPrompt()) return;
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final proceed = await showAppConfirmSheet(
      context: context,
      icon: Icons.battery_charging_full_rounded,
      iconColor: AppColors.primaryGreen,
      title: l10n.mainKeepRecordingReliableTitle,
      body: l10n.mainKeepRecordingReliableBody,
      primaryLabel: l10n.commonAllow,
      secondaryLabel: l10n.commonNotNow,
    );

    if (proceed == true) {
      await BleService().requestBatteryExemption();
    }
    await BleService().markBatteryExemptionAsked();
  }

  /// Same purpose as the battery-exemption prompt above, for the separate
  /// OEM "Autostart" permission some manufacturers (Xiaomi, Oppo, vivo,
  /// Huawei, and others) layer on top of stock Android's — see
  /// AutostartService's doc comment for why granting one doesn't grant the
  /// other. No-op on every other phone: [needsAutostartPrompt] only
  /// returns true on a manufacturer actually known to need this.
  Future<void> _maybeShowAutostartPrompt() async {
    if (!await AutostartService.instance.needsAutostartPrompt()) return;
    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final proceed = await showAppConfirmSheet(
      context: context,
      icon: Icons.phonelink_lock_rounded,
      iconColor: AppColors.primaryGreen,
      title: l10n.mainAutostartTitle,
      body: l10n.mainAutostartBody,
      primaryLabel: l10n.mainOpenSettings,
      secondaryLabel: l10n.commonNotNow,
    );

    if (proceed == true) {
      await AutostartService.instance.openSettings();
    }
    await AutostartService.instance.markAsked();
  }

  // ── Health toast (see widgets/health_toast.dart) ──────────────────────

  /// A watch dropping mid-session is already auto-retried (BleService
  /// registers autoConnect the instant it happens), but that was
  /// previously invisible to the user unless they happened to be looking
  /// at the Device tab. ConnectionStatusService.reconnecting is the same
  /// signal BleService already sets for an *unexpected* drop — a
  /// deliberate disconnect (Settings' confirm-and-disconnect flow) leaves
  /// it at `disconnected` instead, which is why this checks state rather
  /// than just reacting to every disconnect event.
  Future<void> _maybeShowUnexpectedDisconnectToast() async {
    final state = await ConnectionStatusService.instance.getState();
    if (state != WatchConnectionState.reconnecting) return;
    final l10n = AppLocalizations.of(context)!;

    await _maybeShowIssue(HealthIssue(
      id: 'watch_disconnected',
      severity: ToastSeverity.warning,
      icon: Icons.bluetooth_disabled_rounded,
      title: l10n.mainWatchDisconnectedTitle,
      message: l10n.mainWatchDisconnectedMessage,
      onTap: () => _navigateToTab(2),
    ));
  }

  /// Re-checks (doesn't just ask once) because an OEM battery manager —
  /// Xiaomi, Huawei, Samsung are the known offenders — can silently
  /// re-restrict the app after the user already granted the exemption,
  /// quietly reintroducing the exact background-kill risk the original
  /// prompt exists to prevent. See BleService.isBatteryExemptionRevoked.
  Future<void> _maybeShowBatteryRevokedToast() async {
    if (!await BleService().isBatteryExemptionRevoked()) {
      _clearIssue('battery_revoked');
      return;
    }
    final l10n = AppLocalizations.of(context)!;

    await _maybeShowIssue(HealthIssue(
      id: 'battery_revoked',
      severity: ToastSeverity.error,
      icon: Icons.battery_alert_rounded,
      // Leads with the consequence, not the cause — "background running
      // turned off" is a fact about phone settings a rushed user will
      // dismiss without acting on; "you could lose data" is the thing
      // that actually makes them tap through and fix it.
      title: l10n.mainDataLossTitle,
      message: l10n.mainBatteryRevokedMessage,
      onTap: () async {
        await BleService().requestBatteryExemption();
      },
    ));
  }

  /// The OS radio itself being off — a different thing from a device
  /// connection dropping (that's _maybeShowUnexpectedDisconnectToast).
  /// Common causes: airplane mode, an accidental toggle from the quick
  /// settings tray. No tap action here — turning it back on has to happen
  /// from the OS quick-settings/Settings, same as anywhere else in Android.
  Future<void> _maybeShowBluetoothOffToast() async {
    final l10n = AppLocalizations.of(context)!;
    await _maybeShowIssue(HealthIssue(
      id: 'bluetooth_off',
      severity: ToastSeverity.error,
      icon: Icons.bluetooth_disabled_rounded,
      title: l10n.mainDataLossTitle,
      message: l10n.mainBluetoothOffMessage,
    ));
  }

  /// Promotes the "can't reach the server" signal HomeScreen's own banner
  /// already shows to an app-wide toast — previously invisible on every
  /// tab except Home. A real backlog (12h+) still also gets the heavier
  /// app-wide confirm-sheet from _maybeCheckUploadHealth; this is the
  /// lighter, earlier signal for "no connection right now" specifically.
  Future<void> _maybeShowNoConnectionToast() async {
    if (!await UploadConsentService.instance.hasConsented()) {
      _clearIssue('no_connection');
      return;
    }

    final health = await ServerService.instance.checkUploadHealth();
    if (health != UploadHealth.noConnection) {
      _clearIssue('no_connection');
      return;
    }
    final l10n = AppLocalizations.of(context)!;

    await _maybeShowIssue(HealthIssue(
      id: 'no_connection',
      severity: ToastSeverity.warning,
      icon: Icons.cloud_off_rounded,
      title: l10n.mainNoConnectionTitle,
      message: l10n.mainNoConnectionMessage,
      onTap: () => _navigateToTab(3),
    ));
  }

  /// Shows [issue] unless the exact same issue is already showing, or the
  /// user dismissed this same issue recently (see _toastCooldown) — the
  /// "don't spam" requirement, using the same SharedPreferences-cooldown
  /// approach already proven for the upload-health OS notifications.
  ///
  /// Every health toast (disconnect, Bluetooth off, battery exemption
  /// revoked, no server connection) funnels through here, which makes this
  /// the one place that needs to know about "stopped" (see
  /// ReportService.isPaused) and about the user's notification preference
  /// (see NotificationService.isEnabled, Settings' "Notifications" toggle)
  /// instead of gating each call site individually.
  Future<void> _maybeShowIssue(HealthIssue issue) async {
    if (_activeIssue?.id == issue.id) return;
    if (await ReportService.isPaused()) return;
    if (!await NotificationService.isEnabled()) return;

    final prefs = await SharedPreferences.getInstance();
    final lastMs = prefs.getInt('toast_dismissed_${issue.id}_ms');
    if (lastMs != null) {
      final since = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(lastMs));
      if (since < _toastCooldown) return;
    }

    if (!mounted) return;
    setState(() => _activeIssue = issue);
  }

  /// Clears the banner the moment the underlying condition resolves —
  /// doesn't wait out the cooldown, which is only there to rate-limit
  /// re-showing something the user already dismissed while it's still
  /// ongoing, not to delay the "good news" of it going away.
  void _clearIssue(String id) {
    if (_activeIssue?.id == id && mounted) {
      setState(() => _activeIssue = null);
    }
  }

  Future<void> _dismissActiveIssue() async {
    final issue = _activeIssue;
    if (issue == null) return;
    setState(() => _activeIssue = null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('toast_dismissed_${issue.id}_ms', DateTime.now().millisecondsSinceEpoch);
  }

  /// The active, foreground half of the upload-health signal (the
  /// background task in background_sync_service.dart handles the passive
  /// notification half even when the app isn't open). Only the
  /// backlog-risk case gets an in-app popup — a "no connection" is left to
  /// the banner HomeScreen reads directly from checkUploadHealth, since
  /// there's nothing actionable to walk the user through beyond "connect
  /// to the internet".
  Future<void> _maybeCheckUploadHealth() async {
    if (!await UploadConsentService.instance.hasConsented()) return;

    final server = ServerService.instance;
    if (await server.checkUploadHealth() != UploadHealth.backlogRisk) return;
    if (!await server.shouldShowBacklogPopup()) return;
    if (!mounted) return;

    await server.markBacklogPopupShown();

    final l10n = AppLocalizations.of(context)!;
    final goUpload = await showAppConfirmSheet(
      context: context,
      icon: Icons.cloud_off_rounded,
      iconColor: AppColors.error,
      title: l10n.mainUploadNeededTitle,
      body: l10n.mainUploadNeededBody,
      primaryLabel: l10n.settingsUploadNow,
      secondaryLabel: l10n.mainLater,
    );

    if (goUpload == true) {
      _navigateToTab(3);
    }
  }

  Future<void> _triggerAutoUpload() async {
    if (!await UploadConsentService.instance.hasConsented()) return;

    final server = ServerService.instance;
    if (!await server.shouldAutoUpload()) return;

    final result = await server.smartUpload();
    if (!mounted) return;

    if (result.needsLogin) {
      // Refresh token is dead — drop back to the login/enrollment flow.
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const _AppEntry()),
        (route) => false,
      );
    } else if (result.needsRescan) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.mainCouldNotReachServer),
          backgroundColor: Colors.orange.shade700,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else if (result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.mainAutoUploaded(result.recordsUploaded)),
          backgroundColor: AppColors.primaryGreen,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scaffold = Scaffold(
      body: SafeArea(
        // A Column that pushes the active tab down, not a Stack overlay —
        // an overlay looked exactly like the bug it was meant to report,
        // sitting on top of (and unreadable against) each screen's own
        // header instead of making room for itself. HealthToastBanner
        // always stays in the tree (rather than being added/removed here)
        // so its own AnimatedSwitcher can animate the empty <-> shown
        // transition in both directions instead of just hard-cutting away.
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: HealthToastBanner(issue: _activeIssue, onDismiss: _dismissActiveIssue),
            ),
            Expanded(child: _screens[_currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        key: _navBarKey,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: AppColors.cardBackground,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.insights_outlined),
            selectedIcon: const Icon(Icons.insights),
            label: l10n.insightsTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.watch_outlined),
            selectedIcon: const Icon(Icons.watch),
            label: l10n.deviceTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settingsTitle,
          ),
        ],
      ),
    );

    if (!_showingWalkthrough) return scaffold;

    return CoachMarkOverlay(
      steps: [
        CoachMarkStep(
          targetKey: _watchStatusKey,
          title: l10n.landingStep1Title,
          description: l10n.coachStep1Description,
        ),
        CoachMarkStep(
          targetKey: _progressCardKey,
          title: l10n.landingStep2Title,
          description: l10n.coachStep2Description,
        ),
        CoachMarkStep(
          targetKey: _navBarKey,
          title: l10n.coachStep3Title,
          description: l10n.coachStep3Description,
        ),
      ],
      onFinished: () {
        setState(() => _showingWalkthrough = false);
        _maybeShowFirstRunPrompts();
      },
      child: scaffold,
    );
  }
}

/// The one-time "want to lock the app?" prompt. Tapping Enable runs a real
/// authentication check on the spot — the setting only turns on if that
/// check actually succeeds, so a cancelled or failed attempt (wet fingers,
/// declined prompt, whatever) never leaves the lock silently enabled with
/// no way back in. A failed check stays on the dialog so the user can
/// retry, rather than closing and guessing what happened.
class _BiometricLockPromptDialog extends StatefulWidget {
  const _BiometricLockPromptDialog();

  @override
  State<_BiometricLockPromptDialog> createState() => _BiometricLockPromptDialogState();
}

class _BiometricLockPromptDialogState extends State<_BiometricLockPromptDialog> {
  bool _verifying = false;
  bool _lastAttemptFailed = false;

  Future<void> _verifyAndEnable() async {
    setState(() {
      _verifying = true;
      _lastAttemptFailed = false;
    });

    final success = await BiometricLockService.instance.authenticate();

    if (!mounted) return;

    if (success) {
      await BiometricLockService.instance.setEnabled(true);
      if (mounted) Navigator.of(context).pop(true);
    } else {
      setState(() {
        _verifying = false;
        _lastAttemptFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppBottomSheetChrome(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppSheetIconBadge(icon: Icons.fingerprint, color: AppColors.primaryGreen),
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
                tooltip: l10n.commonClose,
                onPressed: _verifying ? null : () => Navigator.of(context).pop(false),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.mainLockPulseWatchTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.mainLockPulseWatchBody,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
          ),
          AppSheetHint(
            icon: Icons.settings_outlined,
            text: l10n.mainChangeAnytimeSettings,
          ),
          if (_lastAttemptFailed)
            AppSheetHint(
              icon: Icons.error_outline,
              text: l10n.mainBiometricRetryHint,
              color: AppColors.error,
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _verifying ? null : _verifyAndEnable,
              child: _verifying
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(l10n.mainEnableButton),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _verifying ? null : () => Navigator.of(context).pop(false),
              child: Text(l10n.commonNotNow),
            ),
          ),
        ],
      ),
    );
  }
}
