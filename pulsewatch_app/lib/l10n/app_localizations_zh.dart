// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get landingTitle => '48小时，\n读懂你的心脏';

  @override
  String get landingSubtitle => '一项科研级心脏监测研究，佩戴在你的手腕上进行。';

  @override
  String get landingStep1Title => '连接你的手环';

  @override
  String get landingStep1Subtitle => '配对一次，之后会自动重新连接';

  @override
  String get landingStep2Title => '连续佩戴48小时';

  @override
  String get landingStep2Subtitle => '全天佩戴，睡觉时也不摘下';

  @override
  String get landingStep3Title => '获取你的风险报告';

  @override
  String get landingStep3Subtitle => '基于完整记录一次性评分';

  @override
  String get landingGetStarted => '开始使用';

  @override
  String get landingSignIn => '已经注册？登录';

  @override
  String get settingsLanguage => '语言';

  @override
  String get languageSheetTitle => '选择语言';

  @override
  String get languageEnglishName => 'English';

  @override
  String get languageChineseName => '中文';

  @override
  String get commonCancel => '取消';

  @override
  String get commonContinue => '继续';

  @override
  String get commonDone => '完成';

  @override
  String get commonClose => '关闭';

  @override
  String get riskLow => '低风险';

  @override
  String get riskModerate => '中等风险';

  @override
  String get riskHigh => '高风险';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLoading => '正在加载设置…';

  @override
  String get sectionAccount => '账户';

  @override
  String get sectionRecording => '记录';

  @override
  String get sectionPrivacySecurity => '隐私与安全';

  @override
  String get sectionData => '数据';

  @override
  String get sectionSupport => '支持';

  @override
  String get sectionAbout => '关于';

  @override
  String get settingsYourReports => '你的报告';

  @override
  String get settingsChangePassword => '修改密码';

  @override
  String get settingsStartNewRecording => '开始新的记录';

  @override
  String get settingsStopRecording => '停止记录';

  @override
  String get settingsStarting => '正在开始…';

  @override
  String get settingsStopping => '正在停止…';

  @override
  String get settingsAppLock => '应用锁';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsAutomaticUpload => '自动上传';

  @override
  String get settingsContactSupport => '联系支持';

  @override
  String get settingsRequestWithdraw => '申请退出研究';

  @override
  String get settingsLogout => '登出';

  @override
  String get settingsBiometricVerifyFailed => '验证失败——应用锁未启用，请重试。';

  @override
  String get settingsUploadConsentOffTitle => '关闭前请注意';

  @override
  String get settingsUploadConsentOffBody =>
      'PulseWatch AI 是一项研究项目，通过日常可穿戴设备数据研究心脏风险。你分享的每一条读数都有助于训练和验证模型——对你和未来的参与者都是如此。关闭此项后，你的数据将不再自动发送给研究团队。';

  @override
  String get settingsUploadConsentKeepSharing => '继续分享我的数据';

  @override
  String get settingsUploadConsentTurnOff => '仍然关闭';

  @override
  String get settingsStopRecordingTitle => '停止记录？';

  @override
  String get settingsStopRecordingBody =>
      '数据采集将立即停止，在你开始新的记录之前不会再记录任何内容。请确认这是你想要的。';

  @override
  String get settingsKeepRecording => '继续记录';

  @override
  String get settingsCantOpenLink => '无法打开——没有找到可处理该操作的应用。';

  @override
  String get settingsWithdrawTitle => '申请退出？';

  @override
  String get settingsWithdrawBody =>
      '这将打开一封发送给研究团队的邮件，请求将你退出本研究并删除你的数据。在他们与你确认之前，不会有任何变化。';

  @override
  String get settingsLogoutTitle => '登出？';

  @override
  String get settingsLogoutBody => '重新登录时，你需要用户名和密码（或新的注册代码）。';

  @override
  String get settingsConnectedToServer => '已连接到服务器';

  @override
  String get settingsCouldNotConnect => '无法连接';

  @override
  String get settingsEnterServerUrlFirst => '请先输入服务器地址';

  @override
  String get settingsNeverUploaded => '从未上传';

  @override
  String get settingsUploadedJustNow => '刚刚上传';

  @override
  String settingsUploadedMinutesAgo(int minutes) {
    return '$minutes 分钟前上传';
  }

  @override
  String settingsUploadedHoursAgo(int hours) {
    return '$hours 小时前上传';
  }

  @override
  String settingsUploadedDaysAgo(int days) {
    return '$days 天前上传';
  }

  @override
  String get settingsNoReportsYet => '尚未保存任何报告';

  @override
  String settingsReportsSavedOnly(int count) {
    return '已保存 $count 份';
  }

  @override
  String settingsReportsSubtitle(int count, String risk) {
    return '已保存 $count 份 · 最新：$risk';
  }

  @override
  String get settingsDataUpload => '数据上传';

  @override
  String settingsPendingReadings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '还有 $count 条记录未上传',
    );
    return '$_temp0';
  }

  @override
  String get settingsEverythingUploaded => '所有数据均已上传';

  @override
  String get settingsUploadNow => '立即上传';

  @override
  String get settingsUpToDate => '已是最新';

  @override
  String get settingsAdvancedServerAddress => '高级：服务器地址';

  @override
  String get settingsConnectedStatus => '已连接';

  @override
  String get settingsDefaultParticipantName => '参与者';

  @override
  String settingsResearchId(String id) {
    return '研究编号：$id';
  }

  @override
  String get aboutTagline => '在心脏硬化出现症状的多年前就发现它。';

  @override
  String get aboutEyebrow => '心脏研究 · 布加勒斯特理工大学外语工程学院（FILS）';

  @override
  String get aboutBody =>
      'Pulsana 是一项围绕手腕手环和人工智能模型展开的研究项目：它在你日常生活时持续观察心率变异性，并在常规体检发现之前，提前标记出早期预警信号。';

  @override
  String get aboutResearchTeamLabel => '研究团队';

  @override
  String aboutVersion(String version) {
    return 'PulseWatch AI · 版本 $version';
  }

  @override
  String get settingsUploadingEllipsis => '正在上传…';

  @override
  String get settingsUploadingHint => '上传完成前请不要关闭应用。';

  @override
  String get settingsUploadComplete => '上传完成';

  @override
  String get settingsUploadFailed => '上传失败';

  @override
  String get homeReportSavedStopped => '报告已保存——记录已停止。';

  @override
  String get homeReportSavedNewSession => '报告已保存——正在开始新的记录。';

  @override
  String get homeNotEnoughData => '数据还不够';

  @override
  String get homeMoreActive => '活动量增加';

  @override
  String get homeLessActive => '活动量减少';

  @override
  String get homeAboutTheSame => '与平时差不多';

  @override
  String get homeMovementCaption => '与昨天同一时间相比';

  @override
  String get homeRiskLabelLow => '低风险';

  @override
  String get homeRiskLabelModerate => '中等';

  @override
  String get homeRiskLabelHigh => '高风险';

  @override
  String get homeGreetingMorning => '早上好';

  @override
  String homeGreetingMorningNamed(String name) {
    return '早上好，$name';
  }

  @override
  String get homeGreetingAfternoon => '下午好';

  @override
  String homeGreetingAfternoonNamed(String name) {
    return '下午好，$name';
  }

  @override
  String get homeGreetingEvening => '晚上好';

  @override
  String homeGreetingEveningNamed(String name) {
    return '晚上好，$name';
  }

  @override
  String get homeWatchConnected => '手环已连接';

  @override
  String get homeTapToConnect => '点击连接手环';

  @override
  String get homeUploadBacklogText => '你的数据已有一段时间未同步到服务器——点击手动上传。';

  @override
  String get homeNoConnectionText => '无法连接到研究服务器——请检查网络连接。';

  @override
  String get homeLoadErrorTitle => '无法加载你的主页数据';

  @override
  String get homeLoadErrorCaption =>
      '读取数据时出了点问题。请重试——如果反复出现，请使用「设置」中的「联系支持」并附上下方的详细信息。';

  @override
  String get homeTryAgain => '重试';

  @override
  String get homePausedTitle => '记录已停止';

  @override
  String get homePausedCaption => '准备好后随时可以开始新的记录。';

  @override
  String get homeYoureRecording => '正在记录';

  @override
  String get homeKeepWearingCaption => '继续佩戴你的手环——第一小时的数据很快就会显示。';

  @override
  String get homeWaitingFirstReading => '等待第一条读数';

  @override
  String get homeKeepNearbyCaption =>
      '让手环保持在附近——它会每 15-20 分钟在后台同步一次，因此第一条读数可能需要一点时间才会显示。';

  @override
  String get homeReadyTitle => '准备好随时开始';

  @override
  String get homeReadyCaption => '连接你的手环，开始你的 48 小时记录。完成后即可解锁你的心脏风险报告。';

  @override
  String get homeJustStartedTitle => '刚刚开始';

  @override
  String homeJustStartedCaption(int hours) {
    return '目前已记录 48 小时中的 $hours 小时。请继续佩戴手环，度过今天和今晚。';
  }

  @override
  String get homeHalfwayTitle => '已过半程';

  @override
  String homeHalfwayCaption(int hours) {
    return '还剩约 $hours 小时（含今晚）。每多佩戴一小时，数据都会更完整。';
  }

  @override
  String get homeOf48h => '/ 48小时';

  @override
  String get homeFactRestingHR => '静息心率（昨晚）';

  @override
  String get homeFactSignalQuality => '今日信号质量';

  @override
  String homeWornToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '今日已佩戴，$count 次中断',
      zero: '今日已佩戴，无中断',
    );
    return '$_temp0';
  }

  @override
  String get homeGeneratingTitle => '正在生成你的报告';

  @override
  String get homeGeneratingCaption => '已收集 48 小时数据——正在对你的完整记录进行评分。';

  @override
  String get homeCardiacRiskReport => '心脏风险报告';

  @override
  String homeGeneratedAt(String time) {
    return '生成于 $time · 基于你的完整记录';
  }

  @override
  String get homeViewFullReport => '查看完整报告';

  @override
  String get homeSaving => '正在保存…';

  @override
  String get homeSaveReport => '保存报告…';

  @override
  String get homeLoadingDashboard => '正在加载主页数据…';

  @override
  String get commonGotIt => '知道了';

  @override
  String get dayToday => '今天';

  @override
  String get dayYesterday => '昨天';

  @override
  String get timeAm => '上午';

  @override
  String get timePm => '下午';

  @override
  String get signalGood => '信号良好';

  @override
  String get signalWeak => '信号较弱';

  @override
  String get signalNotWorn => '未佩戴';

  @override
  String get insightsTitle => '数据洞察';

  @override
  String get insightsLoadingMessage => '正在分析你的心率数据…';

  @override
  String get insightsEmptyTitle => '暂无数据可显示';

  @override
  String get insightsEmptyCaption => '开始记录后，你的心率趋势和佩戴时长会显示在这里。';

  @override
  String get insightsErrorTitle => '无法加载你的趋势数据';

  @override
  String get insightsErrorCaption =>
      '读取数据时出了点问题。请重试——如果反复出现，请使用「设置」中的「联系支持」并附上下方的详细信息。';

  @override
  String get insightsHeartRateLabel => '心率';

  @override
  String insightsSessionLength(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 小时记录',
      one: '1 小时',
    );
    return '$_temp0';
  }

  @override
  String get chartLegendRange => '范围';

  @override
  String get chartLegendMean => '平均值';

  @override
  String get chartLegendNightHours => '夜间时段';

  @override
  String get chartNowLabel => '现在';

  @override
  String get chartInfoTooltip => '了解这张图表的含义';

  @override
  String get chartInfoTitle => '关于这张图表';

  @override
  String get chartInfoIntro => '每半小时的数据会被概括成几个数字，让你一眼就能看出这段记录的整体形态。';

  @override
  String get chartInfoRangeBody =>
      '阴影区域和虚线边缘标出了该半小时内出现的最低和最高心率——而不仅仅是平均值，所以短暂的峰值或低谷也不会被平滑掉。';

  @override
  String get chartInfoMeanBody => '实线代表该半小时内的平均心率。';

  @override
  String get chartInfoNightBody =>
      '晚上 10 点到早上 7 点之间的阴影背景只是帮助你在时间轴上定位——并不代表你的数据有任何问题。';

  @override
  String get chartInfoHatchedTitle => '斜纹区域';

  @override
  String get chartInfoHatchedBody =>
      '斜纹填充的间隔表示这段时间内没有采集到读数——通常是手环处于关闭、超出范围或信号丢失状态。';

  @override
  String get statLowest => '最低';

  @override
  String get statTypical => '典型值';

  @override
  String get statPeak => '峰值';

  @override
  String get statWorn => '已佩戴';

  @override
  String get statGaps => '中断次数';

  @override
  String get statAvgSignal => '平均信号';

  @override
  String insightGapDurationLabel(int hours) {
    return '$hours 小时';
  }

  @override
  String insightGapExtra(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '（另有 $count 次较短的中断）',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String get insightGapTipSleep => '如果它是在夜间不小心滑落的，睡前把表带收紧一格通常能帮助它更贴合。';

  @override
  String get insightGapTipDay =>
      '如果你是主动摘下的（洗澡、充电、运动），完全没问题——只要尽快重新戴上，就不会错过太多数据。';

  @override
  String insightGapMessage(
    String duration,
    String window,
    String extra,
    String tip,
  ) {
    return '我们注意到在 $window 附近有一段 $duration 的中断$extra。$tip';
  }

  @override
  String insightWeakMessage(String window) {
    return '在 $window 附近信号有点弱。佩戴再紧一点——大约留一指宽的松量——通常能帮助传感器保持稳定接触。';
  }

  @override
  String get insightGreatConsistency => '非常稳定——你在整个记录期间都佩戴了手环，且信号始终良好。继续保持！';

  @override
  String runDetailDuration(int count) {
    return '$count 小时';
  }

  @override
  String runDetailSnackbar(String label, String window, String duration) {
    return '$label • $window • $duration';
  }

  @override
  String get commonAllow => '允许';

  @override
  String get commonNotNow => '暂不';

  @override
  String get deviceTitle => '设备';

  @override
  String get deviceDebugTooltip => '预览控件';

  @override
  String get deviceBleRationaleBody => 'PulseWatch 需要通过蓝牙与你的手环通信。';

  @override
  String get deviceConnectedSuccess => '✅ 已连接！';

  @override
  String deviceConnectionFailed(String reason) {
    return '❌ $reason';
  }

  @override
  String get deviceConnectionFailedDefault => '连接失败';

  @override
  String deviceRelativeSeconds(int seconds) {
    return '$seconds 秒前';
  }

  @override
  String deviceRelativeMinutes(int minutes) {
    return '$minutes 分钟前';
  }

  @override
  String deviceRelativeHours(int hours) {
    return '$hours 小时前';
  }

  @override
  String deviceRelativeDays(int days) {
    return '$days 天前';
  }

  @override
  String deviceDurationMinutes(int minutes) {
    return '$minutes 分钟';
  }

  @override
  String deviceDurationHours(int hours) {
    return '$hours 小时';
  }

  @override
  String deviceDurationHoursMinutes(int hours, int minutes) {
    return '$hours 小时 $minutes 分钟';
  }

  @override
  String get deviceDisconnectTitle => '断开手环连接？';

  @override
  String get deviceDisconnectBody =>
      '断开后将停止采集心率数据，直到重新连接——请尽快重新戴上手环，以免错过太多本次记录的数据。';

  @override
  String get deviceDisconnect => '断开连接';

  @override
  String get deviceStayConnected => '保持连接';

  @override
  String get deviceDisconnectedSnackbar => '已断开连接';

  @override
  String get deviceUnknownDevice => '未知设备';

  @override
  String get deviceNoSignalYet => '暂无信号';

  @override
  String get deviceGoodContact => '接触良好';

  @override
  String get deviceSignalWeak => '信号偏弱';

  @override
  String get devicePoorContact => '接触不良';

  @override
  String get deviceSignalQualityCaption => '传感器信号质量';

  @override
  String get deviceNoReadingsYet => '暂无读数';

  @override
  String deviceLastReading(String time) {
    return '上一次读数：$time';
  }

  @override
  String deviceGapExtra(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '（另有 $count 个）',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String deviceNoNewDataFor(String duration, String extra) {
    return '已 $duration 没有新数据$extra';
  }

  @override
  String deviceOneGap(String duration, String time, String extra) {
    return '$time出现过一次 $duration 的中断$extra';
  }

  @override
  String get deviceConnectedStatus => '已连接';

  @override
  String get deviceNotConnectedStatus => '未连接';

  @override
  String get deviceScanPrompt => '扫描以查找你的手环';

  @override
  String get deviceScanningEllipsis => '正在扫描…';

  @override
  String get deviceScanForDevices => '扫描设备';

  @override
  String get deviceStreamingAutomatically => '已连接——数据自动同步中';

  @override
  String get deviceFoundDevices => '已发现的设备';

  @override
  String get deviceConnectButton => '连接';

  @override
  String get deviceLoadingCaption => '正在检查手环数据…';

  @override
  String reportShareError(String error) {
    return '无法分享报告：$error';
  }

  @override
  String get reportAppBarTitle => '心脏硬化风险报告';

  @override
  String get reportShareTooltip => '分享报告';

  @override
  String get reportOrgLine => 'AI 手环系统 · 布加勒斯特理工大学（NUST Politehnica Bucharest）';

  @override
  String get reportDisclaimer =>
      '⚠ 这是一个研究原型，不是医疗设备。本报告旨在辅助而非替代临床评估。评分高于 30% 时应建议转诊心脏科医生。所有分析均在你的设备本地完成，不会上传任何数据。';

  @override
  String get reportCardiacRiskScoreLabel => '心脏风险评分';

  @override
  String get reportRiskBadgeLow => '低风险';

  @override
  String get reportRiskBadgeMedium => '中等风险';

  @override
  String get reportRiskBadgeHigh => '高风险';

  @override
  String get reportScale0 => '0% — 健康';

  @override
  String get reportScale50 => '50%';

  @override
  String get reportScale100 => '100% — 高风险';

  @override
  String get reportSessionOverview => '记录概览';

  @override
  String get reportWindowsAnalysed => '分析窗口数';

  @override
  String get reportDataRows => '数据行数';

  @override
  String get reportSessionDuration => '记录时长';

  @override
  String reportSessionDurationValue(String hours) {
    return '约 $hours 小时';
  }

  @override
  String get reportMeanHr => '平均心率';

  @override
  String get reportMeanRmssd => '平均 RMSSD';

  @override
  String get reportGenerated => '生成时间';

  @override
  String get reportTopFeatures => '主要影响因素';

  @override
  String get reportFooter =>
      '由 AI 手环心脏硬化早期检测系统生成 · 模型：XGBoost（AUC 0.986，准确率 93.7%）· Daria Gladkykh · FatemehSadat MahmoudzadehHosseini · Prof. Dr. Ing. Nicolae Goga';

  @override
  String get reportHistoryLoading => '正在加载已保存的报告…';

  @override
  String get reportHistoryEmptyTitle => '暂无已保存的报告';

  @override
  String get reportHistoryEmptyCaption =>
      '完成一次 48 小时的记录后，在主页使用「保存报告并开始新的记录」即可保存在这里。';

  @override
  String get commonBack => '返回';

  @override
  String get commonShowPassword => '显示密码';

  @override
  String get commonHidePassword => '隐藏密码';

  @override
  String get enrollTitle => '设置你的\n账户';

  @override
  String get enrollSubtitle => '输入研究人员提供给你的代码，\n然后设置用户名和密码。';

  @override
  String get enrollCodeLabel => '注册代码';

  @override
  String get enrollCodeValidator => '请输入 8 位代码';

  @override
  String get enrollUsernameLabel => '设置用户名';

  @override
  String get enrollUsernameValidator => '请输入用户名';

  @override
  String get enrollPasswordLabel => '设置密码';

  @override
  String get enrollPasswordHint => '至少 8 个字符';

  @override
  String get enrollPasswordValidator => '密码至少需要 8 个字符';

  @override
  String get enrollConfirmPasswordLabel => '确认密码';

  @override
  String get enrollConfirmPasswordHint => '请再次输入密码';

  @override
  String get enrollPasswordMismatch => '两次输入的密码不一致';

  @override
  String get enrollPasswordsMatch => '密码一致';

  @override
  String get enrollCreateAccount => '创建账户';

  @override
  String get enrollAlreadyHaveAccount => '我已经有账户了';

  @override
  String get loginWelcomeBack => '欢迎回来';

  @override
  String get loginSubtitle => '使用你之前设置的用户名和密码登录。';

  @override
  String get loginUsernameHint => '用户名';

  @override
  String get loginUsernameValidator => '请输入用户名';

  @override
  String get loginPasswordHint => '密码';

  @override
  String get loginPasswordValidator => '请输入密码';

  @override
  String get loginForgotPassword => '忘记密码？';

  @override
  String get loginButton => '登录';

  @override
  String get loginSwitchToEnroll => '我有注册代码';

  @override
  String get lockTitle => 'PulseWatch 已锁定';

  @override
  String get lockSubtitle => '解锁后即可查看你的健康数据。';

  @override
  String get lockVerifyFailed => '验证失败——请重试';

  @override
  String get lockChecking => '正在验证…';

  @override
  String get lockUnlockButton => '解锁';

  @override
  String get saveSessionTitle => '保存此报告';

  @override
  String get saveSessionSubtitle => '无论选择哪种方式，报告都会保存到「设置」中的你的个人资料里。请选择接下来的操作。';

  @override
  String get saveSessionDeleteRawLabel =>
      '同时删除本次记录的原始心率数据以释放空间。保存的报告本身无论如何都会保留。';

  @override
  String get saveSessionStartNew => '保存并开始新的记录';

  @override
  String get saveSessionStopForNow => '保存并暂时停止';

  @override
  String get commonSomethingWentWrong => '出了点问题。';

  @override
  String get changePasswordFillBoth => '请填写两个密码字段。';

  @override
  String get changePasswordTooShort => '新密码至少需要 8 个字符。';

  @override
  String get changePasswordMismatch => '两次输入的新密码不一致。';

  @override
  String get changePasswordSuccess => '密码已修改。';

  @override
  String get changePasswordCurrentLabel => '当前密码';

  @override
  String get changePasswordNewLabel => '新密码';

  @override
  String get changePasswordConfirmLabel => '确认新密码';

  @override
  String get forgotPasswordEnterCode => '请输入研究人员提供给你的重置代码。';

  @override
  String get forgotPasswordTitle => '重置密码';

  @override
  String get forgotPasswordSubtitle => '向研究人员索取重置代码，然后在下方设置新密码。';

  @override
  String get forgotPasswordCodeLabel => '重置代码';

  @override
  String get forgotPasswordButton => '重置密码';

  @override
  String get mainLater => '稍后';

  @override
  String get mainChangeAnytimeSettings => '可随时在「设置」中更改。';

  @override
  String get mainNotifTitle => '第一时间获知动态';

  @override
  String get mainNotifBody => '报告生成完毕或数据需要处理时，我们会提醒你。';

  @override
  String get mainUploadConsentTitle => '自动分享你的数据？';

  @override
  String get mainUploadConsentBody =>
      'PulseWatch 可以在后台自动将你的心率和运动数据发送到研究服务器，无需手动上传。';

  @override
  String get mainUploadConsentHint1 => '已匿名化——绝不包含你的姓名和设备标识。';

  @override
  String get mainAppLockEnabled => '应用锁已启用';

  @override
  String get mainWatchDisconnectedTitle => '手环已断开连接';

  @override
  String get mainWatchDisconnectedMessage => '正在自动重新连接——点击查看。';

  @override
  String get mainDataLossTitle => '你可能会丢失数据';

  @override
  String get mainBatteryRevokedMessage => '后台运行权限已被关闭——点击立即修复。';

  @override
  String get mainBluetoothOffMessage => '蓝牙已关闭，PulseWatch 无法连接到你的手环。';

  @override
  String get mainNoConnectionTitle => '无法连接到服务器';

  @override
  String get mainNoConnectionMessage => '你的数据仍在本地记录——恢复网络连接后会自动上传。';

  @override
  String get mainUploadNeededTitle => '你的数据需要上传';

  @override
  String get mainUploadNeededBody =>
      '尽管已联网，PulseWatch 已经超过 12 小时无法连接到服务器。让我们手动上传一次，确保数据不会丢失。';

  @override
  String get mainCouldNotReachServer => '无法连接到研究服务器——请检查网络连接';

  @override
  String mainAutoUploaded(int count) {
    return '已自动上传 $count 条记录';
  }

  @override
  String get navHome => '主页';

  @override
  String get coachStep1Description => '在这里配对一次，之后会自动重新连接。';

  @override
  String get coachStep2Description => '你的风险报告基于完整记录一次性计算——而不是简单的快照。';

  @override
  String get coachStep3Title => '熟悉一下界面';

  @override
  String get coachStep3Description => '「数据洞察」展示趋势，「设备」用于管理连接，「设置」里则有手动上传等功能。';

  @override
  String get mainLockPulseWatchTitle => '锁定 PulseWatch？';

  @override
  String get mainLockPulseWatchBody => '打开应用时需要验证指纹或 PIN。';

  @override
  String get mainBiometricRetryHint =>
      '验证失败——请重试，如果生物识别暂时无法使用，也可以使用 PIN 或图案解锁。';

  @override
  String get mainEnableButton => '启用';

  @override
  String get mainKeepRecordingReliableTitle => '保持记录稳定可靠';

  @override
  String get mainKeepRecordingReliableBody =>
      '电池设置可能会暂停后台记录——请在下一屏选择「允许」或「不受限制」。';

  @override
  String get mainAutostartTitle => '还有一项设置有助于稳定记录';

  @override
  String get mainAutostartBody =>
      '你手机的厂商在 Android 系统之上又加了一层自己的后台应用权限——与电池设置是分开的。请为 PulseWatch 开启此权限，这样即使应用未打开，记录也能持续进行。';

  @override
  String get mainOpenSettings => '前往设置';

  @override
  String get coachSkip => '跳过';

  @override
  String get coachNext => '下一步';
}
