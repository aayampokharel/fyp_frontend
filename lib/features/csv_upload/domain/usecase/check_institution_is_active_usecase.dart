import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/repository/institution_is_active_irepository.dart';

class CheckInstitutionIsActiveUsecase
    implements UseCase<InstitutionEntity, String> {
  final InstitutionIsActiveIrepository _institutionIsActiveIrepository;

  CheckInstitutionIsActiveUsecase(this._institutionIsActiveIrepository);
  @override
  DefaultFutureEitherType<InstitutionEntity> call(String params) {
    return _institutionIsActiveIrepository.checkIsActiveForCurrentInstitution(
      params,
    );
  }
}
