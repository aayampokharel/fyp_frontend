// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

class AdminAccountRequestModel {
  String email;
  String password;
  AdminAccountRequestModel({required this.email, required this.password});

  Map<String, String> toJSON() => {"password": password, "admin_email": email};
}

class AdminDashboardCountsResponseModel {
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
  final List<InstitutionEntity> pendingInstitutionEntities;

  AdminDashboardCountsResponseModel({
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
    required this.pendingInstitutionEntities,
  });

  factory AdminDashboardCountsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AdminDashboardCountsResponseModel(
      activeInstitutions: json['active_institutions'] ?? 0,
      deletedInstitutions: json['deleted_institutions'] ?? 0,
      signedUpInstitutions: json['signed_up_institutions'] ?? 0,
      totalFaculties: json['total_faculties'] ?? 0,
      activeUsers: json['active_users'] ?? 0,
      deletedUsers: json['deleted_users'] ?? 0,
      activeAdmins: json['active_admins'] ?? 0,
      activeInstitutes: json['active_institutes'] ?? 0,
      totalPDFCategories: json['total_pdf_categories'] ?? 0,
      totalPDFFiles: json['total_pdf_files'] ?? 0,
      totalCertificates: json['total_certificates'] ?? 0,
      totalBlocks: json['total_blocks'] ?? 0,
      pendingInstitutionEntities: json['pending_institutions'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active_institutions': activeInstitutions,
      'deleted_institutions': deletedInstitutions,
      'signed_up_institutions': signedUpInstitutions,
      'total_faculties': totalFaculties,
      'active_users': activeUsers,
      'deleted_users': deletedUsers,
      'active_admins': activeAdmins,
      'active_institutes': activeInstitutes,
      'total_pdf_categories': totalPDFCategories,
      'total_pdf_files': totalPDFFiles,
      'total_certificates': totalCertificates,
      'total_blocks': totalBlocks,
    };
  }

  /// Converts this response model to entity suitable for dashboard
  AdminDashboardCountsEntity toEntity() {
    return AdminDashboardCountsEntity(
      activeInstitutions: activeInstitutions,
      deletedInstitutions: deletedInstitutions,
      signedUpInstitutions: signedUpInstitutions,
      totalFaculties: totalFaculties,
      activeUsers: activeUsers,
      deletedUsers: deletedUsers,
      activeAdmins: activeAdmins,
      activeInstitutes: activeInstitutes,
      totalPDFCategories: totalPDFCategories,
      totalPDFFiles: totalPDFFiles,
      totalCertificates: totalCertificates,
      totalBlocks: totalBlocks,
      pendingInstitutions: pendingInstitutionEntities,
    );
  }

  @override
  String toString() => toJson().toString();
}
