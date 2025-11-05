import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/certificate_category_batch/domain/entity/certificate_category_entity.dart';

class CategoryBatchRemoteDataSource {
  final DioClient _dioClient;

  CategoryBatchRemoteDataSource(this._dioClient);

  Future<List<CertificateCategoryEntity>> getCategoryBatch(
    String institutionID,
    String institutionFacultyID,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        ApiEndpoints.getcategories,
        queryParameters: {
          ApiEndpoints.institutionIDQuery: institutionID,
          ApiEndpoints.institutionFacultyIDQuery: institutionFacultyID,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> categoriesList = response.data['data'];
        List<CertificateCategoryEntity> categoriesEntityList = categoriesList
            .map((elem) => CertificateCategoryEntity.fromJson(elem))
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
