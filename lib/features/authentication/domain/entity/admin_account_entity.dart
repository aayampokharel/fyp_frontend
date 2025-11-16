import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

/// Entity representing an Admin account
class AdminAccountEntity {
  final String email;
  final DateTime createdAt;

  // Additional fields can be added here later
  // For example: userID, role, token, etc.

  AdminAccountEntity({required this.email, required this.createdAt});

  @override
  String toString() {
    return 'AdminAccountEntity(email: $email, createdAt: $createdAt)';
  }
}

/// Entity representing the counts for admin dashboard
class AdminDashboardCountsEntity {
  final int activeInstitutions;
  final int deletedInstitutions;
  final int signedUpInstitutions;
  final int totalFaculties;
  final int activeUsers;
  final int deletedUsers;
  final int activeAdmins;
  final int activeInstitutes;
  final int totalPDFCategories;
  final int totalPDFFiles;
  final int totalCertificates;
  final int totalBlocks;
  final List<InstitutionEntity> pendingInstitutions;

  AdminDashboardCountsEntity({
    required this.activeInstitutions,
    required this.deletedInstitutions,
    required this.signedUpInstitutions,
    required this.totalFaculties,
    required this.activeUsers,
    required this.deletedUsers,
    required this.activeAdmins,
    required this.activeInstitutes,
    required this.totalPDFCategories,
    required this.totalPDFFiles,
    required this.totalCertificates,
    required this.totalBlocks,
    required this.pendingInstitutions,
  });

  @override
  String toString() {
    return '''
AdminDashboardCountsEntity(
  activeInstitutions: $activeInstitutions,
  deletedInstitutions: $deletedInstitutions,
  signedUpInstitutions: $signedUpInstitutions,
  totalFaculties: $totalFaculties,
  activeUsers: $activeUsers,
  deletedUsers: $deletedUsers,
  activeAdmins: $activeAdmins,
  activeInstitutes: $activeInstitutes,
  totalPDFCategories: $totalPDFCategories,
  totalPDFFiles: $totalPDFFiles,
  totalCertificates: $totalCertificates,
  totalBlocks: $totalBlocks
)
''';
  }
}

/// Response model from backend
