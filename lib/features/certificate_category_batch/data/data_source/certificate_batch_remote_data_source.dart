import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

class CertificateBatchRemoteDataSource {
  final DioClient _dioClient;

  CertificateBatchRemoteDataSource(this._dioClient);

  Future<List<CertificateDataEntity>> getCertificateBatch(
    String institutionID,
    String institutionFacultyID,
    String categoryID,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.getCertificates,
        queryParameters: {
          ApiEndpoints.institutionIDQuery: institutionID,
          ApiEndpoints.institutionFacultyIDQuery: institutionFacultyID,
          ApiEndpoints.institutionCategoryIDQuery: categoryID,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> categoriesList = response.data['data'];
        List<CertificateDataEntity> categoriesEntityList = categoriesList
            .map((elem) => CertificateDataEntity.fromJSON(elem))
            .toList();
        return categoriesEntityList;
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
