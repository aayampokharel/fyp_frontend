// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter_dashboard/core/constants/color_constants.dart';
// import 'package:flutter_dashboard/core/constants/dependency_injection/di.dart';
// import 'package:flutter_dashboard/core/constants/enum.dart';
// import 'package:flutter_dashboard/core/errors/app_logger.dart';
// import 'package:flutter_dashboard/features/sse/domain/usecase/sse_use_case.dart';
// import 'package:flutter_dashboard/features/sse/presentation/view/widgets/notification.dart';

// class AdminPage extends StatefulWidget {
//   const AdminPage({super.key});

//   @override
//   State<AdminPage> createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AdminPage> {
//   final List<Map<String, dynamic>> _institutions = [];

//   @override
//   void initState() {
//     super.initState();
//     final sseUseCase = getIt<SseUseCase>();

//     sseUseCase.call().listen((event) {
//       if (event['event'] == SSEType.sseSingleForm.value) {
//         setState(() {
//           _institutions.add(event['data']);
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Admin Dashboard',
//       theme: ThemeData(
//         primaryColor: ColorConstants.primaryBlue,
//         scaffoldBackgroundColor: ColorConstants.backgroundLight,
//         fontFamily: 'Inter',
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(color: Color(0xFF2D3748)),
//         ),
//         useMaterial3: true,
//       ),
//       home: ProfessionalAdminDashboard(institutions: _institutions),
//     );
//   }
// }

// class ProfessionalAdminDashboard extends StatefulWidget {
//   List<Map<String, dynamic>> institutions = [];
//   ProfessionalAdminDashboard({super.key, required this.institutions});

//   @override
//   State<ProfessionalAdminDashboard> createState() =>
//       _ProfessionalAdminDashboardState();
// }

// class _ProfessionalAdminDashboardState
//     extends State<ProfessionalAdminDashboard> {
//   List<Map<String, dynamic>> institutions = [];

//   // Call this whenever SSE sends new data
//   void updateInstitutions(List<Map<String, dynamic>> newInstitutions) {
//     setState(() {
//       institutions = newInstitutions
//           .map(
//             (e) => {
//               ...e,
//               "status": "Pending", // Add a default status
//             },
//           )
//           .toList();
//     });
//     AppLogger.info(institutions);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.backgroundLight,
//       appBar: AppBar(
//         title: const Text(
//           "Admin Dashboard",
//           style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
//         ),
//         backgroundColor: ColorConstants.primaryBlue,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Logout functionality
//             },
//             icon: const Icon(Icons.logout_rounded),
//             tooltip: 'Logout',
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildWelcomeCard(),
//             const SizedBox(height: 24),
//             _buildStatisticsGrid(),
//             const SizedBox(height: 24),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     children: [
//                       _buildCertificateChart(),
//                       const SizedBox(height: 24),
//                       _buildQuickStats(),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Expanded(
//                   flex: 1,
//                   child: _buildNotificationsSection(widget.institutions),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= Welcome Card =================
//   Widget _buildWelcomeCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(28),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             ColorConstants.primaryBlue,
//             ColorConstants.primaryBlue.withOpacity(0.9),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: ColorConstants.primaryBlue.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 70,
//             height: 70,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.3),
//                 width: 2,
//               ),
//             ),
//             child: const Icon(
//               Icons.admin_panel_settings_rounded,
//               color: Colors.white,
//               size: 32,
//             ),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Welcome back, Administrator!",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Here's what's happening with your platform today",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 15,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     "12-11-2025",
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= Statistics Grid =================
//   Widget _buildStatisticsGrid() {
//     final stats = [
//       {
//         "title": "Total Institutions",
//         "count": 45,
//         "icon": Icons.school_rounded,
//         "color": ColorConstants.primaryBlue,
//         "trend": "+12%",
//       },
//       {
//         "title": "Total Faculties",
//         "count": 120,
//         "icon": Icons.groups_rounded,
//         "color": Color(0xFFFF8C4C),
//         "trend": "+8%",
//       },
//       {
//         "title": "Active Accounts",
//         "count": 156,
//         "icon": Icons.person_rounded,
//         "color": ColorConstants.successGreen,
//         "trend": "+5%",
//       },
//       {
//         "title": "Deleted Accounts",
//         "count": 12,
//         "icon": Icons.person_off_rounded,
//         "color": ColorConstants.errorRed,
//         "trend": "-2%",
//       },
//       {
//         "title": "Total Categories",
//         "count": 89,
//         "icon": Icons.category_rounded,
//         "color": ColorConstants.accentPurple,
//         "trend": "+15%",
//       },
//       {
//         "title": "Certificates This Year",
//         "count": 1245,
//         "icon": Icons.verified_rounded,
//         "color": Color(0xFF00B4D8),
//         "trend": "+27%",
//       },
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: null,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 2.5,
//       ),
//       itemCount: stats.length,
//       itemBuilder: (context, index) {
//         final stat = stats[index];
//         return _buildStatCard(stat);
//       },
//     );
//   }

