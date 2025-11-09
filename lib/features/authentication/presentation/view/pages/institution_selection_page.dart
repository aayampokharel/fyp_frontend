// import 'package:flutter/material.dart';
// import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

// import 'package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart';

// class InstitutionSelectionPage extends StatelessWidget {
//   final List<InstitutionEntity> institutions;

//   const InstitutionSelectionPage({super.key, required this.institutions});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Institution"),
//         centerTitle: true,
//       ),
//       body: institutions.isEmpty
//           ? const Center(child: Text("No institutions found."))
//           : ListView.builder(
//               itemCount: institutions.length,
//               itemBuilder: (context, index) {
//                 final institution = institutions[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: ListTile(
//                     title: Text(institution.institutionName ?? "No Name"),
//                     subtitle: Text(
//                       "ID: ${institution.institutionID}  active: ${institution.isActive}",
//                     ),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       //! first get all the associated faculties from institution ID , make separate Usecase then if not available .
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => InstitutionCsvUploadPage(
//                             institutionID: institution.institutionID,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/core/constants/string_constants.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/presentation/view/page/institution_upload_page.dart';

class InstitutionSelectionPage extends StatelessWidget {
  final List<InstitutionEntity> institutions;

  const InstitutionSelectionPage({super.key, required this.institutions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundLight,
      appBar: AppBar(
        title: const Text("Select Your Institution"),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: institutions.isEmpty
          ? _buildEmptyState()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    child: Text(
                      'Your Institutions (${institutions.length})',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Institutions Grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 2.9,
                          ),
                      itemCount: institutions.length,
                      itemBuilder: (context, index) {
                        final institution = institutions[index];
                        return _buildInstitutionCard(context, institution);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 80,
            color: ColorConstants.mediumGray,
          ),
          const SizedBox(height: 20),
          Text(
            "No Institutions Found",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorConstants.darkGray,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "You don't have any institutions associated with your account yet.",
            style: TextStyle(fontSize: 14, color: ColorConstants.mediumGray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInstitutionCard(
    BuildContext context,
    InstitutionEntity institution,
  ) {
    final status = institution.getStatus();
    final statusColor = institution.getStatusColor();
    final statusIcon = institution.getStatusIcon();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          if (institution.isActive != false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InstitutionCsvUploadPage(
                  institutionID: institution.institutionID,
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                ColorConstants.primaryBlue.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Institution Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8C4C), Color(0xFFFF4C4C)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.school, color: Colors.white, size: 20),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, color: statusColor, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Text(
                institution.institutionName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              _buildDetailRow(
                Icons.location_on,
                "${institution.districtAddress}, Ward ${institution.wardNumber}",
              ),
              const SizedBox(height: 4),
              _buildDetailRow(Icons.home_work, institution.toleAddress),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "ID: ${institution.institutionID}",
                      style: TextStyle(
                        fontSize: 11,
                        color: ColorConstants.mediumGray,
                        fontFamily: 'Monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: ColorConstants.mediumGray),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: ColorConstants.darkGray),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

extension InstitutionEntityExtensions on InstitutionEntity {
  String getStatus() {
    if (isActive == null) return 'Pending';
    if (isActive == true) return 'Active';
    return 'Rejected';
  }

  Color getStatusColor() {
    if (isActive == null) return Colors.blue;
    if (isActive == true) return Colors.green;
    return Colors.red;
  }

  IconData getStatusIcon() {
    if (isActive == null) return Icons.pending;
    if (isActive == true) return Icons.verified;
    return Icons.block;
  }
}
