class MinimalCertificateDataModel {
  final String studentId;
  final String studentName;
  final String institutionId;
  final String institutionFacultyId;
  final String
  certificateType; // COURSE_COMPLETION, CHARACTER, LEAVING, TRANSFER, PROVISIONAL
  final String degree;
  final String college;
  final DateTime issueDate;
  final DateTime enrollmentDate;
  final DateTime completionDate;
  final DateTime leavingDate;

  final String? major;
  final String? gpa;
  final double? percentage;
  final String? division;
  final String? universityName;

  // === OPTIONAL FIELDS ===
  final String? reasonForLeaving;
  final String? characterRemarks;
  final String? generalRemarks;

  MinimalCertificateDataModel({
    required this.studentId,
    required this.studentName,
    required this.institutionId,
    required this.institutionFacultyId,
    required this.certificateType,
    required this.degree,
    required this.college,
    required this.issueDate,
    required this.enrollmentDate,
    required this.completionDate,
    required this.leavingDate,

    this.major = "",
    this.gpa = "",
    this.percentage,
    this.division = "",
    this.universityName = "",

    this.reasonForLeaving,
    this.characterRemarks,
    this.generalRemarks,
  });

  factory MinimalCertificateDataModel.fromJson(Map<String, dynamic> json) {
    return MinimalCertificateDataModel(
      // Required fields
      studentId: json['student_id'] as String,
      studentName: json['student_name'] as String,
      institutionId: json['institution_id'] as String,
      institutionFacultyId: json['institution_faculty_id'] as String,
      certificateType: json['certificate_type'] as String,
      degree: json['degree'] as String,
      college: json['college'] as String,
      issueDate: DateTime.parse(json['issue_date'] as String),
      enrollmentDate: DateTime.parse(json['enrollment_date'] as String),
      completionDate: DateTime.parse(json['completion_date'] as String),
      leavingDate: DateTime.parse(json['leaving_date'] as String),

      major: json['major'] as String? ?? "",
      gpa: json['gpa'] as String? ?? "",
      percentage: json['percentage'] != null
          ? (json['percentage'] as num).toDouble()
          : null,
      division: json['division'] as String? ?? "",
      universityName: json['university_name'] as String? ?? "",
      reasonForLeaving: json['reason_for_leaving'] as String?,
      characterRemarks: json['character_remarks'] as String?,
      generalRemarks: json['general_remarks'] as String?,
    );
  }

  // In MinimalCertificateDataModel, update the toJson() method:
  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'student_name': studentName,
      'institution_id': institutionId,
      'institution_faculty_id': institutionFacultyId,
      'certificate_type': certificateType,
      'degree': degree,
      'college': college,
      'major': major ?? "",
      'gpa': gpa ?? "",
      'percentage': percentage ?? "",
      'division': division ?? "",
      'university_name': universityName ?? "",

      // FIX: Format dates properly for backend
      'issue_date': _formatDateForBackend(issueDate),
      'enrollment_date': _formatDateForBackend(enrollmentDate),
      'completion_date': _formatDateForBackend(completionDate),
      'leaving_date': _formatDateForBackend(leavingDate),

      'reason_for_leaving': reasonForLeaving,
      'character_remarks': characterRemarks,
      'general_remarks': generalRemarks,
    };
  }

  // Add this helper method to MinimalCertificateDataModel
  String _formatDateForBackend(DateTime date) {
    // Convert to local time and format with timezone offset
    final localDate = date.toLocal();

    // Format: "2024-01-15T10:30:00+05:45" (with timezone offset)
    final year = localDate.year.toString().padLeft(4, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final day = localDate.day.toString().padLeft(2, '0');
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');
    final second = localDate.second.toString().padLeft(2, '0');

    // Get timezone offset
    final timeZoneOffset = localDate.timeZoneOffset;
    final offsetHours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    final offsetMinutes = (timeZoneOffset.inMinutes.abs() % 60)
        .toString()
        .padLeft(2, '0');
    final offsetSign = timeZoneOffset.isNegative ? '-' : '+';

    return '${year}-${month}-${day}T${hour}:${minute}:${second}${offsetSign}${offsetHours}:${offsetMinutes}';
  }

  @override
  String toString() {
    return 'MinimalCertificateData(studentId: $studentId, studentName: $studentName, certificateType: $certificateType)';
  }
}
