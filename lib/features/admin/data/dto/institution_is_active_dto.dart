class InstitutionActiveDto {
  final String institutionId;
  final bool isActive;

  InstitutionActiveDto({required this.institutionId, required this.isActive});

  Map<String, dynamic> toJson() {
    return {'institution_id': institutionId, 'is_active': isActive};
  }
}
