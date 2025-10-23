import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:fpdart/fpdart.dart';

typedef DefaultFutureEitherType<SuccessType> =
    Future<Either<Errorz, SuccessType>>;

typedef DefaultEitherType<SuccessType> = Either<Errorz, SuccessType>;

abstract interface class UseCase<SuccessType, Params> {
  DefaultFutureEitherType<SuccessType> call(Params params);
}

abstract interface class UseCaseWithoutParams<SuccessType> {
  DefaultFutureEitherType<SuccessType> call();
}
