class InstitutionEntity {
  final String institutionID;
  final String institutionName;
  final int wardNumber;
  final String toleAddress;
  final String districtAddress;
  final bool? isActive;

  const InstitutionEntity(
    this.institutionName,
    this.wardNumber,
    this.toleAddress,
    this.districtAddress,
    this.isActive, {
    required this.institutionID,
  });

  factory InstitutionEntity.fromMap(Map<String, dynamic> map) {
    return InstitutionEntity(
      institutionID: map['institution_id'] ?? '',
      map['institution_name'] ?? '',
      int.tryParse(map['ward_number'].toString()) ?? 0,
      map['tole_address'] ?? '',
      map['district_address'] ?? '',
      map['is_active'], // may be null
    );
  }

  Map<String, dynamic> toJSON() => {
    'institution_id': institutionID,
    'institution_name': institutionName,
    'ward_number': wardNumber,
    'tole_address': toleAddress,
    'district_address': districtAddress,
    'is_active': isActive,
  };
  factory InstitutionEntity.fromJSON(Map<String, dynamic> json) {
    final data = json['data'] ?? json; // Handles { code, message, data: {..} }

    return InstitutionEntity(
      data['institution_name'] ?? '',
      int.tryParse(data['ward_number'].toString()) ?? 0,
      data['tole_address'] ?? '',
      data['district_address'] ?? '',
      data['is_active'], // can be true, false, or null
      institutionID: data['institution_id'] ?? '',
    );
  }

  @override
  String toString() => toJSON().toString();
}
