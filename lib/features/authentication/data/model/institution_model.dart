import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

class InstitutionRequestModel {
  final String institutionName;
  final String wardNumber;
  final String toleAddress;
  final String districtAddress;

  InstitutionRequestModel({
    required this.institutionName,
    required this.wardNumber,
    required this.toleAddress,
    required this.districtAddress,
  });

  Map<String, dynamic> toJSON() => {
    'institution_name': institutionName,
    'ward_number': wardNumber,
    'tole_address': toleAddress,
    'district_address': districtAddress,
  };
}

class InstitutionResponseModel {
  final String institutionID;
  final bool isActive;

  InstitutionResponseModel({
    required this.institutionID,
    required this.isActive,
  });

  factory InstitutionResponseModel.fromJson(Map<String, dynamic> json) =>
      InstitutionResponseModel(
        institutionID: json['institution_id'],
        isActive: json['is_active'],
      );

  InstitutionEntity toEntity(
    String institutionName,
    String wardNumber,
    String toleAddress,
    String districtAddress,
  ) => InstitutionEntity(
    institutionName,
    wardNumber,
    toleAddress,
    districtAddress,
    isActive,
    institutionID: institutionID,
  );
}
