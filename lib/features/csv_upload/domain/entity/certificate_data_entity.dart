import 'dart:convert';

import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';

class CertificateDataEntity {
  // === ALWAYS REQUIRED FIELDS ===
  final String certificateId;
  final int blockNumber;
  final int position; // 1-4
  final String studentId;
  final String studentName;
  final String institutionId;
  final String institutionFacultyId;
  final String pdfCategoryId;
  final String
  certificateType; // COURSE_COMPLETION, CHARACTER, LEAVING, TRANSFER, PROVISIONAL
  final DateTime issueDate;
  final String facultyPublicKey;
  final DateTime createdAt;

  // === CONDITIONALLY REQUIRED FIELDS (provide empty defaults) ===
  final String degree;
  final String college;
  final String major;
  final String gpa;
  final double? percentage;
  final String division;
  final String universityName;

  // === DATE FIELDS (Required with fallbacks) ===
  final DateTime enrollmentDate;
  final DateTime completionDate;
  final DateTime leavingDate;

  // === TRULY OPTIONAL FIELDS ===
  final String? reasonForLeaving;
  final String? characterRemarks;
  final String? generalRemarks;

  // === CRYPTOGRAPHIC VERIFICATION ===
  String? certificateHash;

  CertificateDataEntity({
    // Required for ALL certificates
    required this.certificateId,
    required this.blockNumber,
    required this.position,
    required this.studentId,
    required this.studentName,
    required this.institutionId,
    required this.institutionFacultyId,
    required this.pdfCategoryId,
    required this.certificateType,
    required this.issueDate,
    required this.facultyPublicKey,
    required this.createdAt,

    // Conditionally required - use empty strings as defaults
    this.degree = "",
    this.college = "",
    this.major = "",
    this.gpa = "",
    this.percentage,
    this.division = "",
    this.universityName = "",

    // Date fields with fallbacks to issueDate
    required DateTime? enrollmentDate,
    required DateTime? completionDate,
    required DateTime? leavingDate,

    // Truly optional
    this.reasonForLeaving,
    this.characterRemarks,
    this.generalRemarks,
    this.certificateHash,
  }) : enrollmentDate = enrollmentDate ?? issueDate,
       completionDate = completionDate ?? issueDate,
       leavingDate = leavingDate ?? issueDate;

