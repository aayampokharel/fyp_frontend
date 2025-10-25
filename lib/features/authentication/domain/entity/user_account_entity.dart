// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/core/constants/enum.dart';

class UserAccountEntity {
  final String id;
  final SystemRole systemRole;
  final String institutionRole;
  final DateTime createdAt;
  final String email;

  UserAccountEntity({
    required this.id,
    required this.systemRole,
    required this.institutionRole,
    required this.createdAt,
    required this.email,
  });

  Map<String, dynamic> toJSON() => {
    'id': id,
    'system_role': systemRoletoString(systemRole),
    'institution_role': institutionRole,
    'created_at': createdAt.toIso8601String(),
    'email': email,
  };

  @override
  String toString() => toJSON().toString();
}

class UserAccountEntityParams {
  String institutionRole;
  SystemRole systemRole;
  String email;
  String password;
  String institutionID;
  String institutionLogoBase64;

  UserAccountEntityParams({
    required this.institutionRole,
    required this.systemRole,
    required this.email,
    required this.password,
    required this.institutionID,
    required this.institutionLogoBase64,
  });
}

// type UserAccount struct {
// 	ID              string     `json:"id"`
// 	SystemRole      enum.ROLE  `json:"system_role"`
// 	InstitutionRole string     `json:"institution_role"`
// 	CreatedAt       time.Time  `json:"created_at"`
// 	DeletedAt       *time.Time `json:"deleted_at"`
// 	Email           string     `json:"email"`
// 	Password        string     `json:"password"`
// }
