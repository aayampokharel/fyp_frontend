import 'dart:ui'; // for blur in glassmorphism
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ==================== MAIN APP ====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Primary purple and matching palette used across the app
  static const Color primaryPurple = Color(0xFF6A1B9A);
  static const Color accentPurple = Color(0xFF8E24AA);
  static const Color softPurple = Color(0xFFEDE7F6);
  static const Color lightGray = Color(0xFFF6F7FB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Admin Dashboard (Static UI)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryPurple,
        scaffoldBackgroundColor: lightGray,
        fontFamily: 'Exo', // keeps continuity with your earlier font preference
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}

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
  Map<String, String> get _stats => {
    'Total Certs': '12,543',
    'Institutions': '256',
    'Verifications': '45,129',
    'Pending': '28',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Responsive layout: left main column plus right sidebar
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // ---------------- LEFT SIDEBAR (compact, white) ----------------
            Container(
              width: 220,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo area
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: MyApp.primaryPurple,
                          child: const Icon(
                            Icons.security,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Admin Panel',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Nav items (static - no navigation)
                    _navItem(Icons.dashboard_rounded, 'Dashboard', true),
                    _navItem(Icons.verified_outlined, 'Certificates', false),
                    _navItem(Icons.school_outlined, 'Institutions', false),
                    _navItem(Icons.analytics_outlined, 'Analytics', false),
                    _navItem(Icons.settings_outlined, 'Settings', false),

                    const Spacer(),

                    // User info at bottom of sidebar
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black12,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Mycoder',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------------- MAIN CONTENT (stretch) ----------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent Workflow Runs',
                          style: TextStyle(
                            color: MyApp.primaryPurple,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Monitor your workflow executions and performance',
                          style: TextStyle(color: Colors.black54),
                        ),
                        const Spacer(),
                        // Filter button and View All button (static)
                        _glassButtonRow(),
                      ],
                    ),
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
                          _buildStatCard(
                            color: Colors.deepPurple.shade400,
                            icon: Icons.verified,
                            title: "Total Certificates",
                            value: "12,543",
                            subtitle: "+15% from last month",
                          ),
                          _buildStatCard(
                            color: Colors.green.shade400,
                            icon: Icons.school,
                            title: "Institutions",
                            value: "256",
                            subtitle: "+5 new this month",
                          ),
                          _buildStatCard(
                            color: Colors.orange.shade400,
                            icon: Icons.check_circle,
                            title: "Verifications",
                            value: "45,129",
                            subtitle: "+23% from last month",
                          ),
                          _buildStatCard(
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
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text("Rank")),
                            DataColumn(label: Text("Institution")),
                            DataColumn(label: Text("Certificates")),
                            DataColumn(label: Text("Growth")),
                            DataColumn(label: Text("Status")),
                          ],
                          rows: const [
                            DataRow(
                              cells: [
                                DataCell(Text("1")),
                                DataCell(Text("Harvard University")),
                                DataCell(Text("2,543")),
                                DataCell(Text("+12%")),
                                DataCell(Text("Active")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text("2")),
                                DataCell(Text("MIT")),
                                DataCell(Text("2,128")),
                                DataCell(Text("+8%")),
                                DataCell(Text("Active")),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text("3")),
                                DataCell(Text("Stanford University")),
                                DataCell(Text("1,897")),
                                DataCell(Text("+15%")),
                                DataCell(Text("Active")),
                              ],
                            ),
                          ],
                        ),
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
                              _glassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Table header labels
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 6,
                                      ),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Run ID',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              'Workflow',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Started',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Duration',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Status',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Error',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    // Data rows - static
                                    ..._dummyRuns
                                        .map((r) => _runRow(r))
                                        .toList(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Charts / analytics row
                              Row(
                                children: [
                                  Expanded(
                                    child: _glassCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Certificate Growth',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Monthly certificate issuance (preview)',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 14),
                                          // Simple static line-ish "chart" using stacked bars with differing heights
                                          SizedBox(
                                            height: 120,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: List.generate(12, (i) {
                                                final heights = [
                                                  30,
                                                  42,
                                                  55,
                                                  70,
                                                  65,
                                                  90,
                                                  130,
                                                  115,
                                                  95,
                                                  80,
                                                  60,
                                                  45,
                                                ];
                                                return Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 4.0,
                                                        ),
                                                    child: Container(
                                                      height: heights[i]
                                                          .toDouble(),
                                                      decoration: BoxDecoration(
                                                        color: i == 6
                                                            ? MyApp
                                                                  .primaryPurple
                                                            : MyApp
                                                                  .primaryPurple
                                                                  .withOpacity(
                                                                    0.18,
                                                                  ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              6,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          // X axis labels
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Jan',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                'Feb',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                'Mar',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                'Apr',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                'May',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                'Jun',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    child: _glassCard(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Certificate Types',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            'Distribution by category',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          // Simple donut-like static representation using stacked containers
                                          Row(
                                            children: [
                                              // small legend and pseudo donut
                                              Column(
                                                children: [
                                                  // pseudo donut using circles
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        width: 70,
                                                        height: 70,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyApp
                                                                  .primaryPurple
                                                                  .withOpacity(
                                                                    0.18,
                                                                  ),
                                                            ),
                                                      ),
                                                      Container(
                                                        width: 44,
                                                        height: 44,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                      Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: MyApp
                                                                  .primaryPurple,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 12),
                                              // legend
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    SizedBox(height: 6),
                                                    Text(
                                                      'Degree Certificates',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text(
                                                      'Diploma Certificates',
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text(
                                                      'Short Course',
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ),
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
                                ],
                              ),
                              const SizedBox(height: 20),

                              // --- Add below Top Universities Table ---
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Recent Certificate Activities",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      _activityItem(
                                        icon: Icons.verified,
                                        color: Colors.blue,
                                        text:
                                            "Certificate issued to John Doe (Harvard)",
                                        time: "2 hours ago",
                                      ),
                                      _activityItem(
                                        icon: Icons.check_circle,
                                        color: Colors.green,
                                        text:
                                            "Certificate verified for Jane Smith (MIT)",
                                        time: "5 hours ago",
                                      ),
                                      _activityItem(
                                        icon: Icons.error_outline,
                                        color: Colors.orange,
                                        text:
                                            "Certificate revoked for Bob Lee (Oxford)",
                                        time: "1 day ago",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                              _glassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Quick Stats',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // grid of small stat tiles
                                    Column(
                                      children: _stats.entries.map((e) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.key,
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                e.value,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),

                              // Team status card
                              _glassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Team Status',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      children: _team.map((member) {
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                // small avatar and status dot
                                                Stack(
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 18,
                                                      backgroundColor:
                                                          Colors.black12,
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              member['status'] ==
                                                                  'online'
                                                              ? Colors.green
                                                              : (member['status'] ==
                                                                        'busy'
                                                                    ? Colors.red
                                                                    : Colors
                                                                          .orange),
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        member['name']!,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        member['title']!,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 18),

                              // Small right column list (like the screenshot's small activity list)
                              _glassCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Background Jobs',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.green,
                                      ),
                                      title: Text('Customer Webhook'),
                                      subtitle: Text('5 minutes ago · 30s'),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.green,
                                      ),
                                      title: Text('Data Enrichment'),
                                      subtitle: Text('12 minutes ago · 2m 15s'),
                                    ),
                                    Divider(),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 6,
                                        backgroundColor: Colors.red,
                                      ),
                                      title: Text('Inventory Sync'),
                                      subtitle: Text('32 minutes ago · 45s'),
                                    ),
                                  ],
                                ),
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

  // ------------------------- WIDGET HELPERS -------------------------

  // creates a nav item in the left sidebar
  Widget _navItem(IconData icon, String title, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: selected ? MyApp.primaryPurple : Colors.black54),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: selected ? MyApp.primaryPurple : Colors.black54,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // glassmorphism card container (BackdropFilter blur + translucent white)
  Widget _glassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  // run row UI (single static row for the runs table)
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

  // a small row containing filter and view all buttons with glassmorphism look
  Widget _glassButtonRow() {
    return Row(
      children: [
        // Filter button
        ElevatedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.filter_list),
          label: const Text('Filter'),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyApp.primaryPurple.withOpacity(0.1),
            foregroundColor: MyApp.primaryPurple,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // View All button - primary
        ElevatedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.remove_red_eye_outlined),
          label: const Text('View All'),
          style: ElevatedButton.styleFrom(
            backgroundColor: MyApp.primaryPurple,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildStatCard({
  required Color color,
  required IconData icon,
  required String title,
  required String value,
  required String subtitle,
}) {
  return Container(
    width: 260,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.3)),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      // Glassmorphism style
      backgroundBlendMode: BlendMode.overlay,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: color.withOpacity(0.8)),
        ),
      ],
    ),
  );
}

Widget _activityItem({
  required IconData icon,
  required Color color,
  required String text,
  required String time,
}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(fontSize: 15)),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
      const Divider(height: 20),
    ],
  );
}