  factory CertificateDataEntity.fromJSON(Map<String, dynamic> json) {
    return CertificateDataEntity(
      // Required fields
      certificateId: json['certificate_id'] as String,
      blockNumber: json['block_number'] as int,
      position: json['position'] as int,
      studentId: json['student_id'] as String,
      studentName: json['student_name'] as String,
      institutionId: json['institution_id'] as String,
      institutionFacultyId: json['institution_faculty_id'] as String,
      pdfCategoryId: json['pdf_category_id'] as String,
      certificateType: json['certificate_type'] as String,
      issueDate: DateTime.parse(json['issue_date'] as String),
      facultyPublicKey: json['faculty_public_key'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),

      // Conditionally required fields with fallbacks
      degree: json['degree'] as String? ?? "",
      college: json['college'] as String? ?? "",
      major: json['major'] as String? ?? "",
      gpa: json['gpa'] as String? ?? "",
      percentage: json['percentage'] != null
          ? (json['percentage'] as num).toDouble()
          : null,
      division: json['division'] as String? ?? "",
      universityName: json['university_name'] as String? ?? "",

      // Date fields with null handling
      enrollmentDate: json['enrollment_date'] != null
          ? DateTime.parse(json['enrollment_date'] as String)
          : null,
      completionDate: json['completion_date'] != null
          ? DateTime.parse(json['completion_date'] as String)
          : null,
      leavingDate: json['leaving_date'] != null
          ? DateTime.parse(json['leaving_date'] as String)
          : null,

      // Optional fields
      reasonForLeaving: json['reason_for_leaving'] as String?,
      characterRemarks: json['character_remarks'] as String?,
      generalRemarks: json['general_remarks'] as String?,
      certificateHash: json['certificate_hash'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Required fields
    data['certificate_id'] = certificateId;
    data['block_number'] = blockNumber;
    data['position'] = position;
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['institution_id'] = institutionId;
    data['institution_faculty_id'] = institutionFacultyId;
    data['pdf_category_id'] = pdfCategoryId;
    data['certificate_type'] = certificateType;
    data['issue_date'] = _formatDateForBackend(issueDate);
    data['faculty_public_key'] = facultyPublicKey;
    data['created_at'] = _formatDateForBackend(createdAt);

    // Conditionally required fields - always include with empty string defaults
    data['degree'] = degree;
    data['college'] = college;
    data['major'] = major;
    data['gpa'] = gpa;
    if (percentage != null) data['percentage'] = percentage;
    data['division'] = division;
    data['university_name'] = universityName;

    // Date fields - always include (they have fallbacks)
    data['enrollment_date'] = enrollmentDate.toIso8601String();
    data['completion_date'] = completionDate.toIso8601String();
    data['leaving_date'] = leavingDate.toIso8601String();

    // Optional fields (only include if not null)
    if (reasonForLeaving != null) data['reason_for_leaving'] = reasonForLeaving;
    if (characterRemarks != null) data['character_remarks'] = characterRemarks;
    if (generalRemarks != null) data['general_remarks'] = generalRemarks;
    if (certificateHash != null) data['certificate_hash'] = certificateHash;

    return data;
  }

  // Convert to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Factory constructor from JSON string
  factory CertificateDataEntity.fromJsonString(String jsonString) {
    return CertificateDataEntity.fromJSON(jsonDecode(jsonString));
  }

  // toString method
  @override
  String toString() {
    return 'CertificateDataEntity(\n'
        '  certificateId: $certificateId,\n'
        '  blockNumber: $blockNumber,\n'
        '  position: $position,\n'
        '  studentId: $studentId,\n'
        '  studentName: $studentName,\n'
        '  institutionId: $institutionId,\n'
        '  institutionFacultyId: $institutionFacultyId,\n'
        '  pdfCategoryId: $pdfCategoryId,\n'
        '  certificateType: $certificateType,\n'
        '  degree: $degree,\n'
        '  college: $college,\n'
        '  major: $major,\n'
        '  gpa: $gpa,\n'
        '  percentage: $percentage,\n'
        '  division: $division,\n'
        '  universityName: $universityName,\n'
        '  issueDate: $issueDate,\n'
        '  enrollmentDate: $enrollmentDate,\n'
        '  completionDate: $completionDate,\n'
        '  leavingDate: $leavingDate,\n'
        '  reasonForLeaving: $reasonForLeaving,\n'
        '  characterRemarks: $characterRemarks,\n'
        '  generalRemarks: $generalRemarks,\n'
        '  facultyPublicKey: ${facultyPublicKey.substring(0, 16)}...,\n'
        '  createdAt: $createdAt\n'
        ')';
  }

  // Utility method to check if certificate is valid
  bool isValid() {
    return certificateId.isNotEmpty &&
        studentId.isNotEmpty &&
        studentName.isNotEmpty &&
        institutionId.isNotEmpty &&
        institutionFacultyId.isNotEmpty &&
        pdfCategoryId.isNotEmpty &&
        certificateType.isNotEmpty &&
        facultyPublicKey.isNotEmpty;
  }

  // Utility method to get certificate summary
  String getSummary() {
    return '$studentName ($studentId) - $certificateType - ${issueDate.year}';
  }

  // In your CertificateDataEntity class, update the toModel() method:
  MinimalCertificateDataModel toModel() {
    return MinimalCertificateDataModel(
      institutionId: institutionId,
      institutionFacultyId: institutionFacultyId,
      issueDate: issueDate,
      enrollmentDate: enrollmentDate,
      leavingDate: leavingDate,
      completionDate: completionDate,
      studentId: studentId,
      studentName: studentName,
      certificateType: certificateType,
      degree: degree,
      college: college,
      major: major.isNotEmpty ? major : null,
      gpa: gpa.isNotEmpty ? gpa : null,
      percentage: percentage.toString(),
      division: division.isNotEmpty ? division : null,
      universityName: universityName.isNotEmpty ? universityName : null,
      reasonForLeaving: reasonForLeaving,
      characterRemarks: characterRemarks,
      generalRemarks: generalRemarks,
    );
  }

  String _formatDateForBackend(DateTime date) {
    return date.toUtc().toIso8601String().replaceAll('000Z', 'Z');
  }
}
