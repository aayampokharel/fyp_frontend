import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/admin/domain/repository/institution_is_active_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/admin_repository.dart';

class UpdateInstitutionIsActiveStatusUseCaseParams {
  String institutionID;
  bool isActive;

  UpdateInstitutionIsActiveStatusUseCaseParams({
    required this.institutionID,
    required this.isActive,
  });
}

class AdminInstitutionUseCase
    implements UseCase<String, UpdateInstitutionIsActiveStatusUseCaseParams> {
  final InstitutionIsActiveRepository _adminAccountRepository;
  AdminInstitutionUseCase(this._adminAccountRepository);
  @override
  DefaultFutureEitherType<String> call(params) {
    return _adminAccountRepository.updateIsActiveForInstitution(
      params.institutionID,
      params.isActive,
    );
  }
}
