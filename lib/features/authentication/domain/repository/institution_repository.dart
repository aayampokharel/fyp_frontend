import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institute_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

abstract class InstitutionRepository {
  DefaultFutureEitherType<InstitutionEntity> sendInstitutionInfo(
    final String institutionName,
    final int wardNumber,
    final String toleAddress,
    final String districtAddress,
  );

  DefaultFutureEitherType<InstituteAccountEntity> instituteLogin({
    required String email,
    required String password,
  });
}
