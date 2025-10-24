// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';

class InstitutionUseCaseParams {
  String institutionName;
  int wardNumber;
  String toleAddress;
  String districtAddress;
  InstitutionUseCaseParams({
    required this.institutionName,
    required this.wardNumber,
    required this.toleAddress,
    required this.districtAddress,
  });
}

class InstitutionUseCase
    implements UseCase<InstitutionEntity, InstitutionUseCaseParams> {
  final InstitutionRepository _institutionRepository;
  InstitutionUseCase(this._institutionRepository);
  @override
  DefaultFutureEitherType<InstitutionEntity> call(params) {
    return _institutionRepository.sendInstitutionInfo(
      params.institutionName,
      params.wardNumber,
      params.toleAddress,
      params.districtAddress,
    );
  }
}
