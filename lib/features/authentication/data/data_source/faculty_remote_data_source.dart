import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/faculty_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/faculty_entity.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FacultyRemoteDataSource {
  final DioClient _dioClient;
  FacultyRemoteDataSource(this._dioClient);

  Future<FacultyEntity> InsertFaculty(
    FacultyRequestModel facultyRequestModel,
  ) async {
    try {
      final response = await _dioClient.dio.post(
        ApiEndpoints.authFaculty,
        data: facultyRequestModel.toJSON(),
      );
      if (response.statusCode == 200) {
        var facultyEntityObj = facultyRequestModel.toEntity();
        return FacultyEntity.fromJSON(
          response.data['data'] as Map<String, dynamic>,
        );
      } else {
        throw Errorz(
          message: response.data['message'] ?? "Error:",
          statusCode: response.data['code'] ?? response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
