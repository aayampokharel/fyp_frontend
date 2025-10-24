import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/user_account_entity.dart';

abstract interface class UserAccountRepository {
  DefaultFutureEitherType<UserAccountEntity> createNewUserAccount({
    required UserAccountEntityParams params,
  });
}
