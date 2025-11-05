import 'package:flutter_dashboard/features/authentication/domain/entity/institute_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

class InstituteAccountRequestModel {
  final String email;
  final String password;

  InstituteAccountRequestModel({required this.email, required this.password});

  Map<String, String> toJSON() => {"email": email, "password": password};
}

class InstituteAccountResponseModel {
  final String userID;
  final DateTime createdAt;
  final List<InstitutionEntity> institutionList;

  InstituteAccountResponseModel({
    required this.userID,
    required this.createdAt,
    required this.institutionList,
  });

  factory InstituteAccountResponseModel.fromJSON(Map<String, dynamic> json) {
    return InstituteAccountResponseModel(
      userID: json['user_id'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      institutionList: (json['institution_list'] as List<dynamic>)
          .map((e) => InstitutionEntity.fromJSON(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "user_id": userID,
      "created_at": createdAt.toIso8601String(),
      "institution_list": institutionList.map((e) => e.toJSON()).toList(),
    };
  }

  InstituteAccountEntity toEntity(String email) {
    return InstituteAccountEntity(
      userID: userID,
      email: email,
      createdAt: createdAt,
      institutionList: institutionList,
    );
  }
}