//   Widget _buildStatCard(Map<String, dynamic> stat) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 44,
//                   height: 44,
//                   decoration: BoxDecoration(
//                     color: (stat["color"] as Color).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     stat["icon"] as IconData,
//                     color: stat["color"] as Color,
//                     size: 22,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: ColorConstants.successGreen.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     stat["trend"] as String,
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: ColorConstants.successGreen,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "${stat["count"]}",
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF2D3748),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               stat["title"] as String,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: ColorConstants.mediumGray,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= Certificate Chart =================
//   Widget _buildCertificateChart() {
//     final monthlyData = [
//       {"month": "Aug", "certificates": 18},
//       {"month": "Sept", "certificates": 8},
//       {"month": "Oct", "certificates": 28},
//       {"month": "Nov", "certificates": 50},
//     ];

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Certificate Issuance Trend",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF2D3748),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Monthly certificate issuance overview",
//             style: TextStyle(fontSize: 14, color: ColorConstants.mediumGray),
//           ),
//           const SizedBox(height: 24),
//           SizedBox(
//             height: 200,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 barTouchData: BarTouchData(enabled: true),
//                 titlesData: FlTitlesData(
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index >= 0 && index < monthlyData.length) {
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               monthlyData[index]["month"] as String,
//                               style: TextStyle(
//                                 fontSize: 11,
//                                 color: ColorConstants.mediumGray,
//                               ),
//                             ),
//                           );
//                         }
//                         return const Text('');
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 40,
//                       getTitlesWidget: (value, meta) {
//                         return Text(
//                           value.toInt().toString(),
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: ColorConstants.mediumGray,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   rightTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   topTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   drawVerticalLine: false,
//                   getDrawingHorizontalLine: (value) =>
//                       FlLine(color: ColorConstants.lightGray, strokeWidth: 0.5),
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barGroups: monthlyData.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final data = entry.value;
//                   return BarChartGroupData(
//                     x: index,
//                     barRods: [
//                       BarChartRodData(
//                         toY: (data["certificates"] as int).toDouble(),
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF4C7FFF), Color(0xFF8B4DFF)],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.topCenter,
//                         ),
//                         width: 16,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= Quick Stats =================
//   Widget _buildQuickStats() {
//     final quickStats = [
//       {
//         "title": "Pending Requests",
//         "value": 3,
//         "icon": Icons.pending_actions_rounded,
//         "color": Colors.orange,
//       },
//       {
//         "title": "New Users Today",
//         "value": 5,
//         "icon": Icons.person_add_alt_rounded,
//         "color": ColorConstants.successGreen,
//       },
//       {
//         "title": "Certificates Today",
//         "value": 7,
//         "icon": Icons.verified_user_rounded,
//         "color": ColorConstants.primaryBlue,
//       },
//       {
//         "title": "Active Categories",
//         "value": 4,
//         "icon": Icons.category_rounded,
//         "color": ColorConstants.accentPurple,
//       },
//     ];

//     return GridView.builder(
//       shrinkWrap: true,
//       physics: null,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 1.8,
//       ),
//       itemCount: quickStats.length,
//       itemBuilder: (context, index) {
//         final stat = quickStats[index];
//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.03),
//                 blurRadius: 8,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                   color: (stat["color"] as Color).withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   stat["icon"] as IconData,
//                   color: stat["color"] as Color,
//                   size: 18,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${stat["value"]}",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                   Text(
//                     stat["title"] as String,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: ColorConstants.mediumGray,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // ================= Notifications Section =================
//   Widget _buildNotificationsSection(List<Map<String, dynamic>> _institutions) {
//     // Use the state variable that actually updates
//     _institutions.add({
//       "institution_id": "47621e31-42c8-48",
//       "institution_name": "adf",
//       "tole_address": "afds",
//       "ward_number": "1",
//       "district_address": "ads",
//       "is_active": null,
//     });
//     final pendingInstitutions = _institutions
//         .where((n) => n["is_active"] == null)
//         .toList();

