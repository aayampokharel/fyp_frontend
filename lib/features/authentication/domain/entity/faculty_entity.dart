class FacultyEntity {
  String institutionFacultyID;
  String faculty;
  String principalName;
  String principalSignatureBase64;
  String facultyHodName;
  String universityAffiliation;
  String universityCollegeCode;
  String facultyHodSignatureBase64;

  FacultyEntity({
    required this.institutionFacultyID,
    required this.faculty,
    required this.principalName,
    required this.principalSignatureBase64,
    required this.facultyHodName,
    required this.universityAffiliation,
    required this.universityCollegeCode,
    required this.facultyHodSignatureBase64,
  });

  FacultyEntity fromJSON(Map<String, dynamic> json) {
    return FacultyEntity(
      faculty: faculty,
      institutionFacultyID: json['institution_faculty_id'] ?? "",
      principalName: principalName,
      principalSignatureBase64: principalSignatureBase64,
      facultyHodName: facultyHodName,
      universityAffiliation: universityAffiliation,
      universityCollegeCode: universityCollegeCode,
      facultyHodSignatureBase64: facultyHodSignatureBase64,
    );
  }

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'institution_faculty_id': institutionFacultyID,
    'faculty': faculty,
    'principal_name': principalName,
    'principal_signature_base64': principalSignatureBase64,
    'faculty_hod_name': facultyHodName,
    'university_affiliation': universityAffiliation,
    'university_college_code': universityCollegeCode,
    'faculty_hod_signature_base64': facultyHodSignatureBase64,
  };

  @override
  String toString() => toJSON().toString();
}
