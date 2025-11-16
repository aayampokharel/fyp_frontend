import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/admin_account_entity.dart';

abstract interface class AdminAccountRepository {
  DefaultFutureEitherType<AdminDashboardCountsEntity> adminLogin({
    required String email,
    required String password,
  });
}
