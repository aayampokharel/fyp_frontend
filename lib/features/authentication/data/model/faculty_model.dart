// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';

class FacultyRequestModel {
  String faculty;
  String institutionID;
  String principalName;
  String principalSignatureBase64;
  String facultyHodName;
  String universityAffiliation;
  String universityCollegeCode;
  String facultyHodSignatureBase64;
  FacultyRequestModel({
    required this.faculty,
    required this.institutionID,
    required this.principalName,
    required this.principalSignatureBase64,
    required this.facultyHodName,
    required this.universityAffiliation,
    required this.universityCollegeCode,
    required this.facultyHodSignatureBase64,
  });

  FacultyEntity toEntity() {
    return FacultyEntity(
      faculty: faculty,
      institutionFacultyID: "",
      principalName: principalName,
      principalSignatureBase64: principalSignatureBase64,
      facultyHodName: facultyHodName,
      universityAffiliation: universityAffiliation,
      universityCollegeCode: universityCollegeCode,
      facultyHodSignatureBase64: facultyHodSignatureBase64,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "faculty": faculty,
      "institution_id": institutionID,
      "principal_name": principalName,
      "principal_signature_base64": principalSignatureBase64,
      "faculty_hod_name": facultyHodName,
      "university_affiliation": universityAffiliation,
      "university_college_code": universityCollegeCode,
      "faculty_hod_signature_base64": facultyHodSignatureBase64,
    };
  }

  factory FacultyRequestModel.fromEntity(
    FacultyEntity facultyEntity,
    String institutionID,
  ) {
    return FacultyRequestModel(
      faculty: facultyEntity.faculty,
      institutionID: institutionID,
      principalName: facultyEntity.principalName,
      principalSignatureBase64: facultyEntity.principalSignatureBase64,
      facultyHodName: facultyEntity.facultyHodName,
      universityAffiliation: facultyEntity.universityAffiliation,
      universityCollegeCode: facultyEntity.universityCollegeCode,
      facultyHodSignatureBase64: facultyEntity.facultyHodSignatureBase64,
    );
  }

  @override
  String toString() {
    return toJSON().toString();
  }
}
