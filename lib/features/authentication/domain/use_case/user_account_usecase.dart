import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/user_account_repository.dart';

class UserAccountUseCase
    implements UseCase<UserAccountEntity, UserAccountEntityParams> {
  final UserAccountRepository _userAccountRepository;
  UserAccountUseCase(this._userAccountRepository);
  @override
  DefaultFutureEitherType<UserAccountEntity> call(params) {
    return _userAccountRepository.createNewUserAccount(params: params);
  }
}
