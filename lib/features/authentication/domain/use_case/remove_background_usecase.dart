// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:typed_data';

import 'package:flutter_dashboard/core/use_case.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/institution_repository.dart';
import 'package:flutter_dashboard/features/authentication/domain/repository/remove_background_repository.dart';

class RemoveBackgroundUseCase implements UseCase<Uint8List, Uint8List> {
  final RemoveBackgroundIRepository _removeBackgroundRepository;
  RemoveBackgroundUseCase(this._removeBackgroundRepository);
  @override
  DefaultFutureEitherType<Uint8List> call(params) {
    return _removeBackgroundRepository.removeBackground(params);
  }
}
