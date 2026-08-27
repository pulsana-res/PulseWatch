// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get landingTitle => 'Understand your\nheart, over 48 hours';

  @override
  String get landingSubtitle =>
      'A research-grade cardiac monitoring study, run from your wrist.';

  @override
  String get landingStep1Title => 'Connect your watch';

  @override
  String get landingStep1Subtitle => 'Pair once, it reconnects on its own';

  @override
  String get landingStep2Title => 'Wear it for 48 hours';

  @override
  String get landingStep2Subtitle => 'Keep it on, including sleep';

  @override
  String get landingStep3Title => 'Get your risk report';

  @override
  String get landingStep3Subtitle => 'Scored once, from your full session';

  @override
  String get landingGetStarted => 'Get started';

  @override
  String get landingSignIn => 'Already enrolled? Sign in';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSheetTitle => 'Choose language';

  @override
  String get languageEnglishName => 'English';

  @override
  String get languageChineseName => '中文';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonDone => 'Done';

  @override
  String get commonClose => 'Close';

  @override
  String get riskLow => 'Low risk';

  @override
  String get riskModerate => 'Moderate risk';

  @override
  String get riskHigh => 'High risk';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLoading => 'Loading your settings…';

  @override
  String get sectionAccount => 'Account';

  @override
  String get sectionRecording => 'Recording';

  @override
  String get sectionPrivacySecurity => 'Privacy & security';

  @override
  String get sectionData => 'Data';

  @override
  String get sectionSupport => 'Support';

  @override
  String get sectionAbout => 'About';

  @override
  String get settingsYourReports => 'Your reports';

  @override
  String get settingsChangePassword => 'Change password';

  @override
  String get settingsStartNewRecording => 'Start a new recording';

  @override
  String get settingsStopRecording => 'Stop recording';

  @override
  String get settingsStarting => 'Starting…';

  @override
  String get settingsStopping => 'Stopping…';

  @override
  String get settingsAppLock => 'App lock';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsAutomaticUpload => 'Automatic upload';

  @override
  String get settingsContactSupport => 'Contact support';

  @override
  String get settingsRequestWithdraw => 'Request to withdraw from study';

  @override
  String get settingsLogout => 'Log out';

  @override
  String get settingsBiometricVerifyFailed =>
      'Couldn\'t verify — lock not enabled. Try again.';

  @override
  String get settingsUploadConsentOffTitle => 'Before you turn this off';

  @override
  String get settingsUploadConsentOffBody =>
      'PulseWatch AI is a research project studying cardiac risk from everyday wearable data. Every reading you share helps train and validate the model — for you and for future participants. Turning this off means your data stops reaching the research team automatically.';

  @override
  String get settingsUploadConsentKeepSharing => 'Keep sharing my data';

  @override
  String get settingsUploadConsentTurnOff => 'Turn off anyway';

  @override
  String get settingsStopRecordingTitle => 'Stop recording?';

  @override
  String get settingsStopRecordingBody =>
      'Data collection stops right away, and nothing more will be recorded until you start a new session. Make sure that\'s what you want.';

  @override
  String get settingsKeepRecording => 'Keep recording';

  @override
  String get settingsCantOpenLink =>
      'Couldn\'t open that — no app found to handle it.';

  @override
  String get settingsWithdrawTitle => 'Request to withdraw?';

  @override
  String get settingsWithdrawBody =>
      'This opens an email to the research team asking to withdraw you from the study and delete your data. Nothing changes until they confirm with you.';

  @override
  String get settingsLogoutTitle => 'Log out?';

  @override
  String get settingsLogoutBody =>
      'You\'ll need your username and password (or a new enrollment code) to log back in.';

  @override
  String get settingsConnectedToServer => 'Connected to server';

  @override
  String get settingsCouldNotConnect => 'Could not connect';

  @override
  String get settingsEnterServerUrlFirst => 'Please enter the server URL first';

  @override
  String get settingsNeverUploaded => 'Never uploaded';

  @override
  String get settingsUploadedJustNow => 'Uploaded just now';

  @override
  String settingsUploadedMinutesAgo(int minutes) {
    return 'Uploaded ${minutes}m ago';
  }

  @override
  String settingsUploadedHoursAgo(int hours) {
    return 'Uploaded ${hours}h ago';
  }

  @override
  String settingsUploadedDaysAgo(int days) {
    return 'Uploaded ${days}d ago';
  }

  @override
  String get settingsNoReportsYet => 'No reports saved yet';

  @override
  String settingsReportsSavedOnly(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saved',
      one: '1 saved',
    );
    return '$_temp0';
  }

  @override
  String settingsReportsSubtitle(int count, String risk) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count saved',
      one: '1 saved',
    );
    return '$_temp0 · latest $risk';
  }

  @override
  String get settingsDataUpload => 'Data upload';

  @override
  String settingsPendingReadings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count readings not yet uploaded',
      one: '1 reading not yet uploaded',
    );
    return '$_temp0';
  }

  @override
  String get settingsEverythingUploaded => 'Everything is uploaded';

  @override
  String get settingsUploadNow => 'Upload now';

  @override
  String get settingsUpToDate => 'Up to date';

  @override
  String get settingsAdvancedServerAddress => 'Advanced: server address';

  @override
  String get settingsConnectedStatus => 'Connected';

  @override
  String get settingsDefaultParticipantName => 'Participant';

  @override
  String settingsResearchId(String id) {
    return 'Research ID: $id';
  }

  @override
  String get aboutTagline =>
      'Catch heart sclerosis years before it has symptoms.';

  @override
  String get aboutEyebrow =>
      'Cardiac research · FILS, National University of Science and Technology POLITEHNICA Bucharest';

  @override
  String get aboutBody =>
      'Pulsana is a research study built around a small wrist bracelet and an AI model that watches your heart rate variability while you go about your day — and flags early warning signs long before a check-up would.';

  @override
  String get aboutResearchTeamLabel => 'Research team';

  @override
  String aboutVersion(String version) {
    return 'PulseWatch AI · Version $version';
  }

  @override
  String get settingsUploadingEllipsis => 'Uploading…';

  @override
  String get settingsUploadingHint =>
      'Don\'t close the app while this finishes.';

  @override
  String get settingsUploadComplete => 'Upload complete';

  @override
  String get settingsUploadFailed => 'Upload failed';

  @override
  String get homeReportSavedStopped => 'Report saved — recording stopped.';

  @override
  String get homeReportSavedNewSession =>
      'Report saved — starting a new session.';

  @override
  String get homeNotEnoughData => 'Not enough data yet';

  @override
  String get homeMoreActive => 'More active';

  @override
  String get homeLessActive => 'Less active';

  @override
  String get homeAboutTheSame => 'About the same';

  @override
  String get homeMovementCaption => 'Than yesterday, same time';

  @override
  String get homeRiskLabelLow => 'Low Risk';

  @override
  String get homeRiskLabelModerate => 'Moderate';

  @override
  String get homeRiskLabelHigh => 'High Risk';

  @override
  String get homeGreetingMorning => 'Good morning';

  @override
  String homeGreetingMorningNamed(String name) {
    return 'Good morning, $name';
  }

  @override
  String get homeGreetingAfternoon => 'Good afternoon';

  @override
  String homeGreetingAfternoonNamed(String name) {
    return 'Good afternoon, $name';
  }

  @override
  String get homeGreetingEvening => 'Good evening';

  @override
  String homeGreetingEveningNamed(String name) {
    return 'Good evening, $name';
  }

  @override
  String get homeWatchConnected => 'Watch connected';

  @override
  String get homeTapToConnect => 'Tap to connect watch';

  @override
  String get homeUploadBacklogText =>
      'Your data hasn\'t reached the server in a while — tap to upload manually.';

  @override
  String get homeNoConnectionText =>
      'Can\'t reach the research server — check your internet connection.';

  @override
  String get homeLoadErrorTitle => 'Couldn\'t load your dashboard';

  @override
  String get homeLoadErrorCaption =>
      'Something went wrong reading your data. Try again — if it keeps happening, use \"Contact support\" in Settings and include the details below.';

  @override
  String get homeTryAgain => 'Try again';

  @override
  String get homePausedTitle => 'Recording stopped';

  @override
  String get homePausedCaption =>
      'Start a new recording whenever you\'re ready.';

  @override
  String get homeYoureRecording => 'You\'re recording';

  @override
  String get homeKeepWearingCaption =>
      'Keep wearing your watch — your first hour of data will show up soon.';

  @override
  String get homeWaitingFirstReading => 'Waiting for your first reading';

  @override
  String get homeKeepNearbyCaption =>
      'Keep your watch nearby — it syncs in the background every 15–20 minutes, so your first reading can take a little while to show up.';

  @override
  String get homeReadyTitle => 'Ready when you are';

  @override
  String get homeReadyCaption =>
      'Connect your watch to start your 48-hour session. Your cardiac risk report unlocks once it\'s complete.';

  @override
  String get homeJustStartedTitle => 'Just getting started';

  @override
  String homeJustStartedCaption(int hours) {
    return '$hours of 48 hours recorded so far. Keep wearing the watch through today and tonight.';
  }

  @override
  String get homeHalfwayTitle => 'Past the halfway point';

  @override
  String homeHalfwayCaption(int hours) {
    return 'About $hours hours left, including tonight. Every hour you wear it sharpens the picture.';
  }

  @override
  String get homeOf48h => 'of 48h';

  @override
  String get homeFactRestingHR => 'Resting heart rate, last night';

  @override
  String get homeFactSignalQuality => 'Signal quality today';

  @override
  String homeWornToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Worn today, $count gaps',
      one: 'Worn today, 1 gap',
      zero: 'Worn today, no gaps',
    );
    return '$_temp0';
  }

  @override
  String get homeGeneratingTitle => 'Generating Your Report';

  @override
  String get homeGeneratingCaption =>
      '48 hours of data collected — scoring your full session now.';

  @override
  String get homeCardiacRiskReport => 'Cardiac Risk Report';

  @override
  String homeGeneratedAt(String time) {
    return 'Generated $time · from your full session';
  }

  @override
  String get homeViewFullReport => 'View Full Report';

  @override
  String get homeSaving => 'Saving…';

  @override
  String get homeSaveReport => 'Save report…';

  @override
  String get homeLoadingDashboard => 'Loading your dashboard…';

  @override
  String get commonGotIt => 'Got it';

  @override
  String get dayToday => 'today';

  @override
  String get dayYesterday => 'yesterday';

  @override
  String get timeAm => 'AM';

  @override
  String get timePm => 'PM';

  @override
  String get signalGood => 'Good signal';

  @override
  String get signalWeak => 'Weak signal';

  @override
  String get signalNotWorn => 'Not worn';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get insightsLoadingMessage => 'Crunching your heart rate data…';

  @override
  String get insightsEmptyTitle => 'Nothing to show yet';

  @override
  String get insightsEmptyCaption =>
      'Once you start recording, your heart rate trend and wear time will show up here.';

  @override
  String get insightsErrorTitle => 'Couldn\'t load your trends';

  @override
  String get insightsErrorCaption =>
      'Something went wrong reading your data. Try again — if it keeps happening, use \"Contact support\" in Settings and include the details below.';

  @override
  String get insightsHeartRateLabel => 'Heart rate';

  @override
  String insightsSessionLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count}h session',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String get chartLegendRange => 'Range';

  @override
  String get chartLegendMean => 'Mean';

  @override
  String get chartLegendNightHours => 'Night hours';

  @override
  String get chartNowLabel => 'Now';

  @override
  String get chartInfoTooltip => 'See what this graph shows';

  @override
  String get chartInfoTitle => 'About this chart';

  @override
  String get chartInfoIntro =>
      'Every half hour is summarized into a few numbers so the shape of your session is easy to read at a glance.';

  @override
  String get chartInfoRangeBody =>
      'The shaded band and dashed edges mark the lowest and highest heart rate seen in that half hour — not just the average, so a brief spike or dip still shows up instead of getting smoothed away.';

  @override
  String get chartInfoMeanBody =>
      'The solid line is the average heart rate for that half hour.';

  @override
  String get chartInfoNightBody =>
      'The shaded background between 10 PM and 7 AM is just there to help you orient yourself in the timeline — it doesn\'t say anything about your data.';

  @override
  String get chartInfoHatchedTitle => 'Hatched stretch';

  @override
  String get chartInfoHatchedBody =>
      'A diagonal-striped gap means no readings were captured during that time — usually the watch was off, out of range, or losing signal.';

  @override
  String get statLowest => 'Lowest';

  @override
  String get statTypical => 'Typical';

  @override
  String get statPeak => 'Peak';

  @override
  String get statWorn => 'Worn';

  @override
  String get statGaps => 'Gaps';

  @override
  String get statAvgSignal => 'Avg signal';

  @override
  String insightGapDurationLabel(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours-hour',
      one: '1-hour',
    );
    return '$_temp0';
  }

  @override
  String insightGapExtra(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: ' (and $count other shorter gaps)',
      one: ' (and 1 other shorter gap)',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String get insightGapTipSleep =>
      'If it slipped off overnight, tightening the strap a notch before bed usually helps it stay snug.';

  @override
  String get insightGapTipDay =>
      'If you took it off (shower, charging, workout), that\'s completely fine — just try to get it back on soon after so we don\'t miss too much.';

  @override
  String insightGapMessage(
    String duration,
    String window,
    String extra,
    String tip,
  ) {
    return 'We noticed a $duration gap around $window$extra. $tip';
  }

  @override
  String insightWeakMessage(String window) {
    return 'Signal was a bit weak around $window. A snugger fit — about a finger\'s width of slack — usually helps the sensor stay locked on.';
  }

  @override
  String get insightGreatConsistency =>
      'Great consistency — you\'ve worn the watch for the whole session with a strong signal throughout. Keep it up!';

  @override
  String runDetailDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String runDetailSnackbar(String label, String window, String duration) {
    return '$label • $window • $duration';
  }

  @override
  String get commonAllow => 'Allow';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get deviceTitle => 'Device';

  @override
  String get deviceDebugTooltip => 'Preview controls';

  @override
  String get deviceBleRationaleBody =>
      'Bluetooth lets PulseWatch talk to your watch.';

  @override
  String get deviceConnectedSuccess => '✅ Connected!';

  @override
  String deviceConnectionFailed(String reason) {
    return '❌ $reason';
  }

  @override
  String get deviceConnectionFailedDefault => 'Connection failed';

  @override
  String deviceRelativeSeconds(int seconds) {
    return '${seconds}s ago';
  }

  @override
  String deviceRelativeMinutes(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String deviceRelativeHours(int hours) {
    return '${hours}h ago';
  }

  @override
  String deviceRelativeDays(int days) {
    return '${days}d ago';
  }

  @override
  String deviceDurationMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String deviceDurationHours(int hours) {
    return '${hours}h';
  }

  @override
  String deviceDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get deviceDisconnectTitle => 'Disconnect watch?';

  @override
  String get deviceDisconnectBody =>
      'You\'ll stop collecting heart rate data until you reconnect — try to put the watch back on again soon so we don\'t miss too much of your session.';

  @override
  String get deviceDisconnect => 'Disconnect';

  @override
  String get deviceStayConnected => 'Stay connected';

  @override
  String get deviceDisconnectedSnackbar => 'Disconnected';

  @override
  String get deviceUnknownDevice => 'Unknown Device';

  @override
  String get deviceNoSignalYet => 'No signal yet';

  @override
  String get deviceGoodContact => 'Good contact';

  @override
  String get deviceSignalWeak => 'Signal a bit weak';

  @override
  String get devicePoorContact => 'Poor contact';

  @override
  String get deviceSignalQualityCaption => 'Signal quality from the sensor';

  @override
  String get deviceNoReadingsYet => 'No readings yet';

  @override
  String deviceLastReading(String time) {
    return 'Last reading $time';
  }

  @override
  String deviceGapExtra(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: ' (+$count more)',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String deviceNoNewDataFor(String duration, String extra) {
    return 'No new data for $duration$extra';
  }

  @override
  String deviceOneGap(String duration, String time, String extra) {
    return 'One $duration gap $time$extra';
  }

  @override
  String get deviceConnectedStatus => 'Connected';

  @override
  String get deviceNotConnectedStatus => 'Not Connected';

  @override
  String get deviceScanPrompt => 'Scan to find your watch';

  @override
  String get deviceScanningEllipsis => 'Scanning...';

  @override
  String get deviceScanForDevices => 'Scan for Devices';

  @override
  String get deviceStreamingAutomatically =>
      'Connected - Data streaming automatically';

  @override
  String get deviceFoundDevices => 'Found Devices';

  @override
  String get deviceConnectButton => 'Connect';

  @override
  String get deviceLoadingCaption => 'Checking your watch data…';

  @override
  String reportShareError(String error) {
    return 'Could not share the report: $error';
  }

  @override
  String get reportAppBarTitle => 'Heart Sclerosis Risk Report';

  @override
  String get reportShareTooltip => 'Share report';

  @override
  String get reportOrgLine =>
      'AI Bracelet System  ·  NUST Politehnica Bucharest';

  @override
  String get reportDisclaimer =>
      '⚠ This is a research prototype, not a medical device. This report is designed to support — not replace — clinical evaluation. A score above 30% should prompt a cardiologist referral. All analysis runs locally on your device. No data is sent anywhere.';

  @override
  String get reportCardiacRiskScoreLabel => 'CARDIAC RISK SCORE';

  @override
  String get reportRiskBadgeLow => 'LOW RISK';

  @override
  String get reportRiskBadgeMedium => 'MEDIUM RISK';

  @override
  String get reportRiskBadgeHigh => 'HIGH RISK';

  @override
  String get reportScale0 => '0% — Healthy';

  @override
  String get reportScale50 => '50%';

  @override
  String get reportScale100 => '100% — High Risk';

  @override
  String get reportSessionOverview => 'Session Overview';

  @override
  String get reportWindowsAnalysed => 'Windows analysed';

  @override
  String get reportDataRows => 'Data rows';

  @override
  String get reportSessionDuration => 'Session duration';

  @override
  String reportSessionDurationValue(String hours) {
    return '~$hours hours';
  }

  @override
  String get reportMeanHr => 'Mean HR';

  @override
  String get reportMeanRmssd => 'Mean RMSSD';

  @override
  String get reportGenerated => 'Generated';

  @override
  String get reportTopFeatures => 'Top Influential Features';

  @override
  String get reportFooter =>
      'Generated by AI Bracelet for Early Detection of Heart Sclerosis  ·  Model: XGBoost (AUC 0.986, Accuracy 93.7%)  ·  Daria Gladkykh · FatemehSadat MahmoudzadehHosseini · Prof. Dr. Ing. Nicolae Goga';

  @override
  String get reportHistoryLoading => 'Loading your saved reports…';

  @override
  String get reportHistoryEmptyTitle => 'No saved reports yet';

  @override
  String get reportHistoryEmptyCaption =>
      'Once you complete a 48-hour session, use \"Save report & start new session\" on Home to keep it here.';

  @override
  String get commonBack => 'Back';

  @override
  String get commonShowPassword => 'Show password';

  @override
  String get commonHidePassword => 'Hide password';

  @override
  String get enrollTitle => 'Set up your\naccount';

  @override
  String get enrollSubtitle =>
      'Enter the code your researcher gave you,\nthen choose a username and password.';

  @override
  String get enrollCodeLabel => 'Enrollment code';

  @override
  String get enrollCodeValidator => 'Enter the 8-character code';

  @override
  String get enrollUsernameLabel => 'Choose a username';

  @override
  String get enrollUsernameValidator => 'Enter a username';

  @override
  String get enrollPasswordLabel => 'Choose a password';

  @override
  String get enrollPasswordHint => 'At least 8 characters';

  @override
  String get enrollPasswordValidator =>
      'Password must be at least 8 characters';

  @override
  String get enrollConfirmPasswordLabel => 'Confirm password';

  @override
  String get enrollConfirmPasswordHint => 'Re-enter password';

  @override
  String get enrollPasswordMismatch => 'Passwords do not match';

  @override
  String get enrollPasswordsMatch => 'Passwords match';

  @override
  String get enrollCreateAccount => 'Create account';

  @override
  String get enrollAlreadyHaveAccount => 'I already have an account';

  @override
  String get loginWelcomeBack => 'Welcome back';

  @override
  String get loginSubtitle =>
      'Log in with the username and password\nyou set up earlier.';

  @override
  String get loginUsernameHint => 'Username';

  @override
  String get loginUsernameValidator => 'Enter your username';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginPasswordValidator => 'Enter your password';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginButton => 'Log in';

  @override
  String get loginSwitchToEnroll => 'I have an enrollment code instead';

  @override
  String get lockTitle => 'PulseWatch is locked';

  @override
  String get lockSubtitle => 'Unlock to view your health data.';

  @override
  String get lockVerifyFailed => 'Couldn\'t verify — try again';

  @override
  String get lockChecking => 'Checking…';

  @override
  String get lockUnlockButton => 'Unlock';

  @override
  String get saveSessionTitle => 'Save this report';

  @override
  String get saveSessionSubtitle =>
      'It\'ll be saved to your profile in Settings either way. Choose what happens next.';

  @override
  String get saveSessionDeleteRawLabel =>
      'Also delete this session\'s raw heart-rate readings to free up space. The saved report itself is kept either way.';

  @override
  String get saveSessionStartNew => 'Save & start new session';

  @override
  String get saveSessionStopForNow => 'Save & stop for now';

  @override
  String get commonSomethingWentWrong => 'Something went wrong.';

  @override
  String get changePasswordFillBoth => 'Fill in both password fields.';

  @override
  String get changePasswordTooShort =>
      'New password must be at least 8 characters.';

  @override
  String get changePasswordMismatch => 'New passwords don\'t match.';

  @override
  String get changePasswordSuccess => 'Password changed.';

  @override
  String get changePasswordCurrentLabel => 'Current password';

  @override
  String get changePasswordNewLabel => 'New password';

  @override
  String get changePasswordConfirmLabel => 'Confirm new password';

  @override
  String get forgotPasswordEnterCode =>
      'Enter the reset code your researcher gave you.';

  @override
  String get forgotPasswordTitle => 'Reset your password';

  @override
  String get forgotPasswordSubtitle =>
      'Ask your researcher for a reset code, then set a new password below.';

  @override
  String get forgotPasswordCodeLabel => 'Reset code';

  @override
  String get forgotPasswordButton => 'Reset password';

  @override
  String get mainLater => 'Later';

  @override
  String get mainChangeAnytimeSettings => 'Change this anytime in Settings.';

  @override
  String get mainNotifTitle => 'Stay in the loop';

  @override
  String get mainNotifBody =>
      'We\'ll ping you when your report\'s ready or your data needs attention.';

  @override
  String get mainUploadConsentTitle => 'Share your data automatically?';

  @override
  String get mainUploadConsentBody =>
      'PulseWatch can send your heart rate and movement readings to the research server in the background, so you never have to upload manually.';

  @override
  String get mainUploadConsentHint1 =>
      'Anonymized — your name and device ID are never included.';

  @override
  String get mainAppLockEnabled => 'App lock enabled';

  @override
  String get mainWatchDisconnectedTitle => 'Watch disconnected';

  @override
  String get mainWatchDisconnectedMessage =>
      'Reconnecting automatically — tap to check.';

  @override
  String get mainDataLossTitle => 'You could lose data';

  @override
  String get mainBatteryRevokedMessage =>
      'Background running was turned off — tap to fix it now.';

  @override
  String get mainBluetoothOffMessage =>
      'Bluetooth is off, so PulseWatch can\'t reach your watch.';

  @override
  String get mainNoConnectionTitle => 'Can\'t reach the server';

  @override
  String get mainNoConnectionMessage =>
      'Your data is still recording locally — it\'ll upload once you\'re back online.';

  @override
  String get mainUploadNeededTitle => 'Your data needs uploading';

  @override
  String get mainUploadNeededBody =>
      'PulseWatch hasn\'t been able to reach the server in over 12 hours, even though you\'re connected. Let\'s upload manually to make sure nothing is lost.';

  @override
  String get mainCouldNotReachServer =>
      'Could not reach research server — check connection';

  @override
  String mainAutoUploaded(int count) {
    return 'Auto-uploaded $count readings';
  }

  @override
  String get navHome => 'Home';

  @override
  String get coachStep1Description =>
      'Pair it once here — it reconnects on its own after that.';

  @override
  String get coachStep2Description =>
      'Your risk report is calculated once, from your full session — not a quick snapshot.';

  @override
  String get coachStep3Title => 'Find your way around';

  @override
  String get coachStep3Description =>
      'Insights shows trends, Device handles connection, and Settings is where manual upload lives if you ever need it.';

  @override
  String get mainLockPulseWatchTitle => 'Lock PulseWatch?';

  @override
  String get mainLockPulseWatchBody =>
      'Require your fingerprint or PIN to open the app.';

  @override
  String get mainBiometricRetryHint =>
      'Couldn\'t verify — try again, or use PIN/pattern if biometrics aren\'t working right now.';

  @override
  String get mainEnableButton => 'Enable';

  @override
  String get mainKeepRecordingReliableTitle => 'Keep recording reliable';

  @override
  String get mainKeepRecordingReliableBody =>
      'Battery settings can pause recording in the background — choose \"Allow\" or \"Unrestricted\" on the next screen.';

  @override
  String get mainAutostartTitle => 'One more setting for reliable recording';

  @override
  String get mainAutostartBody =>
      'Your phone\'s manufacturer adds its own background-app permission on top of Android\'s — separate from the battery setting. Turn it on for PulseWatch so recording keeps working when the app isn\'t open.';

  @override
  String get mainOpenSettings => 'Open settings';

  @override
  String get coachSkip => 'Skip';

  @override
  String get coachNext => 'Next';
}
