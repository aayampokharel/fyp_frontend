import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

class InstituteAccountEntity {
  final String email;
  final String userID;
  final DateTime createdAt;
  final List<InstitutionEntity> institutionList;
  //remaning fields .

  InstituteAccountEntity({
    required this.userID,
    required this.email,
    required this.createdAt,
    required this.institutionList,
  });
  //// admin account entity: login for admin specific should be clickable only once then turn off the feature else map ma token gaera extra bascha and will cause errors for SSE .
  @override
  String toString() {
    return 'InstituteAccountEntity(email: $email, userID: $userID, createdAt: $createdAt, institutionList: $institutionList)';
  }
}
