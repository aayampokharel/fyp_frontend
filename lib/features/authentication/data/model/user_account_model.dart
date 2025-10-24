import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';

class UserAccountRequestModel {
  String institutionID;
  String password;
  String institutionRole;
  String systemRole;
  String institutionLogoBase64;
  String userEmail;

  UserAccountRequestModel({
    required this.institutionID,
    required this.password,
    required this.institutionRole,
    required this.systemRole,
    required this.institutionLogoBase64,
    required this.userEmail,
  });

  Map<String, String> toJSON() => {
    "institution_id": institutionID,
    "password": password,
    "institution_role": institutionRole,
    "system_role": systemRole,
    "institution_logo_base64": institutionLogoBase64,
    "user_email": userEmail,
  };
}

class UserAccountResponseModel {
  String userID;
  DateTime createdAt;

  UserAccountResponseModel({required this.userID, required this.createdAt});

  factory UserAccountResponseModel.fromJSON(Map<String, dynamic> map) =>
      UserAccountResponseModel(
        userID: map['id'] ?? "",
        createdAt: DateTime.parse(map['created_at']),
      );

  UserAccountEntity toEntity(
    SystemRole systemRole,
    String institutionRole,
    String email,
  ) {
    return UserAccountEntity(
      createdAt: createdAt,
      id: userID,
      systemRole: systemRole,
      institutionRole: institutionRole,
      email: email,
    );
  }
}
