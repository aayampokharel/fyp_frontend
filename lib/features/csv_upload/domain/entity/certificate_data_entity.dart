import 'dart:convert';

import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';

class CertificateDataEntity {
  // Core Certificate Identity
  final String certificateId;
  final int blockNumber;
  final int position; // 1-4

  // Student Information (Required)
  final String studentId;
  final String studentName;

  // Institution & Faculty Information
  final String institutionId;
  final String institutionFacultyId;
  final String pdfCategoryId;

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
  final DateTime issueDate;
  final DateTime? enrollmentDate;
  final DateTime? completionDate;
  final DateTime? leavingDate;

  // Reason Fields
  final String? reasonForLeaving;
  final String? characterRemarks;
  final String? generalRemarks;

  // Cryptographic Verification
  String? certificateHash;
  final String facultyPublicKey;

  // Timestamps
  final DateTime createdAt;

  CertificateDataEntity({
    required this.certificateId,
    required this.blockNumber,
    required this.position,
    required this.studentId,
    required this.studentName,
    required this.institutionId,
    required this.institutionFacultyId,
    required this.pdfCategoryId,
    required this.certificateType,
    this.degree,
    this.college,
    this.major,
    this.gpa,
    this.percentage,
    this.division,
    this.universityName,
    required this.issueDate,
    this.enrollmentDate,
    this.completionDate,
    this.leavingDate,
    this.reasonForLeaving,
    this.characterRemarks,
    this.generalRemarks,
    this.certificateHash,
    required this.facultyPublicKey,
    required this.createdAt,
  });

  factory CertificateDataEntity.fromJSON(Map<String, dynamic> json) {
    return CertificateDataEntity(
      certificateId: json['certificate_id'] as String,
      blockNumber: json['block_number'] as int,
      position: json['position'] as int,
      studentId: json['student_id'] as String,
      studentName: json['student_name'] as String,
      institutionId: json['institution_id'] as String,
      institutionFacultyId: json['institution_faculty_id'] as String,
      pdfCategoryId: json['pdf_category_id'] as String,
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
      enrollmentDate: json['enrollment_date'] != null
          ? DateTime.parse(json['enrollment_date'] as String)
          : null,
      completionDate: json['completion_date'] != null
          ? DateTime.parse(json['completion_date'] as String)
          : null,
      leavingDate: json['leaving_date'] != null
          ? DateTime.parse(json['leaving_date'] as String)
          : null,
      reasonForLeaving: json['reason_for_leaving'] as String?,
      characterRemarks: json['character_remarks'] as String?,
      generalRemarks: json['general_remarks'] as String?,
      certificateHash: json['certificate_hash'] as String,
      facultyPublicKey: json['faculty_public_key'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['certificate_id'] = certificateId;
    data['block_number'] = blockNumber;
    data['position'] = position;
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['institution_id'] = institutionId;
    data['institution_faculty_id'] = institutionFacultyId;
    data['pdf_category_id'] = pdfCategoryId;
    data['certificate_type'] = certificateType;

    // Only include optional fields if they are not null
    if (degree != null) data['degree'] = degree;
    if (college != null) data['college'] = college;
    if (major != null) data['major'] = major;
    if (gpa != null) data['gpa'] = gpa;
    if (percentage != null) data['percentage'] = percentage;
    if (division != null) data['division'] = division;
    if (universityName != null) data['university_name'] = universityName;

    data['issue_date'] = issueDate.toIso8601String();
    if (enrollmentDate != null) {
      data['enrollment_date'] = enrollmentDate!.toIso8601String();
    }
    if (completionDate != null) {
      data['completion_date'] = completionDate!.toIso8601String();
    }
    if (leavingDate != null) {
      data['leaving_date'] = leavingDate!.toIso8601String();
    }

    if (reasonForLeaving != null) data['reason_for_leaving'] = reasonForLeaving;
    if (characterRemarks != null) data['character_remarks'] = characterRemarks;
    if (generalRemarks != null) data['general_remarks'] = generalRemarks;

    data['certificate_hash'] = certificateHash;
    data['faculty_public_key'] = facultyPublicKey;
    data['created_at'] = createdAt.toIso8601String();

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
      major: major,
      gpa: gpa,
      percentage: percentage,
      division: division,
      universityName: universityName,
      reasonForLeaving: reasonForLeaving,
      characterRemarks: characterRemarks,
      generalRemarks: generalRemarks,
    );
  }
}
