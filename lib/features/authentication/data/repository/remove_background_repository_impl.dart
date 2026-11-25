import 'dart:typed_data';

import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/data/data_source/remove_background_data_source.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/remove_background_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveBackgroundRepositoryImpl extends RemoveBackgroundIRepository {
  RemoveBackgroundDataSource _removeBackgroundDataSource;

  RemoveBackgroundRepositoryImpl(this._removeBackgroundDataSource);

  @override
  DefaultFutureEitherType<Uint8List> removeBackground(
    Uint8List originalImage,
  ) async {
    try {
      final response = await _removeBackgroundDataSource.removeBackground(
        originalImage,
      );
      return Right(response);
    } on ServerError catch (e) {
      return Left(Errorz(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(Errorz(message: e.toString(), statusCode: e.hashCode));
    }
  }
}
