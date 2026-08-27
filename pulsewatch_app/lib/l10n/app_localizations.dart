import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// Landing screen headline
  ///
  /// In en, this message translates to:
  /// **'Understand your\nheart, over 48 hours'**
  String get landingTitle;

  /// No description provided for @landingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A research-grade cardiac monitoring study, run from your wrist.'**
  String get landingSubtitle;

  /// No description provided for @landingStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Connect your watch'**
  String get landingStep1Title;

  /// No description provided for @landingStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pair once, it reconnects on its own'**
  String get landingStep1Subtitle;

  /// No description provided for @landingStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Wear it for 48 hours'**
  String get landingStep2Title;

  /// No description provided for @landingStep2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep it on, including sleep'**
  String get landingStep2Subtitle;

  /// No description provided for @landingStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Get your risk report'**
  String get landingStep3Title;

  /// No description provided for @landingStep3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Scored once, from your full session'**
  String get landingStep3Subtitle;

  /// No description provided for @landingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get landingGetStarted;

  /// No description provided for @landingSignIn.
  ///
  /// In en, this message translates to:
  /// **'Already enrolled? Sign in'**
  String get landingSignIn;

  /// Settings row label for the language picker
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// Title of the language picker bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get languageSheetTitle;

  /// Name of the English option, shown in English regardless of current app language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishName;

  /// Name of the Chinese option, shown in Chinese regardless of current app language
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChineseName;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @riskLow.
  ///
  /// In en, this message translates to:
  /// **'Low risk'**
  String get riskLow;

  /// No description provided for @riskModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate risk'**
  String get riskModerate;

  /// No description provided for @riskHigh.
  ///
  /// In en, this message translates to:
  /// **'High risk'**
  String get riskHigh;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading your settings…'**
  String get settingsLoading;

  /// No description provided for @sectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get sectionAccount;

  /// No description provided for @sectionRecording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get sectionRecording;

  /// No description provided for @sectionPrivacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & security'**
  String get sectionPrivacySecurity;

  /// No description provided for @sectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get sectionData;

  /// No description provided for @sectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get sectionSupport;

  /// No description provided for @sectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAbout;

  /// No description provided for @settingsYourReports.
  ///
  /// In en, this message translates to:
  /// **'Your reports'**
  String get settingsYourReports;

  /// No description provided for @settingsChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsChangePassword;

  /// No description provided for @settingsStartNewRecording.
  ///
  /// In en, this message translates to:
  /// **'Start a new recording'**
  String get settingsStartNewRecording;

  /// No description provided for @settingsStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop recording'**
  String get settingsStopRecording;

  /// No description provided for @settingsStarting.
  ///
  /// In en, this message translates to:
  /// **'Starting…'**
  String get settingsStarting;

  /// No description provided for @settingsStopping.
  ///
  /// In en, this message translates to:
  /// **'Stopping…'**
  String get settingsStopping;

  /// No description provided for @settingsAppLock.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get settingsAppLock;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsAutomaticUpload.
  ///
  /// In en, this message translates to:
  /// **'Automatic upload'**
  String get settingsAutomaticUpload;

  /// No description provided for @settingsContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get settingsContactSupport;

  /// No description provided for @settingsRequestWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Request to withdraw from study'**
  String get settingsRequestWithdraw;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsLogout;

  /// No description provided for @settingsBiometricVerifyFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t verify — lock not enabled. Try again.'**
  String get settingsBiometricVerifyFailed;

  /// No description provided for @settingsUploadConsentOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you turn this off'**
  String get settingsUploadConsentOffTitle;

  /// No description provided for @settingsUploadConsentOffBody.
  ///
  /// In en, this message translates to:
  /// **'PulseWatch AI is a research project studying cardiac risk from everyday wearable data. Every reading you share helps train and validate the model — for you and for future participants. Turning this off means your data stops reaching the research team automatically.'**
  String get settingsUploadConsentOffBody;

  /// No description provided for @settingsUploadConsentKeepSharing.
  ///
  /// In en, this message translates to:
  /// **'Keep sharing my data'**
  String get settingsUploadConsentKeepSharing;

  /// No description provided for @settingsUploadConsentTurnOff.
  ///
  /// In en, this message translates to:
  /// **'Turn off anyway'**
  String get settingsUploadConsentTurnOff;

  /// No description provided for @settingsStopRecordingTitle.
  ///
  /// In en, this message translates to:
  /// **'Stop recording?'**
  String get settingsStopRecordingTitle;

  /// No description provided for @settingsStopRecordingBody.
  ///
  /// In en, this message translates to:
  /// **'Data collection stops right away, and nothing more will be recorded until you start a new session. Make sure that\'s what you want.'**
  String get settingsStopRecordingBody;

  /// No description provided for @settingsKeepRecording.
  ///
  /// In en, this message translates to:
  /// **'Keep recording'**
  String get settingsKeepRecording;

  /// No description provided for @settingsCantOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open that — no app found to handle it.'**
  String get settingsCantOpenLink;

  /// No description provided for @settingsWithdrawTitle.
  ///
  /// In en, this message translates to:
  /// **'Request to withdraw?'**
  String get settingsWithdrawTitle;

  /// No description provided for @settingsWithdrawBody.
  ///
  /// In en, this message translates to:
  /// **'This opens an email to the research team asking to withdraw you from the study and delete your data. Nothing changes until they confirm with you.'**
  String get settingsWithdrawBody;

  /// No description provided for @settingsLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get settingsLogoutTitle;

  /// No description provided for @settingsLogoutBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need your username and password (or a new enrollment code) to log back in.'**
  String get settingsLogoutBody;

  /// No description provided for @settingsConnectedToServer.
  ///
  /// In en, this message translates to:
  /// **'Connected to server'**
  String get settingsConnectedToServer;

  /// No description provided for @settingsCouldNotConnect.
  ///
  /// In en, this message translates to:
  /// **'Could not connect'**
  String get settingsCouldNotConnect;

  /// No description provided for @settingsEnterServerUrlFirst.
  ///
  /// In en, this message translates to:
  /// **'Please enter the server URL first'**
  String get settingsEnterServerUrlFirst;

  /// No description provided for @settingsNeverUploaded.
  ///
  /// In en, this message translates to:
  /// **'Never uploaded'**
  String get settingsNeverUploaded;

  /// No description provided for @settingsUploadedJustNow.
  ///
  /// In en, this message translates to:
  /// **'Uploaded just now'**
  String get settingsUploadedJustNow;

  /// No description provided for @settingsUploadedMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'Uploaded {minutes}m ago'**
  String settingsUploadedMinutesAgo(int minutes);

  /// No description provided for @settingsUploadedHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'Uploaded {hours}h ago'**
  String settingsUploadedHoursAgo(int hours);

  /// No description provided for @settingsUploadedDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Uploaded {days}d ago'**
  String settingsUploadedDaysAgo(int days);

  /// No description provided for @settingsNoReportsYet.
  ///
  /// In en, this message translates to:
  /// **'No reports saved yet'**
  String get settingsNoReportsYet;

  /// No description provided for @settingsReportsSavedOnly.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 saved} other{{count} saved}}'**
  String settingsReportsSavedOnly(int count);

  /// No description provided for @settingsReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 saved} other{{count} saved}} · latest {risk}'**
  String settingsReportsSubtitle(int count, String risk);

  /// No description provided for @settingsDataUpload.
  ///
  /// In en, this message translates to:
  /// **'Data upload'**
  String get settingsDataUpload;

  /// No description provided for @settingsPendingReadings.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 reading not yet uploaded} other{{count} readings not yet uploaded}}'**
  String settingsPendingReadings(int count);

  /// No description provided for @settingsEverythingUploaded.
  ///
  /// In en, this message translates to:
  /// **'Everything is uploaded'**
  String get settingsEverythingUploaded;

  /// No description provided for @settingsUploadNow.
  ///
  /// In en, this message translates to:
  /// **'Upload now'**
  String get settingsUploadNow;

  /// No description provided for @settingsUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Up to date'**
  String get settingsUpToDate;

  /// No description provided for @settingsAdvancedServerAddress.
  ///
  /// In en, this message translates to:
  /// **'Advanced: server address'**
  String get settingsAdvancedServerAddress;

  /// No description provided for @settingsConnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get settingsConnectedStatus;

  /// No description provided for @settingsDefaultParticipantName.
  ///
  /// In en, this message translates to:
  /// **'Participant'**
  String get settingsDefaultParticipantName;

  /// No description provided for @settingsResearchId.
  ///
  /// In en, this message translates to:
  /// **'Research ID: {id}'**
  String settingsResearchId(String id);

  /// No description provided for @aboutTagline.
  ///
  /// In en, this message translates to:
  /// **'Catch heart sclerosis years before it has symptoms.'**
  String get aboutTagline;

  /// No description provided for @aboutEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Cardiac research · FILS, National University of Science and Technology POLITEHNICA Bucharest'**
  String get aboutEyebrow;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'Pulsana is a research study built around a small wrist bracelet and an AI model that watches your heart rate variability while you go about your day — and flags early warning signs long before a check-up would.'**
  String get aboutBody;

  /// No description provided for @aboutResearchTeamLabel.
  ///
  /// In en, this message translates to:
  /// **'Research team'**
  String get aboutResearchTeamLabel;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'PulseWatch AI · Version {version}'**
  String aboutVersion(String version);

  /// No description provided for @settingsUploadingEllipsis.
  ///
  /// In en, this message translates to:
  /// **'Uploading…'**
  String get settingsUploadingEllipsis;

  /// No description provided for @settingsUploadingHint.
  ///
  /// In en, this message translates to:
  /// **'Don\'t close the app while this finishes.'**
  String get settingsUploadingHint;

  /// No description provided for @settingsUploadComplete.
  ///
  /// In en, this message translates to:
  /// **'Upload complete'**
  String get settingsUploadComplete;

  /// No description provided for @settingsUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed'**
  String get settingsUploadFailed;

  /// No description provided for @homeReportSavedStopped.
  ///
  /// In en, this message translates to:
  /// **'Report saved — recording stopped.'**
  String get homeReportSavedStopped;

  /// No description provided for @homeReportSavedNewSession.
  ///
  /// In en, this message translates to:
  /// **'Report saved — starting a new session.'**
  String get homeReportSavedNewSession;

  /// No description provided for @homeNotEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet'**
  String get homeNotEnoughData;

  /// No description provided for @homeMoreActive.
  ///
  /// In en, this message translates to:
  /// **'More active'**
  String get homeMoreActive;

  /// No description provided for @homeLessActive.
  ///
  /// In en, this message translates to:
  /// **'Less active'**
  String get homeLessActive;

  /// No description provided for @homeAboutTheSame.
  ///
  /// In en, this message translates to:
  /// **'About the same'**
  String get homeAboutTheSame;

  /// No description provided for @homeMovementCaption.
  ///
  /// In en, this message translates to:
  /// **'Than yesterday, same time'**
  String get homeMovementCaption;

  /// No description provided for @homeRiskLabelLow.
  ///
  /// In en, this message translates to:
  /// **'Low Risk'**
  String get homeRiskLabelLow;

  /// No description provided for @homeRiskLabelModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get homeRiskLabelModerate;

  /// No description provided for @homeRiskLabelHigh.
  ///
  /// In en, this message translates to:
  /// **'High Risk'**
  String get homeRiskLabelHigh;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingMorningNamed.
  ///
  /// In en, this message translates to:
  /// **'Good morning, {name}'**
  String homeGreetingMorningNamed(String name);

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingAfternoonNamed.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, {name}'**
  String homeGreetingAfternoonNamed(String name);

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get homeGreetingEvening;

  /// No description provided for @homeGreetingEveningNamed.
  ///
  /// In en, this message translates to:
  /// **'Good evening, {name}'**
  String homeGreetingEveningNamed(String name);

  /// No description provided for @homeWatchConnected.
  ///
  /// In en, this message translates to:
  /// **'Watch connected'**
  String get homeWatchConnected;

  /// No description provided for @homeTapToConnect.
  ///
  /// In en, this message translates to:
  /// **'Tap to connect watch'**
  String get homeTapToConnect;

  /// No description provided for @homeUploadBacklogText.
  ///
  /// In en, this message translates to:
  /// **'Your data hasn\'t reached the server in a while — tap to upload manually.'**
  String get homeUploadBacklogText;

  /// No description provided for @homeNoConnectionText.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the research server — check your internet connection.'**
  String get homeNoConnectionText;

  /// No description provided for @homeLoadErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your dashboard'**
  String get homeLoadErrorTitle;

  /// No description provided for @homeLoadErrorCaption.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong reading your data. Try again — if it keeps happening, use \"Contact support\" in Settings and include the details below.'**
  String get homeLoadErrorCaption;

  /// No description provided for @homeTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeTryAgain;

  /// No description provided for @homePausedTitle.
  ///
  /// In en, this message translates to:
  /// **'Recording stopped'**
  String get homePausedTitle;

  /// No description provided for @homePausedCaption.
  ///
  /// In en, this message translates to:
  /// **'Start a new recording whenever you\'re ready.'**
  String get homePausedCaption;

  /// No description provided for @homeYoureRecording.
  ///
  /// In en, this message translates to:
  /// **'You\'re recording'**
  String get homeYoureRecording;

  /// No description provided for @homeKeepWearingCaption.
  ///
  /// In en, this message translates to:
  /// **'Keep wearing your watch — your first hour of data will show up soon.'**
  String get homeKeepWearingCaption;

  /// No description provided for @homeWaitingFirstReading.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your first reading'**
  String get homeWaitingFirstReading;

  /// No description provided for @homeKeepNearbyCaption.
  ///
  /// In en, this message translates to:
  /// **'Keep your watch nearby — it syncs in the background every 15–20 minutes, so your first reading can take a little while to show up.'**
  String get homeKeepNearbyCaption;

  /// No description provided for @homeReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready when you are'**
  String get homeReadyTitle;

  /// No description provided for @homeReadyCaption.
  ///
  /// In en, this message translates to:
  /// **'Connect your watch to start your 48-hour session. Your cardiac risk report unlocks once it\'s complete.'**
  String get homeReadyCaption;

  /// No description provided for @homeJustStartedTitle.
  ///
  /// In en, this message translates to:
  /// **'Just getting started'**
  String get homeJustStartedTitle;

  /// No description provided for @homeJustStartedCaption.
  ///
  /// In en, this message translates to:
  /// **'{hours} of 48 hours recorded so far. Keep wearing the watch through today and tonight.'**
  String homeJustStartedCaption(int hours);

  /// No description provided for @homeHalfwayTitle.
  ///
  /// In en, this message translates to:
  /// **'Past the halfway point'**
  String get homeHalfwayTitle;

  /// No description provided for @homeHalfwayCaption.
  ///
  /// In en, this message translates to:
  /// **'About {hours} hours left, including tonight. Every hour you wear it sharpens the picture.'**
  String homeHalfwayCaption(int hours);

  /// No description provided for @homeOf48h.
  ///
  /// In en, this message translates to:
  /// **'of 48h'**
  String get homeOf48h;

  /// No description provided for @homeFactRestingHR.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate, last night'**
  String get homeFactRestingHR;

  /// No description provided for @homeFactSignalQuality.
  ///
  /// In en, this message translates to:
  /// **'Signal quality today'**
  String get homeFactSignalQuality;

  /// No description provided for @homeWornToday.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Worn today, no gaps} =1{Worn today, 1 gap} other{Worn today, {count} gaps}}'**
  String homeWornToday(int count);

  /// No description provided for @homeGeneratingTitle.
  ///
  /// In en, this message translates to:
  /// **'Generating Your Report'**
  String get homeGeneratingTitle;

  /// No description provided for @homeGeneratingCaption.
  ///
  /// In en, this message translates to:
  /// **'48 hours of data collected — scoring your full session now.'**
  String get homeGeneratingCaption;

  /// No description provided for @homeCardiacRiskReport.
  ///
  /// In en, this message translates to:
  /// **'Cardiac Risk Report'**
  String get homeCardiacRiskReport;

  /// No description provided for @homeGeneratedAt.
  ///
  /// In en, this message translates to:
  /// **'Generated {time} · from your full session'**
  String homeGeneratedAt(String time);

  /// No description provided for @homeViewFullReport.
  ///
  /// In en, this message translates to:
  /// **'View Full Report'**
  String get homeViewFullReport;

  /// No description provided for @homeSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get homeSaving;

  /// No description provided for @homeSaveReport.
  ///
  /// In en, this message translates to:
  /// **'Save report…'**
  String get homeSaveReport;

  /// No description provided for @homeLoadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Loading your dashboard…'**
  String get homeLoadingDashboard;

  /// No description provided for @commonGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get commonGotIt;

  /// No description provided for @dayToday.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get dayToday;

  /// No description provided for @dayYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get dayYesterday;

  /// No description provided for @timeAm.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get timeAm;

  /// No description provided for @timePm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get timePm;

  /// No description provided for @signalGood.
  ///
  /// In en, this message translates to:
  /// **'Good signal'**
  String get signalGood;

  /// No description provided for @signalWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak signal'**
  String get signalWeak;

  /// No description provided for @signalNotWorn.
  ///
  /// In en, this message translates to:
  /// **'Not worn'**
  String get signalNotWorn;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @insightsLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Crunching your heart rate data…'**
  String get insightsLoadingMessage;

  /// No description provided for @insightsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to show yet'**
  String get insightsEmptyTitle;

  /// No description provided for @insightsEmptyCaption.
  ///
  /// In en, this message translates to:
  /// **'Once you start recording, your heart rate trend and wear time will show up here.'**
  String get insightsEmptyCaption;

  /// No description provided for @insightsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your trends'**
  String get insightsErrorTitle;

  /// No description provided for @insightsErrorCaption.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong reading your data. Try again — if it keeps happening, use \"Contact support\" in Settings and include the details below.'**
  String get insightsErrorCaption;

  /// No description provided for @insightsHeartRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Heart rate'**
  String get insightsHeartRateLabel;

  /// No description provided for @insightsSessionLength.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour} other{{count}h session}}'**
  String insightsSessionLength(int count);

  /// No description provided for @chartLegendRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get chartLegendRange;

  /// No description provided for @chartLegendMean.
  ///
  /// In en, this message translates to:
  /// **'Mean'**
  String get chartLegendMean;

  /// No description provided for @chartLegendNightHours.
  ///
  /// In en, this message translates to:
  /// **'Night hours'**
  String get chartLegendNightHours;

  /// No description provided for @chartNowLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get chartNowLabel;

  /// No description provided for @chartInfoTooltip.
  ///
  /// In en, this message translates to:
  /// **'See what this graph shows'**
  String get chartInfoTooltip;

  /// No description provided for @chartInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'About this chart'**
  String get chartInfoTitle;

  /// No description provided for @chartInfoIntro.
  ///
  /// In en, this message translates to:
  /// **'Every half hour is summarized into a few numbers so the shape of your session is easy to read at a glance.'**
  String get chartInfoIntro;

  /// No description provided for @chartInfoRangeBody.
  ///
  /// In en, this message translates to:
  /// **'The shaded band and dashed edges mark the lowest and highest heart rate seen in that half hour — not just the average, so a brief spike or dip still shows up instead of getting smoothed away.'**
  String get chartInfoRangeBody;

  /// No description provided for @chartInfoMeanBody.
  ///
  /// In en, this message translates to:
  /// **'The solid line is the average heart rate for that half hour.'**
  String get chartInfoMeanBody;

  /// No description provided for @chartInfoNightBody.
  ///
  /// In en, this message translates to:
  /// **'The shaded background between 10 PM and 7 AM is just there to help you orient yourself in the timeline — it doesn\'t say anything about your data.'**
  String get chartInfoNightBody;

  /// No description provided for @chartInfoHatchedTitle.
  ///
  /// In en, this message translates to:
  /// **'Hatched stretch'**
  String get chartInfoHatchedTitle;

  /// No description provided for @chartInfoHatchedBody.
  ///
  /// In en, this message translates to:
  /// **'A diagonal-striped gap means no readings were captured during that time — usually the watch was off, out of range, or losing signal.'**
  String get chartInfoHatchedBody;

  /// No description provided for @statLowest.
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get statLowest;

  /// No description provided for @statTypical.
  ///
  /// In en, this message translates to:
  /// **'Typical'**
  String get statTypical;

  /// No description provided for @statPeak.
  ///
  /// In en, this message translates to:
  /// **'Peak'**
  String get statPeak;

  /// No description provided for @statWorn.
  ///
  /// In en, this message translates to:
  /// **'Worn'**
  String get statWorn;

  /// No description provided for @statGaps.
  ///
  /// In en, this message translates to:
  /// **'Gaps'**
  String get statGaps;

  /// No description provided for @statAvgSignal.
  ///
  /// In en, this message translates to:
  /// **'Avg signal'**
  String get statAvgSignal;

  /// No description provided for @insightGapDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'{hours, plural, =1{1-hour} other{{hours}-hour}}'**
  String insightGapDurationLabel(int hours);

  /// No description provided for @insightGapExtra.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{} =1{ (and 1 other shorter gap)} other{ (and {count} other shorter gaps)}}'**
  String insightGapExtra(int count);

  /// No description provided for @insightGapTipSleep.
  ///
  /// In en, this message translates to:
  /// **'If it slipped off overnight, tightening the strap a notch before bed usually helps it stay snug.'**
  String get insightGapTipSleep;

  /// No description provided for @insightGapTipDay.
  ///
  /// In en, this message translates to:
  /// **'If you took it off (shower, charging, workout), that\'s completely fine — just try to get it back on soon after so we don\'t miss too much.'**
  String get insightGapTipDay;

  /// No description provided for @insightGapMessage.
  ///
  /// In en, this message translates to:
  /// **'We noticed a {duration} gap around {window}{extra}. {tip}'**
  String insightGapMessage(
    String duration,
    String window,
    String extra,
    String tip,
  );

  /// No description provided for @insightWeakMessage.
  ///
  /// In en, this message translates to:
  /// **'Signal was a bit weak around {window}. A snugger fit — about a finger\'s width of slack — usually helps the sensor stay locked on.'**
  String insightWeakMessage(String window);

  /// No description provided for @insightGreatConsistency.
  ///
  /// In en, this message translates to:
  /// **'Great consistency — you\'ve worn the watch for the whole session with a strong signal throughout. Keep it up!'**
  String get insightGreatConsistency;

  /// No description provided for @runDetailDuration.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour} other{{count} hours}}'**
  String runDetailDuration(int count);

  /// No description provided for @runDetailSnackbar.
  ///
  /// In en, this message translates to:
  /// **'{label} • {window} • {duration}'**
  String runDetailSnackbar(String label, String window, String duration);

  /// No description provided for @commonAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get commonAllow;

  /// No description provided for @commonNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get commonNotNow;

  /// No description provided for @deviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get deviceTitle;

  /// No description provided for @deviceDebugTooltip.
  ///
  /// In en, this message translates to:
  /// **'Preview controls'**
  String get deviceDebugTooltip;

  /// No description provided for @deviceBleRationaleBody.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth lets PulseWatch talk to your watch.'**
  String get deviceBleRationaleBody;

  /// No description provided for @deviceConnectedSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Connected!'**
  String get deviceConnectedSuccess;

  /// No description provided for @deviceConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'❌ {reason}'**
  String deviceConnectionFailed(String reason);

  /// No description provided for @deviceConnectionFailedDefault.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get deviceConnectionFailedDefault;

  /// No description provided for @deviceRelativeSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s ago'**
  String deviceRelativeSeconds(int seconds);

  /// No description provided for @deviceRelativeMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String deviceRelativeMinutes(int minutes);

  /// No description provided for @deviceRelativeHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String deviceRelativeHours(int hours);

  /// No description provided for @deviceRelativeDays.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String deviceRelativeDays(int days);

  /// No description provided for @deviceDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String deviceDurationMinutes(int minutes);

  /// No description provided for @deviceDurationHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String deviceDurationHours(int hours);

  /// No description provided for @deviceDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String deviceDurationHoursMinutes(int hours, int minutes);

  /// No description provided for @deviceDisconnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect watch?'**
  String get deviceDisconnectTitle;

  /// No description provided for @deviceDisconnectBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll stop collecting heart rate data until you reconnect — try to put the watch back on again soon so we don\'t miss too much of your session.'**
  String get deviceDisconnectBody;

  /// No description provided for @deviceDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceDisconnect;

  /// No description provided for @deviceStayConnected.
  ///
  /// In en, this message translates to:
  /// **'Stay connected'**
  String get deviceStayConnected;

  /// No description provided for @deviceDisconnectedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get deviceDisconnectedSnackbar;

  /// No description provided for @deviceUnknownDevice.
  ///
  /// In en, this message translates to:
  /// **'Unknown Device'**
  String get deviceUnknownDevice;

  /// No description provided for @deviceNoSignalYet.
  ///
  /// In en, this message translates to:
  /// **'No signal yet'**
  String get deviceNoSignalYet;

  /// No description provided for @deviceGoodContact.
  ///
  /// In en, this message translates to:
  /// **'Good contact'**
  String get deviceGoodContact;

  /// No description provided for @deviceSignalWeak.
  ///
  /// In en, this message translates to:
  /// **'Signal a bit weak'**
  String get deviceSignalWeak;

  /// No description provided for @devicePoorContact.
  ///
  /// In en, this message translates to:
  /// **'Poor contact'**
  String get devicePoorContact;

  /// No description provided for @deviceSignalQualityCaption.
  ///
  /// In en, this message translates to:
  /// **'Signal quality from the sensor'**
  String get deviceSignalQualityCaption;

  /// No description provided for @deviceNoReadingsYet.
  ///
  /// In en, this message translates to:
  /// **'No readings yet'**
  String get deviceNoReadingsYet;

  /// No description provided for @deviceLastReading.
  ///
  /// In en, this message translates to:
  /// **'Last reading {time}'**
  String deviceLastReading(String time);

  /// No description provided for @deviceGapExtra.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{} other{ (+{count} more)}}'**
  String deviceGapExtra(int count);

  /// No description provided for @deviceNoNewDataFor.
  ///
  /// In en, this message translates to:
  /// **'No new data for {duration}{extra}'**
  String deviceNoNewDataFor(String duration, String extra);

  /// No description provided for @deviceOneGap.
  ///
  /// In en, this message translates to:
  /// **'One {duration} gap {time}{extra}'**
  String deviceOneGap(String duration, String time, String extra);

  /// No description provided for @deviceConnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get deviceConnectedStatus;

  /// No description provided for @deviceNotConnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get deviceNotConnectedStatus;

  /// No description provided for @deviceScanPrompt.
  ///
  /// In en, this message translates to:
  /// **'Scan to find your watch'**
  String get deviceScanPrompt;

  /// No description provided for @deviceScanningEllipsis.
  ///
  /// In en, this message translates to:
  /// **'Scanning...'**
  String get deviceScanningEllipsis;

  /// No description provided for @deviceScanForDevices.
  ///
  /// In en, this message translates to:
  /// **'Scan for Devices'**
  String get deviceScanForDevices;

  /// No description provided for @deviceStreamingAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Connected - Data streaming automatically'**
  String get deviceStreamingAutomatically;

  /// No description provided for @deviceFoundDevices.
  ///
  /// In en, this message translates to:
  /// **'Found Devices'**
  String get deviceFoundDevices;

  /// No description provided for @deviceConnectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get deviceConnectButton;

  /// No description provided for @deviceLoadingCaption.
  ///
  /// In en, this message translates to:
  /// **'Checking your watch data…'**
  String get deviceLoadingCaption;

  /// No description provided for @reportShareError.
  ///
  /// In en, this message translates to:
  /// **'Could not share the report: {error}'**
  String reportShareError(String error);

  /// No description provided for @reportAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Heart Sclerosis Risk Report'**
  String get reportAppBarTitle;

  /// No description provided for @reportShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share report'**
  String get reportShareTooltip;

  /// No description provided for @reportOrgLine.
  ///
  /// In en, this message translates to:
  /// **'AI Bracelet System  ·  NUST Politehnica Bucharest'**
  String get reportOrgLine;

  /// No description provided for @reportDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'⚠ This is a research prototype, not a medical device. This report is designed to support — not replace — clinical evaluation. A score above 30% should prompt a cardiologist referral. All analysis runs locally on your device. No data is sent anywhere.'**
  String get reportDisclaimer;

  /// No description provided for @reportCardiacRiskScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'CARDIAC RISK SCORE'**
  String get reportCardiacRiskScoreLabel;

  /// No description provided for @reportRiskBadgeLow.
  ///
  /// In en, this message translates to:
  /// **'LOW RISK'**
  String get reportRiskBadgeLow;

  /// No description provided for @reportRiskBadgeMedium.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM RISK'**
  String get reportRiskBadgeMedium;

  /// No description provided for @reportRiskBadgeHigh.
  ///
  /// In en, this message translates to:
  /// **'HIGH RISK'**
  String get reportRiskBadgeHigh;

  /// No description provided for @reportScale0.
  ///
  /// In en, this message translates to:
  /// **'0% — Healthy'**
  String get reportScale0;

  /// No description provided for @reportScale50.
  ///
  /// In en, this message translates to:
  /// **'50%'**
  String get reportScale50;

  /// No description provided for @reportScale100.
  ///
  /// In en, this message translates to:
  /// **'100% — High Risk'**
  String get reportScale100;

  /// No description provided for @reportSessionOverview.
  ///
  /// In en, this message translates to:
  /// **'Session Overview'**
  String get reportSessionOverview;

  /// No description provided for @reportWindowsAnalysed.
  ///
  /// In en, this message translates to:
  /// **'Windows analysed'**
  String get reportWindowsAnalysed;

  /// No description provided for @reportDataRows.
  ///
  /// In en, this message translates to:
  /// **'Data rows'**
  String get reportDataRows;

  /// No description provided for @reportSessionDuration.
  ///
  /// In en, this message translates to:
  /// **'Session duration'**
  String get reportSessionDuration;

  /// No description provided for @reportSessionDurationValue.
  ///
  /// In en, this message translates to:
  /// **'~{hours} hours'**
  String reportSessionDurationValue(String hours);

  /// No description provided for @reportMeanHr.
  ///
  /// In en, this message translates to:
  /// **'Mean HR'**
  String get reportMeanHr;

  /// No description provided for @reportMeanRmssd.
  ///
  /// In en, this message translates to:
  /// **'Mean RMSSD'**
  String get reportMeanRmssd;

  /// No description provided for @reportGenerated.
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get reportGenerated;

  /// No description provided for @reportTopFeatures.
  ///
  /// In en, this message translates to:
  /// **'Top Influential Features'**
  String get reportTopFeatures;

  /// No description provided for @reportFooter.
  ///
  /// In en, this message translates to:
  /// **'Generated by AI Bracelet for Early Detection of Heart Sclerosis  ·  Model: XGBoost (AUC 0.986, Accuracy 93.7%)  ·  Daria Gladkykh · FatemehSadat MahmoudzadehHosseini · Prof. Dr. Ing. Nicolae Goga'**
  String get reportFooter;

  /// No description provided for @reportHistoryLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading your saved reports…'**
  String get reportHistoryLoading;

  /// No description provided for @reportHistoryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved reports yet'**
  String get reportHistoryEmptyTitle;

  /// No description provided for @reportHistoryEmptyCaption.
  ///
  /// In en, this message translates to:
  /// **'Once you complete a 48-hour session, use \"Save report & start new session\" on Home to keep it here.'**
  String get reportHistoryEmptyCaption;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get commonShowPassword;

  /// No description provided for @commonHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get commonHidePassword;

  /// No description provided for @enrollTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your\naccount'**
  String get enrollTitle;

  /// No description provided for @enrollSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code your researcher gave you,\nthen choose a username and password.'**
  String get enrollSubtitle;

  /// No description provided for @enrollCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Enrollment code'**
  String get enrollCodeLabel;

  /// No description provided for @enrollCodeValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter the 8-character code'**
  String get enrollCodeValidator;

  /// No description provided for @enrollUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose a username'**
  String get enrollUsernameLabel;

  /// No description provided for @enrollUsernameValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter a username'**
  String get enrollUsernameValidator;

  /// No description provided for @enrollPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose a password'**
  String get enrollPasswordLabel;

  /// No description provided for @enrollPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get enrollPasswordHint;

  /// No description provided for @enrollPasswordValidator.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get enrollPasswordValidator;

  /// No description provided for @enrollConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get enrollConfirmPasswordLabel;

  /// No description provided for @enrollConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get enrollConfirmPasswordHint;

  /// No description provided for @enrollPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get enrollPasswordMismatch;

  /// No description provided for @enrollPasswordsMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords match'**
  String get enrollPasswordsMatch;

  /// No description provided for @enrollCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get enrollCreateAccount;

  /// No description provided for @enrollAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'I already have an account'**
  String get enrollAlreadyHaveAccount;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in with the username and password\nyou set up earlier.'**
  String get loginSubtitle;

  /// No description provided for @loginUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get loginUsernameHint;

  /// No description provided for @loginUsernameValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get loginUsernameValidator;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// No description provided for @loginPasswordValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordValidator;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @loginSwitchToEnroll.
  ///
  /// In en, this message translates to:
  /// **'I have an enrollment code instead'**
  String get loginSwitchToEnroll;

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'PulseWatch is locked'**
  String get lockTitle;

  /// No description provided for @lockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock to view your health data.'**
  String get lockSubtitle;

  /// No description provided for @lockVerifyFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t verify — try again'**
  String get lockVerifyFailed;

  /// No description provided for @lockChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get lockChecking;

  /// No description provided for @lockUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lockUnlockButton;

  /// No description provided for @saveSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Save this report'**
  String get saveSessionTitle;

  /// No description provided for @saveSessionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'It\'ll be saved to your profile in Settings either way. Choose what happens next.'**
  String get saveSessionSubtitle;

  /// No description provided for @saveSessionDeleteRawLabel.
  ///
  /// In en, this message translates to:
  /// **'Also delete this session\'s raw heart-rate readings to free up space. The saved report itself is kept either way.'**
  String get saveSessionDeleteRawLabel;

  /// No description provided for @saveSessionStartNew.
  ///
  /// In en, this message translates to:
  /// **'Save & start new session'**
  String get saveSessionStartNew;

  /// No description provided for @saveSessionStopForNow.
  ///
  /// In en, this message translates to:
  /// **'Save & stop for now'**
  String get saveSessionStopForNow;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get commonSomethingWentWrong;

  /// No description provided for @changePasswordFillBoth.
  ///
  /// In en, this message translates to:
  /// **'Fill in both password fields.'**
  String get changePasswordFillBoth;

  /// No description provided for @changePasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'New password must be at least 8 characters.'**
  String get changePasswordTooShort;

  /// No description provided for @changePasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'New passwords don\'t match.'**
  String get changePasswordMismatch;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed.'**
  String get changePasswordSuccess;

  /// No description provided for @changePasswordCurrentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get changePasswordCurrentLabel;

  /// No description provided for @changePasswordNewLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get changePasswordNewLabel;

  /// No description provided for @changePasswordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get changePasswordConfirmLabel;

  /// No description provided for @forgotPasswordEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the reset code your researcher gave you.'**
  String get forgotPasswordEnterCode;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask your researcher for a reset code, then set a new password below.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset code'**
  String get forgotPasswordCodeLabel;

  /// No description provided for @forgotPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgotPasswordButton;

  /// No description provided for @mainLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get mainLater;

  /// No description provided for @mainChangeAnytimeSettings.
  ///
  /// In en, this message translates to:
  /// **'Change this anytime in Settings.'**
  String get mainChangeAnytimeSettings;

  /// No description provided for @mainNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay in the loop'**
  String get mainNotifTitle;

  /// No description provided for @mainNotifBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll ping you when your report\'s ready or your data needs attention.'**
  String get mainNotifBody;

  /// No description provided for @mainUploadConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Share your data automatically?'**
  String get mainUploadConsentTitle;

  /// No description provided for @mainUploadConsentBody.
  ///
  /// In en, this message translates to:
  /// **'PulseWatch can send your heart rate and movement readings to the research server in the background, so you never have to upload manually.'**
  String get mainUploadConsentBody;

  /// No description provided for @mainUploadConsentHint1.
  ///
  /// In en, this message translates to:
  /// **'Anonymized — your name and device ID are never included.'**
  String get mainUploadConsentHint1;

  /// No description provided for @mainAppLockEnabled.
  ///
  /// In en, this message translates to:
  /// **'App lock enabled'**
  String get mainAppLockEnabled;

  /// No description provided for @mainWatchDisconnectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Watch disconnected'**
  String get mainWatchDisconnectedTitle;

  /// No description provided for @mainWatchDisconnectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting automatically — tap to check.'**
  String get mainWatchDisconnectedMessage;

  /// No description provided for @mainDataLossTitle.
  ///
  /// In en, this message translates to:
  /// **'You could lose data'**
  String get mainDataLossTitle;

  /// No description provided for @mainBatteryRevokedMessage.
  ///
  /// In en, this message translates to:
  /// **'Background running was turned off — tap to fix it now.'**
  String get mainBatteryRevokedMessage;

  /// No description provided for @mainBluetoothOffMessage.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth is off, so PulseWatch can\'t reach your watch.'**
  String get mainBluetoothOffMessage;

  /// No description provided for @mainNoConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the server'**
  String get mainNoConnectionTitle;

  /// No description provided for @mainNoConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'Your data is still recording locally — it\'ll upload once you\'re back online.'**
  String get mainNoConnectionMessage;

  /// No description provided for @mainUploadNeededTitle.
  ///
  /// In en, this message translates to:
  /// **'Your data needs uploading'**
  String get mainUploadNeededTitle;

  /// No description provided for @mainUploadNeededBody.
  ///
  /// In en, this message translates to:
  /// **'PulseWatch hasn\'t been able to reach the server in over 12 hours, even though you\'re connected. Let\'s upload manually to make sure nothing is lost.'**
  String get mainUploadNeededBody;

  /// No description provided for @mainCouldNotReachServer.
  ///
  /// In en, this message translates to:
  /// **'Could not reach research server — check connection'**
  String get mainCouldNotReachServer;

  /// No description provided for @mainAutoUploaded.
  ///
  /// In en, this message translates to:
  /// **'Auto-uploaded {count} readings'**
  String mainAutoUploaded(int count);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @coachStep1Description.
  ///
  /// In en, this message translates to:
  /// **'Pair it once here — it reconnects on its own after that.'**
  String get coachStep1Description;

  /// No description provided for @coachStep2Description.
  ///
  /// In en, this message translates to:
  /// **'Your risk report is calculated once, from your full session — not a quick snapshot.'**
  String get coachStep2Description;

  /// No description provided for @coachStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Find your way around'**
  String get coachStep3Title;

  /// No description provided for @coachStep3Description.
  ///
  /// In en, this message translates to:
  /// **'Insights shows trends, Device handles connection, and Settings is where manual upload lives if you ever need it.'**
  String get coachStep3Description;

  /// No description provided for @mainLockPulseWatchTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock PulseWatch?'**
  String get mainLockPulseWatchTitle;

  /// No description provided for @mainLockPulseWatchBody.
  ///
  /// In en, this message translates to:
  /// **'Require your fingerprint or PIN to open the app.'**
  String get mainLockPulseWatchBody;

  /// No description provided for @mainBiometricRetryHint.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t verify — try again, or use PIN/pattern if biometrics aren\'t working right now.'**
  String get mainBiometricRetryHint;

  /// No description provided for @mainEnableButton.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get mainEnableButton;

  /// No description provided for @mainKeepRecordingReliableTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep recording reliable'**
  String get mainKeepRecordingReliableTitle;

  /// No description provided for @mainKeepRecordingReliableBody.
  ///
  /// In en, this message translates to:
  /// **'Battery settings can pause recording in the background — choose \"Allow\" or \"Unrestricted\" on the next screen.'**
  String get mainKeepRecordingReliableBody;

  /// No description provided for @mainAutostartTitle.
  ///
  /// In en, this message translates to:
  /// **'One more setting for reliable recording'**
  String get mainAutostartTitle;

  /// No description provided for @mainAutostartBody.
  ///
  /// In en, this message translates to:
  /// **'Your phone\'s manufacturer adds its own background-app permission on top of Android\'s — separate from the battery setting. Turn it on for PulseWatch so recording keeps working when the app isn\'t open.'**
  String get mainAutostartBody;

  /// No description provided for @mainOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get mainOpenSettings;

  /// No description provided for @coachSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get coachSkip;

  /// No description provided for @coachNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get coachNext;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
