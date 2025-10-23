class InstitutionEntity {
  String institutionID;

  InstitutionEntity({required this.institutionID});

  factory InstitutionEntity.fromJSON(Map<String, String> json) =>
      InstitutionEntity(institutionID: json['institutionID'] ?? "");

  InstitutionEntity toJSON() => InstitutionEntity(institutionID: institutionID);
}