//     final pendingCount = 1;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(
//                 Icons.notifications_active_rounded,
//                 color: Colors.orange,
//                 size: 22,
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 "Institution Requests",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF2D3748),
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.orange.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   "$pendingCount Pending",
//                   style: const TextStyle(
//                     color: Colors.orange,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           if (pendingCount == 0)
//             Center(
//               child: Text(
//                 "No pending requests 🎉",
//                 style: TextStyle(color: Colors.grey[600], fontSize: 13),
//               ),
//             )
//           else
//             ...pendingInstitutions
//                 .map(
//                   (institution) => BuildNotificationItem(
//                     notification: institution,
//                     notificationsList: _institutions,
//                   ),
//                 )
//                 .toList(),
//         ],
//       ),
//     );
//   }

//   // ================= Notification Item =================
// }

// class BuildNotificationItem extends StatefulWidget {
//   Map<String, dynamic> notification;
//   List<Map<String, dynamic>> notificationsList;
//   BuildNotificationItem({
//     super.key,
//     required this.notification,
//     required this.notificationsList,
//   });

//   @override
//   State<BuildNotificationItem> createState() => _BuildNotificationItemState();
// }

// class _BuildNotificationItemState extends State<BuildNotificationItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           // Icon on left
//           Container(
//             width: 36,
//             height: 36,
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.school_rounded, color: Colors.blue, size: 18),
//           ),
//           const SizedBox(width: 12),

//           // Institution name
//           Expanded(
//             child: Text(
//               widget.notification["institution_name"] ?? "Unknown",
//               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//             ),
//           ),

//           // Accept and Reject buttons
//           Row(
//             children: [
//               // Tick button
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     AppLogger.info(
//                       "notification" + widget.notification.toString(),
//                     );
//                     widget.notificationsList.remove(widget.notification);
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: Colors.green.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.check_rounded,
//                     color: Colors.green,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8),

//               // Reject button
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     widget.notificationsList.remove(widget.notification);
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: Colors.red.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.close_rounded,
//                     color: Colors.red,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/core/constants/dependency_injection/di.dart';
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/features/sse/domain/usecase/sse_use_case.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ValueNotifier<List<Map<String, dynamic>>> institutionsNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    final sseUseCase = getIt<SseUseCase>();

    sseUseCase.call().listen((event) {
      AppLogger.debug(event.toString());
      if (event['event'] == SSEType.sseSingleForm.value) {
        final newData = Map<String, dynamic>.from(event['data']);
        newData['status'] = 'Pending';

        institutionsNotifier.value = [...institutionsNotifier.value, newData];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      theme: ThemeData(
        primaryColor: ColorConstants.primaryBlue,
        scaffoldBackgroundColor: ColorConstants.backgroundLight,
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF2D3748)),
        ),
        useMaterial3: true,
      ),
      home: ValueListenableBuilder(
        valueListenable: institutionsNotifier,
        builder: (context, value, child) {
          return ProfessionalAdminDashboard(institutions: value);
        },
      ),
    );
  }
}

class ProfessionalAdminDashboard extends StatefulWidget {
  final List<Map<String, dynamic>> institutions;
  const ProfessionalAdminDashboard({super.key, required this.institutions});

  @override
  State<ProfessionalAdminDashboard> createState() =>
      _ProfessionalAdminDashboardState();
}

