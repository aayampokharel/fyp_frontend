import 'package:flutter_dashboard/core/use_case.dart';

abstract interface class InstitutionIsActiveRepository {
  DefaultFutureEitherType<String> updateIsActiveForInstitution(
    String institutionID,
    bool isActive,
  );
}
