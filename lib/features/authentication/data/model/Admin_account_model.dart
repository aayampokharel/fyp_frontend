// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/core/constants/enum.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';

class AdminAccountRequestModel {
  String email;
  String password;
  AdminAccountRequestModel({required this.email, required this.password});

  Map<String, String> toJSON() => {"password": password, "admin_email": email};
}

class AdminAccountResponseModel {
  String userID;
  DateTime createdAt;

  AdminAccountResponseModel({required this.userID, required this.createdAt});

  factory AdminAccountResponseModel.fromJSON(Map<String, dynamic> map) =>
      AdminAccountResponseModel(
        userID: map['user_id'] ?? "",
        createdAt: DateTime.parse(map['created_at']),
      );

  AdminAccountEntity toEntity(String email) {
    return AdminAccountEntity(createdAt: createdAt, email: email);
  }

  Map<String, dynamic> toJSON() => {
    'id': userID,
    'created_at': createdAt.toIso8601String(),
  };

  @override
  String toString() {
    return toJSON().toString();
  }
}