class _ProfessionalAdminDashboardState
    extends State<ProfessionalAdminDashboard> {
  // Local list for notifications (using static data as requested)
  late List<Map<String, dynamic>> _pendingInstitutions;

  @override
  void initState() {
    super.initState();

    _pendingInstitutions = [
      {
        "institution_id": "47621e31-42c8-48",
        "institution_name": "ABCD College",
        "tole_address": "Sinamangal",
        "ward_number": "1",
        "district_address": "Kathmandu",
        "is_active": null,
      },
    ];

    // Add initial passed institutions
    _pendingInstitutions.addAll(widget.institutions);
  }

  @override
  void didUpdateWidget(covariant ProfessionalAdminDashboard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.institutions != widget.institutions) {
      setState(() {
        _pendingInstitutions = [
          ..._pendingInstitutions,
          ...widget.institutions,
        ];
      });
    }
  }

  void _removeInstitution(Map<String, dynamic> institution) {
    setState(() {
      _pendingInstitutions.remove(institution);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundLight,
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: ColorConstants.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 24),
            _buildStatisticsGrid(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildCertificateChart(),
                      const SizedBox(height: 24),
                      _buildQuickStats(),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(flex: 1, child: _buildNotificationsSection()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= Welcome Card =================
  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.primaryBlue,
            ColorConstants.primaryBlue.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back, Administrator!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Here's what's happening with your platform today",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "12-11-2025",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= Statistics Grid =================
  Widget _buildStatisticsGrid() {
    final stats = [
      {
        "title": "Total Institutions",
        "count": 45,
        "icon": Icons.school_rounded,
        "color": ColorConstants.primaryBlue,
        "trend": "+12%",
      },
      {
        "title": "Total Faculties",
        "count": 120,
        "icon": Icons.groups_rounded,
        "color": const Color(0xFFFF8C4C),
        "trend": "+8%",
      },
      {
        "title": "Active Accounts",
        "count": 156,
        "icon": Icons.person_rounded,
        "color": ColorConstants.successGreen,
        "trend": "+5%",
      },
      {
        "title": "Deleted Accounts",
        "count": 12,
        "icon": Icons.person_off_rounded,
        "color": ColorConstants.errorRed,
        "trend": "-2%",
      },
      {
        "title": "Total Categories",
        "count": 89,
        "icon": Icons.category_rounded,
        "color": ColorConstants.accentPurple,
        "trend": "+15%",
      },
      {
        "title": "Certificates This Year",
        "count": 1245,
        "icon": Icons.verified_rounded,
        "color": const Color(0xFF00B4D8),
        "trend": "+27%",
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) => _buildStatCard(stats[index]),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: (stat["color"] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    stat["icon"] as IconData,
                    color: stat["color"] as Color,
                    size: 22,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.successGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    stat["trend"] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.successGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "${stat["count"]}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat["title"] as String,
              style: TextStyle(
                fontSize: 13,
                color: ColorConstants.mediumGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Certificate Chart =================
  Widget _buildCertificateChart() {
    final monthlyData = [
      {"month": "Aug", "certificates": 18},
      {"month": "Sept", "certificates": 8},
      {"month": "Oct", "certificates": 28},
      {"month": "Nov", "certificates": 50},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Certificate Issuance Trend",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Monthly certificate issuance overview",
            style: TextStyle(fontSize: 14, color: ColorConstants.mediumGray),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < monthlyData.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              monthlyData[index]["month"] as String,
                              style: TextStyle(
                                fontSize: 11,
                                color: ColorConstants.mediumGray,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: ColorConstants.mediumGray,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: ColorConstants.lightGray, strokeWidth: 0.5),
                ),
                borderData: FlBorderData(show: false),
                barGroups: monthlyData.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: (data["certificates"] as int).toDouble(),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4C7FFF), Color(0xFF8B4DFF)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= Quick Stats =================
  Widget _buildQuickStats() {
    final quickStats = [
      {
        "title": "Pending Requests",
        "value": 3,
        "icon": Icons.pending_actions_rounded,
        "color": Colors.orange,
      },
      {
        "title": "New Users Today",
        "value": 5,
        "icon": Icons.person_add_alt_rounded,
        "color": ColorConstants.successGreen,
      },
      {
        "title": "Certificates Today",
        "value": 7,
        "icon": Icons.verified_user_rounded,
        "color": ColorConstants.primaryBlue,
      },
      {
        "title": "Active Categories",
        "value": 4,
        "icon": Icons.category_rounded,
        "color": ColorConstants.accentPurple,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.8,
      ),
      itemCount: quickStats.length,
      itemBuilder: (context, index) {
        final stat = quickStats[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  stat["icon"] as IconData,
                  color: stat["color"] as Color,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${stat["value"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  Text(
                    stat["title"] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: ColorConstants.mediumGray,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= Notifications Section (Using Static Data) =================
  Widget _buildNotificationsSection() {
    final pendingCount = _pendingInstitutions.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications_active_rounded,
                color: Colors.orange,
                size: 22,
              ),
              const SizedBox(width: 8),
              const Text(
                "Institution Requests",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3748),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$pendingCount Pending",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (pendingCount == 0)
            const Center(
              child: Text(
                "No pending requests",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            )
          else
            ..._pendingInstitutions.map(
              (inst) => BuildNotificationItem(
                institution: inst,
                onRemove: _removeInstitution,
              ),
            ),
        ],
      ),
    );
  }
}

// ================= Notification Item =================
class BuildNotificationItem extends StatelessWidget {
  final Map<String, dynamic> institution;
  final ValueChanged<Map<String, dynamic>> onRemove;

  const BuildNotificationItem({
    super.key,
    required this.institution,
    required this.onRemove,
  });

  void _handleAccept() {
    AppLogger.info("Accepted: ${institution['institution_name']}");
    onRemove(institution);
  }

  void _handleReject() {
    onRemove(institution);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.school_rounded,
              color: Colors.blue,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              institution["institution_name"] ?? "Unknown",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: _handleAccept,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _handleReject,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
