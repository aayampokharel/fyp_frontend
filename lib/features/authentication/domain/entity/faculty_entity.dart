class FacultyEntity {
  String institutionFacultyID;
  String institutionID;
  String facultyName;
  String facultyPublicKey;
  List<Map<String, String>> facultyAuthorityWithSignatures;
  String universityAffiliation;
  String universityCollegeCode;

  FacultyEntity({
    required this.institutionFacultyID,
    required this.institutionID,
    required this.facultyName,
    required this.facultyPublicKey,
    required this.facultyAuthorityWithSignatures,
    required this.universityAffiliation,
    required this.universityCollegeCode,
  });

  factory FacultyEntity.fromJSON(Map<String, dynamic> json) {
    return FacultyEntity(
      institutionFacultyID: json['institution_faculty_id'] ?? "",
      institutionID: json['institution_id'] ?? "",
      facultyName: json['faculty_name'] ?? "",
      facultyPublicKey: json['faculty_public_key'] ?? "",
      facultyAuthorityWithSignatures:
          (json['faculty_authority_with_signatures'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map<String, dynamic>))
              .toList() ??
          [],
      universityAffiliation: json['university_affiliation'] ?? "",
      universityCollegeCode: json['university_college_code'] ?? "",
    );
  }

  Map<String, dynamic> toJSON() => <String, dynamic>{
    'institution_faculty_id': institutionFacultyID,
    'institution_id': institutionID,
    'faculty_name': facultyName,
    'faculty_public_key': facultyPublicKey,
    'faculty_authority_with_signatures': facultyAuthorityWithSignatures
        .map((e) => e)
        .toList(),
    'university_affiliation': universityAffiliation,
    'university_college_code': universityCollegeCode,
  };

  @override
  String toString() => toJSON().toString();
}
