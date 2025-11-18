import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/core/constants/dependency_injection/di.dart';
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/features/admin/presentation/view_model/bloc.dart';
import 'package:flutter_dashboard/features/admin/presentation/view_model/event.dart';
import 'package:flutter_dashboard/features/admin/presentation/view_model/state.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/sse/domain/usecase/sse_use_case.dart';
import 'package:intl/intl.dart';

class AdminPage extends StatefulWidget {
  final AdminDashboardCountsEntity dashboardCounts;
  const AdminPage({super.key, required this.dashboardCounts});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final ValueNotifier<List<InstitutionEntity>> institutionsNotifier =
      ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    final sseUseCase = getIt<SseUseCase>();

    sseUseCase.call().listen((event) {
      AppLogger.debug(event.toString());

      if (event['event'] == SSEType.sseSingleForm.value) {
        final newInstitution = InstitutionEntity.fromMap(event['data']);
        institutionsNotifier.value = [
          ...institutionsNotifier.value,
          newInstitution,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final counts = widget.dashboardCounts;

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
      home: ValueListenableBuilder<List<InstitutionEntity>>(
        valueListenable: institutionsNotifier,
        builder: (context, institutions, child) {
          return ProfessionalAdminDashboard(
            institutions: institutions,
            counts: counts,
          );
        },
      ),
    );
  }
}

class ProfessionalAdminDashboard extends StatefulWidget {
  final List<InstitutionEntity> institutions;
  final AdminDashboardCountsEntity counts;

  const ProfessionalAdminDashboard({
    super.key,
    required this.institutions,
    required this.counts,
  });

  @override
  State<ProfessionalAdminDashboard> createState() =>
      _ProfessionalAdminDashboardState();
}

class _ProfessionalAdminDashboardState
    extends State<ProfessionalAdminDashboard> {
  late List<InstitutionEntity> _pendingInstitutions;

  @override
  void initState() {
    super.initState();

    _pendingInstitutions = [];
    if (widget.counts.pendingInstitutions.isNotEmpty) {
      _pendingInstitutions.addAll(widget.counts.pendingInstitutions);
    }

    // Add institutions from backend
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

  void _removeInstitution(InstitutionEntity institution) {
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
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.logout_rounded),
          //   tooltip: 'Logout',
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 24),
            _buildStatisticsGrid(widget.counts),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [const SizedBox(height: 24), _buildQuickStats()],
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
                    DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
  Widget _buildStatisticsGrid(AdminDashboardCountsEntity dashboardCount) {
    final stats = [
      {
        "title": "Total Institutions",
        "count":
            dashboardCount.activeInstitutions +
            dashboardCount.deletedInstitutions,
        "icon": Icons.school_outlined,
        "color": ColorConstants.primaryBlue,
      },
      {
        "title": "Total Faculties",
        "count": dashboardCount.totalFaculties,
        "icon": Icons.groups_rounded,
        "color": const Color(0xFFFF8C4C),
      },
      {
        "title": "Active Accounts",
        "count": dashboardCount.activeUsers,
        "icon": Icons.person_rounded,
        "color": ColorConstants.successGreen,
        // "trend": "+5%",
      },
      {
        "title": "Deleted Accounts",
        "count": dashboardCount.deletedUsers,
        "icon": Icons.person_off_rounded,
        "color": ColorConstants.errorRed,
        // "trend": "-2%",
      },
      {
        "title": "Total Signed Up Institutions",
        "count": dashboardCount.signedUpInstitutions,
        "icon": Icons.bookmark_added,
        "color": ColorConstants.accentPurple,
        // "trend": "+15%",
      },
      {
        "title": "Certificates ",
        "count": dashboardCount.totalCertificates,
        "icon": Icons.verified_rounded,
        "color": const Color(0xFF00B4D8),
        // "trend": "+27%",
      },
      {
        "title": "Deleted Institutions",
        "count": dashboardCount.deletedInstitutions,
        "icon": Icons.group_off,
        "color": Colors.red,
        // "trend": "+27%",
      },
      {
        "title": "Signed Up Institutions",
        "count": dashboardCount.signedUpInstitutions,
        "icon": Icons.group_sharp,
        "color": const Color(0xFF00B4D8),
        // "trend": "+27%",
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

  // ================= Quick Stats =================
  Widget _buildQuickStats() {
    final quickStats = [
      {
        "title": "Pending Requests",
        "value": _pendingInstitutions.length,
        "icon": Icons.pending_actions_rounded,
        "color": Colors.orange,
      },

      {
        "title": "Total Certificates",
        "value": widget.counts.totalCertificates,
        "icon": Icons.verified_user_rounded,
        "color": ColorConstants.primaryBlue,
      },
      {
        "title": "Active Faculties",
        "value": widget.counts.totalFaculties,
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

  // ================= Notifications Section =================
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
                context: context,
              ),
            ),
        ],
      ),
    );
  }
}

// ================= Notification Item =================
class BuildNotificationItem extends StatelessWidget {
  final InstitutionEntity institution;
  final ValueChanged<InstitutionEntity> onRemove;
  final BuildContext context;

  BuildNotificationItem({
    super.key,
    required this.institution,
    required this.onRemove,
    required this.context,
  });

  void _handleAccept() {
    AppLogger.info("Accepted: ${institution.institutionName}");

    // Dispatch BLoC event for activating institution
    context.read<AdminBloc>().add(
      AdminIsActiveButtonPressedEvent(
        institutionID: institution.institutionID,
        isActive: true,
      ),
    );

    onRemove(institution);
  }

  void _handleReject() {
    // Dispatch BLoC event for deactivating/rejecting institution
    context.read<AdminBloc>().add(
      AdminIsActiveButtonPressedEvent(
        institutionID: institution.institutionID,
        isActive: false,
      ),
    );

    onRemove(institution);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        // Handle different states if needed
        if (state is AdminIsInstitutionButtonPressedFailureState) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
        if (state is AdminIsInstitutionButtonPressedSuccessState) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      child: Container(
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
                institution.institutionName ?? "Unknown",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
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
      ),
    );
  }
}
