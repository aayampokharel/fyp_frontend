import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

abstract interface class InstitutionIsActiveIrepository {
  DefaultFutureEitherType<InstitutionEntity> checkIsActiveForCurrentInstitution(
    String instituitonID,
  );
}
