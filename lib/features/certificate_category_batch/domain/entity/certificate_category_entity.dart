class CertificateCategoryEntity {
  final String categoryID;
  final String institutionID;
  final String institutionFacultyID;
  final String categoryName;
  final DateTime createdAt;

  CertificateCategoryEntity({
    required this.categoryID,
    required this.institutionID,
    required this.institutionFacultyID,
    required this.categoryName,
    required this.createdAt,
  });

  factory CertificateCategoryEntity.fromJson(Map<String, dynamic> json) {
    return CertificateCategoryEntity(
      categoryID: json['CategoryID'] as String,
      institutionID: json['InstitutionID'] as String,
      institutionFacultyID: json['InstitutionFacultyID'] as String,
      categoryName: json['CategoryName'] as String,
      createdAt: DateTime.parse(json['CreatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryID': categoryID,
      'InstitutionID': institutionID,
      'InstitutionFacultyID': institutionFacultyID,
      'CategoryName': categoryName,
      'CreatedAt': createdAt.toIso8601String(),
    };
  }

  CertificateCategoryEntity toEntity() {
    return CertificateCategoryEntity(
      categoryID: categoryID,
      institutionID: institutionID,
      institutionFacultyID: institutionFacultyID,
      categoryName: categoryName,
      createdAt: createdAt,
    );
  }
}
