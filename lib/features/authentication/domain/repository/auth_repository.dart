import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Either<Error, String> signIn(String email, String password);
}
