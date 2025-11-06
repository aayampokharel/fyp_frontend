import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institute_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/admin_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';

class InstituteAccountUseCaseParams {
  String email;
  String password;
  InstituteAccountUseCaseParams({required this.email, required this.password});
}

class InstituteAccountUseCase
    implements UseCase<InstituteAccountEntity, InstituteAccountUseCaseParams> {
  final InstitutionRepository _institutionAccountRepository;
  InstituteAccountUseCase(this._institutionAccountRepository);
  @override
  DefaultFutureEitherType<InstituteAccountEntity> call(params) {
    return _institutionAccountRepository.instituteLogin(
      email: params.email,
      password: params.password,
    );
  }
}
