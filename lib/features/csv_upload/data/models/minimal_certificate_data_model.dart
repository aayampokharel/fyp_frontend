class MinimalCertificateDataModel {
  // Student Information (Required)
  final String studentId;
  final String studentName;

  // Institution & Faculty Information
  final String institutionId;
  final String institutionFacultyId;

  // Certificate Type
  final String
  certificateType; // COURSE_COMPLETION, CHARACTER, LEAVING, TRANSFER, PROVISIONAL

  // Academic Information (Optional)
  final String? degree;
  final String? college;
  final String? major;
  final String? gpa;
  final double? percentage;
  final String? division;
  final String? universityName;

  // Date Information
  final DateTime? issueDate;
  final DateTime? enrollmentDate;
  final DateTime? completionDate;
  final DateTime? leavingDate;

  // Reason Fields
  final String? reasonForLeaving;
  final String? characterRemarks;
  final String? generalRemarks;

  MinimalCertificateDataModel({
    required this.studentId,
    required this.studentName,
    required this.institutionId,
    required this.institutionFacultyId,
    required this.certificateType,
    this.degree,
    this.college,
    this.major,
    this.gpa,
    this.percentage,
    this.division,
    this.universityName,
    required this.issueDate,
    required this.enrollmentDate,
    required this.completionDate,
    required this.leavingDate,
    this.reasonForLeaving,
    this.characterRemarks,
    this.generalRemarks,
  });

  // Factory constructor from JSON
  factory MinimalCertificateDataModel.fromJson(Map<String, dynamic> json) {
    return MinimalCertificateDataModel(
      studentId: json['student_id'] as String,
      studentName: json['student_name'] as String,
      institutionId: json['institution_id'] as String,
      institutionFacultyId: json['institution_faculty_id'] as String,
      certificateType: json['certificate_type'] as String,
      degree: json['degree'] as String?,
      college: json['college'] as String?,
      major: json['major'] as String?,
      gpa: json['gpa'] as String?,
      percentage: json['percentage'] != null
          ? (json['percentage'] as num).toDouble()
          : null,
      division: json['division'] as String?,
      universityName: json['university_name'] as String?,
      issueDate: DateTime.parse(json['issue_date'] as String),
      enrollmentDate: DateTime.parse(json['enrollment_date'] as String),
      completionDate: DateTime.parse(json['completion_date'] as String),
      leavingDate: DateTime.parse(json['leaving_date'] as String),
      reasonForLeaving: json['reason_for_leaving'] as String?,
      characterRemarks: json['character_remarks'] as String?,
      generalRemarks: json['general_remarks'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'institution_id': institutionId,
      'institution_faculty_id': institutionFacultyId,
      'certificate_type': certificateType,
      'degree': degree,
      'college': college,
      'major': major,
      'gpa': gpa,
      'percentage': percentage,
      'division': division,
      'university_name': universityName,
      'issue_date': issueDate ?? issueDate!.toIso8601String(),
      'enrollment_date': enrollmentDate ?? enrollmentDate!.toIso8601String(),
      'completion_date': completionDate ?? completionDate!.toIso8601String(),
      'leaving_date': leavingDate ?? leavingDate!.toIso8601String(),
      'reason_for_leaving': reasonForLeaving,
      'character_remarks': characterRemarks,
      'general_remarks': generalRemarks,
    };
  }

  @override
  String toString() {
    return 'MinimalCertificateData(studentId: $studentId, studentName: $studentName, certificateType: $certificateType)';
  }
}
