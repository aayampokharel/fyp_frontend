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

  Map<String, dynamic> toJSON() => {
    'institution_id': institutionID,
    'institution_name': institutionName,
    'ward_number': wardNumber,
    'tole_address': toleAddress,
    'district_address': districtAddress,
    'is_active': isActive,
  };

  @override
  String toString() => toJSON().toString();
}
