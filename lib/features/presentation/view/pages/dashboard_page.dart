import 'package:flutter/material.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/analytics_row_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/background_jobs_column_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/data_table_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/glass_card_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/left_side_bar_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/quick_stat_column_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/stat_card_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/team_status_column_widget.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/top_university_table.dart';
import 'package:flutter_dashboard/features/presentation/view/widgets/workflow_table_widget.dart';

// ==================== DASHBOARD PAGE ====================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Dummy data for runs (table)
  List<Map<String, dynamic>> get _dummyRuns => [
    {
      'runId': '6734',
      'workflow': 'Product Catalog Sync',
      'started': '22 Jun 2025, 10:48',
      'duration': '45.2s',
      'status': 'Running',
      'error': null,
    },
    {
      'runId': '6733',
      'workflow': 'Customer Webhook Listener',
      'started': '22 Jun 2025, 10:12',
      'duration': '30s',
      'status': 'Success',
      'error': null,
    },
    {
      'runId': '6732',
      'workflow': 'Data Enrichment Pipeline',
      'started': '22 Jun 2025, 09:45',
      'duration': '2m 15s',
      'status': 'Success',
      'error': null,
    },
    {
      'runId': '6731',
      'workflow': 'Analytics Refresh',
      'started': '22 Jun 2025, 09:30',
      'duration': '1m 8s',
      'status': 'Success',
      'error': null,
    },
    {
      'runId': '6730',
      'workflow': 'Billing Reconciliation',
      'started': '22 Jun 2025, 09:15',
      'duration': '3m 22s',
      'status': 'Failed',
      'error':
          'Timeout writing to blockchain replica node. Retry scheduled automatically.',
    },
  ];

  // Dummy data for team status
  List<Map<String, String>> get _team => [
    {
      'name': 'Clara Blackwood',
      'title': 'Engineer · On-call',
      'status': 'online',
    },
    {
      'name': 'Michael Whitmore',
      'title': 'Owner · Available',
      'status': 'online',
    },
    {
      'name': 'Dennis Brightwood',
      'title': 'Engineer · Available in 2hrs',
      'status': 'away',
    },
    {'name': 'Sarah Chen', 'title': 'Designer · In meeting', 'status': 'busy'},
  ];

  // Dummy stats for quick cards

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Responsive layout: left main column plus right sidebar
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // ---------------- LEFT SIDEBAR (compact, white) ----------------
            LeftSideBarWidget(),

            // ---------------- MAIN CONTENT (stretch) ----------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page header
                    const SizedBox(height: 18),

                    // Pink-ish thin separator
                    Container(height: 1, color: Colors.grey.shade200),

                    const SizedBox(height: 18),

                    // --- Add below AppBar or Dashboard title ---
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          StateCardWidget(
                            color: Colors.deepPurple.shade400,
                            icon: Icons.verified,
                            title: "Total Certificates",
                            value: "12,543",
                            subtitle: "+15% from last month",
                          ),

                          StateCardWidget(
                            color: Colors.green.shade400,
                            icon: Icons.school,
                            title: "Institutions",
                            value: "256",
                            subtitle: "+5 new this month",
                          ),

                          StateCardWidget(
                            color: Colors.orange.shade400,
                            icon: Icons.check_circle,
                            title: "Verifications",
                            value: "45,129",
                            subtitle: "+23% from last month",
                          ),

                          StateCardWidget(
                            color: Colors.red.shade400,
                            icon: Icons.pending_actions,
                            title: "Pending Approvals",
                            value: "28",
                            subtitle: "12 urgent",
                          ),
                        ],
                      ),
                    ),

                    // --- Add below Graphs Section ---
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: DataTableWidget(),
                      ),
                    ),
                    // Row: left big column (cards + table) and right column (quick stats + team)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT MAIN COLUMN
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              // The runs table card (glassmorphism card)
                              GlassCardWidget(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Table header labels
                                    WorkFlowTableHeaderWidget(),
                                    const Divider(),
                                    // Data rows - static
                                    ..._dummyRuns.map((r) => _runRow(r)),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Charts / analytics row
                              AnalyticsRowWidget(),
                              const SizedBox(height: 20),
                              // --- Add below Top Universities Table ---
                              TopUniversityTable(),
                            ],
                          ),
                        ),

                        const SizedBox(width: 24),

                        // RIGHT SIDEBAR: Quick stats, Team Status, Recent small list
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              // Quick Stats (each card)
                              GlassCardWidget(child: QuickStatColumnWidget()),
                              const SizedBox(height: 18),

                              // Team status card
                              GlassCardWidget(child: TeamStatusColumnWidget()),

                              const SizedBox(height: 18),

                              // Small right column list (like the screenshot's small activity list)
                              GlassCardWidget(
                                child: BackgroundJobsColumnWidget(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // optional small right margin for spacing
            Container(width: 18, color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  Widget _runRow(Map<String, dynamic> run) {
    Color statusColor;
    switch (run['status']) {
      case 'Success':
        statusColor = Colors.green;
        break;
      case 'Failed':
        statusColor = Colors.redAccent;
        break;
      case 'Running':
        statusColor = Colors.blueAccent;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(run['runId'])),
              Expanded(flex: 4, child: Text(run['workflow'])),
              Expanded(
                flex: 3,
                child: Text(
                  run['started'],
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
              Expanded(flex: 2, child: Text(run['duration'])),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    run['status'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: run['error'] == null
                    ? const Text(
                        'None',
                        style: TextStyle(color: Colors.black54),
                      )
                    : Row(
                        children: const [
                          Icon(
                            Icons.error_outline,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'View Error',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
