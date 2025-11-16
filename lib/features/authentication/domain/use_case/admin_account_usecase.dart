import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/admin_repository.dart';

class AdminAccountUseCaseParams {
  String email;
  String password;
  AdminAccountUseCaseParams({required this.email, required this.password});
}

class AdminAccountUseCase
    implements UseCase<AdminDashboardCountsEntity, AdminAccountUseCaseParams> {
  final AdminAccountRepository _adminAccountRepository;
  AdminAccountUseCase(this._adminAccountRepository);
  @override
  DefaultFutureEitherType<AdminDashboardCountsEntity> call(params) {
    return _adminAccountRepository.adminLogin(
      email: params.email,
      password: params.password,
    );
  }
}
