import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../l10n/app_localizations.dart';
import '../services/report_service.dart';
import '../theme/app_theme.dart';
import '../widgets/loading_state.dart';
import 'report_screen.dart';

/// Every report a user has saved via Home's "Save report & start new
/// session" action — see DatabaseHelper's `reports` table and
/// ReportService.getReportHistory. Reached from Settings.
class ReportHistoryScreen extends StatefulWidget {
  const ReportHistoryScreen({super.key});

  @override
  State<ReportHistoryScreen> createState() => _ReportHistoryScreenState();
}

class _ReportHistoryScreenState extends State<ReportHistoryScreen> {
  bool _loading = true;
  List<FinalReport> _reports = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final reports = await ReportService.getReportHistory();
    if (mounted) {
      setState(() {
        _loading = false;
        _reports = reports;
      });
    }
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'LOW':
        return AppColors.primaryGreen;
      case 'MEDIUM':
        return AppColors.warning;
      default:
        return AppColors.error;
    }
  }

  String _riskLabel(String level) {
    final l10n = AppLocalizations.of(context)!;
    switch (level) {
      case 'LOW':
        return l10n.homeRiskLabelLow;
      case 'MEDIUM':
        return l10n.homeRiskLabelModerate;
      default:
        return l10n.homeRiskLabelHigh;
    }
  }

  String _formatDate(DateTime dt) {
    return DateFormat('MMM d, y · h:mm a', Localizations.localeOf(context).toString()).format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.settingsYourReports),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: _loading
          ? LoadingState(message: l10n.reportHistoryLoading)
          : _reports.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: _reports.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => _buildReportRow(_reports[i]),
                ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.archive_outlined, size: 40, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              l10n.reportHistoryEmptyTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.reportHistoryEmptyCaption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportRow(FinalReport report) {
    final color = _riskColor(report.riskLevel);
    final pct = (report.score * 100).round();

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ReportScreen(report: report)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle),
              child: Center(
                child: Text(
                  '$pct%',
                  style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _riskLabel(report.riskLevel),
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(report.computedAt),
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
