// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';

class FacultyRequestModel {
  String facultyName;
  String institutionID;
  List<Map<String, String>> facultyAuthorityWithSignatures;
  String universityAffiliation;
  String universityCollegeCode;

  FacultyRequestModel({
    required this.facultyName,
    required this.institutionID,
    required this.universityAffiliation,
    required this.universityCollegeCode,
    required this.facultyAuthorityWithSignatures,
  });

  FacultyEntity toEntity() {
    return FacultyEntity(
      facultyName: facultyName,
      institutionID: institutionID,
      institutionFacultyID: "",
      facultyPublicKey: "",
      facultyAuthorityWithSignatures: facultyAuthorityWithSignatures,
      universityAffiliation: universityAffiliation,
      universityCollegeCode: universityCollegeCode,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "faculty_name": facultyName,
      "institution_id": institutionID,
      "faculty_authority_with_signatures": facultyAuthorityWithSignatures,
      "university_affiliation": universityAffiliation,
      "university_college_code": universityCollegeCode,
    };
  }

  factory FacultyRequestModel.fromEntity(FacultyEntity entity) {
    return FacultyRequestModel(
      facultyName: entity.facultyName,
      institutionID: entity.institutionID,
      facultyAuthorityWithSignatures: entity.facultyAuthorityWithSignatures,
      universityAffiliation: entity.universityAffiliation,
      universityCollegeCode: entity.universityCollegeCode,
    );
  }

  @override
  String toString() {
    return toJSON().toString();
  }
}
