class InstitutionEntity {
  final String institutionID;
  final String institutionName;
  final int wardNumber;
  final String toleAddress;
  final String districtAddress;
  final bool isActive;

  const InstitutionEntity(
    this.institutionName,
    this.wardNumber,
    this.toleAddress,
    this.districtAddress,
    this.isActive, {
    required this.institutionID,
  });
}
