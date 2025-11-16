import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/authentication/data/model/Admin_account_model.dart';
import 'package:flutter_dashboard/features/authentication/domain/entity/institution_entity.dart';

import '../../../../core/errors/app_logger.dart' show AppLogger;

class AdminAccountRemoteDataSource {
  final DioClient _dioClient;

  AdminAccountRemoteDataSource(this._dioClient);

  Future<AdminDashboardCountsResponseModel> verifyAdminLogin(
    AdminAccountRequestModel adminAccountRequest,
  ) async {
    try {
      AppLogger.info(adminAccountRequest.toJSON());
      final response = await _dioClient.dio.post(
        ApiEndpoints.adminLogin,
        data: adminAccountRequest.toJSON(),
        options: Options(
          validateStatus: (status) {
            return status! < 600;
          },
        ),
      );

      if (response.statusCode == 200) {
        final pendingInstitutionsJson =
            response.data['data']['pending_institutions'] as List<dynamic>;

        final pendingInstitutions = pendingInstitutionsJson
            .map(
              (json) => InstitutionEntity.fromMap(json as Map<String, dynamic>),
            )
            .toList();

        AppLogger.info(response.data);
        var res = AdminDashboardCountsResponseModel.fromJson(
          response.data['data']['admin_dashboard_count_details'],
        );
        AppLogger.info(response.data['data']);
        return AdminDashboardCountsResponseModel(
          activeInstitutions: res.activeInstitutions,
          deletedInstitutions: res.deletedInstitutions,
          signedUpInstitutions: res.signedUpInstitutions,
          totalFaculties: res.totalFaculties,
          activeUsers: res.activeUsers,
          deletedUsers: res.deletedUsers,
          activeAdmins: res.activeAdmins,
          activeInstitutes: res.activeInstitutes,
          totalPDFCategories: res.totalPDFCategories,
          totalPDFFiles: res.totalPDFFiles,
          totalCertificates: res.totalCertificates,
          totalBlocks: res.totalBlocks,
          pendingInstitutionEntities: pendingInstitutions,
        );
      } else {
        AppLogger.apiError(
          ApiEndpoints.authUser,
          response.data['code'] ?? response.statusCode,
          response.data['message'],
        );
        throw Errorz(
          message: response.data['message'],
          statusCode: response.data['code'] ?? response.statusCode,
        );
      }
    } on DioException catch (e) {
      AppLogger.error("Dio Exception: ${e.message}");
      throw ServerError(extraMsg: e.message);
    } catch (e) {
      AppLogger.error("Other Exception: ${e.toString()}");
      throw Errorz(statusCode: 500, message: e.toString());
    }
  }
}
