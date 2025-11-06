import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';

class CreatePDFCategoryDto {
  final String facultyName;
  final String preferredCategoryName;
  final String institutionId;
  final String institutionFacultyId;

  CreatePDFCategoryDto({
    required this.facultyName,
    required this.preferredCategoryName,
    required this.institutionId,
    required this.institutionFacultyId,
  });

  factory CreatePDFCategoryDto.fromJson(Map<String, dynamic> json) {
    return CreatePDFCategoryDto(
      facultyName: json['faculty_name'] as String? ?? '',
      preferredCategoryName: json['preferred_category_name'] as String? ?? '',
      institutionId: json['institution_id'] as String? ?? '',
      institutionFacultyId: json['institution_faculty_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final json = {
      'faculty_name': facultyName,
      'preferred_category_name': preferredCategoryName,
      'institution_id': institutionId,
      'institution_faculty_id': institutionFacultyId,
    };
    // Debug: Print what's being sent
    print('Sending CreatePDFCategoryDto: $json');
    return json;
  }

  @override
  String toString() {
    return 'CreatePDFCategoryDto(facultyName: $facultyName, preferredCategoryName: $preferredCategoryName, institutionId: $institutionId, institutionFacultyId: $institutionFacultyId)';
  }
}

class CreatePDFCategoryResponseDto {
  final String categoryId;
  final String categoryName;

  CreatePDFCategoryResponseDto({
    required this.categoryId,
    required this.categoryName,
  });

  factory CreatePDFCategoryResponseDto.fromJson(Map<String, dynamic> json) {
    return CreatePDFCategoryResponseDto(
      categoryId: json['category_id'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'category_id': categoryId, 'category_name': categoryName};
  }

  @override
  String toString() {
    return 'CreatePDFCategoryResponseDto(categoryId: $categoryId, categoryName: $categoryName)';
  }

  CertificateCategoryEntity toEntity({
    required String institutionID,
    required String institutionFacultyID,
  }) {
    return CertificateCategoryEntity(
      categoryID: categoryId,
      institutionID: institutionID,
      institutionFacultyID: institutionFacultyID,
      categoryName: categoryName,
      createdAt: DateTime.now(),
    );
  }
}
