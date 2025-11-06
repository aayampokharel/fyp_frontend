import 'dart:convert';

import 'package:flutter_dashboard/features/csv_upload/data/models/minimal_certificate_data_model.dart';

class CreateCertificateDataRequest {
  final String institutionId;
  final String institutionFacultyId;
  final String institutionFacultyName;
  final String categoryId;
  final String categoryName;
  final List<MinimalCertificateDataModel> certificateData;

  CreateCertificateDataRequest({
    required this.institutionId,
    required this.institutionFacultyId,
    required this.institutionFacultyName,
    required this.categoryId,
    required this.categoryName,
    required this.certificateData,
  });

  // Factory constructor from JSON
  factory CreateCertificateDataRequest.fromJson(Map<String, dynamic> json) {
    return CreateCertificateDataRequest(
      institutionId: json['institution_id'] as String,
      institutionFacultyId: json['institution_faculty_id'] as String,
      institutionFacultyName: json['institution_faculty_name'] as String,
      categoryId: json['category_id'] as String,
      categoryName: json['category_name'] as String,
      certificateData: (json['certificate_data'] as List)
          .map(
            (item) => MinimalCertificateDataModel.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'institution_id': institutionId,
      'institution_faculty_id': institutionFacultyId,
      'institution_faculty_name': institutionFacultyName,
      'category_id': categoryId,
      'category_name': categoryName,
      'certificate_data': certificateData.map((data) => data.toJson()).toList(),
    };
  }

  // Convert to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Factory constructor from JSON string
  factory CreateCertificateDataRequest.fromJsonString(String jsonString) {
    return CreateCertificateDataRequest.fromJson(jsonDecode(jsonString));
  }

  // Copy with method for immutability
  CreateCertificateDataRequest copyWith({
    String? institutionId,
    String? institutionFacultyId,
    String? institutionFacultyName,
    String? categoryId,
    String? categoryName,
    List<MinimalCertificateDataModel>? certificateData,
  }) {
    return CreateCertificateDataRequest(
      institutionId: institutionId ?? this.institutionId,
      institutionFacultyId: institutionFacultyId ?? this.institutionFacultyId,
      institutionFacultyName:
          institutionFacultyName ?? this.institutionFacultyName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      certificateData: certificateData ?? this.certificateData,
    );
  }

  // toString method
  @override
  String toString() {
    return 'CreateCertificateDataRequest(\n'
        '  institutionId: $institutionId,\n'
        '  institutionFacultyId: $institutionFacultyId,\n'
        '  institutionFacultyName: $institutionFacultyName,\n'
        '  categoryId: $categoryId,\n'
        '  categoryName: $categoryName,\n'
        '  certificateData: [${certificateData.length} items]\n'
        ')';
  }

  // Detailed toString method
  String toDetailedString() {
    final certificateDataString = certificateData
        .map((data) => '    $data')
        .join(',\n');
    return 'CreateCertificateDataRequest(\n'
        '  institutionId: $institutionId,\n'
        '  institutionFacultyId: $institutionFacultyId,\n'
        '  institutionFacultyName: $institutionFacultyName,\n'
        '  categoryId: $categoryId,\n'
        '  categoryName: $categoryName,\n'
        '  certificateData: [\n$certificateDataString\n  ]\n'
        ')';
  }

  // Get total number of certificates
  int get totalCertificates => certificateData.length;

  // Get unique student IDs
  Set<String> get uniqueStudentIds {
    return certificateData.map((cert) => cert.studentId).toSet();
  }

  // // Get certificates by type
  // Map<String, List<MinimalCertificateDataModel>> get certificatesByType {
  //   final Map<String, List<MinimalCertificateDataModel>> result = {};
  //   for (final cert in certificateData) {
  //     result.putIfAbsent(cert.certificateType, () => []).add(cert);
  //   }
  //   return result;
  // }

  // Add a certificate to the list
  CreateCertificateDataRequest addCertificate(
    MinimalCertificateDataModel certificate,
  ) {
    return copyWith(certificateData: [...certificateData, certificate]);
  }

  // Remove a certificate by student ID
  CreateCertificateDataRequest removeCertificateByStudentId(String studentId) {
    return copyWith(
      certificateData: certificateData
          .where((cert) => cert.studentId != studentId)
          .toList(),
    );
  }

  // Filter certificates by certificate type
  CreateCertificateDataRequest filterByCertificateType(String certificateType) {
    return copyWith(
      certificateData: certificateData
          .where((cert) => cert.certificateType == certificateType)
          .toList(),
    );
  }
}
