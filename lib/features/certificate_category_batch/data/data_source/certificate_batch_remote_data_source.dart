import 'package:dio/dio.dart';
import 'package:flutter_dashboard/core/constants/api_endpoints.dart';
import 'package:flutter_dashboard/core/errors/app_logger.dart';
import 'package:flutter_dashboard/core/errors/errorz.dart';
import 'package:flutter_dashboard/core/wrappers/dio_client.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';
import 'package:url_launcher/url_launcher.dart';

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
        ApiEndpoints.getCertificatesBatch,
        queryParameters: {
          ApiEndpoints.institutionIDQuery: institutionID,
          ApiEndpoints.institutionFacultyIDQuery: institutionFacultyID,
          ApiEndpoints.categoryIDQuery: categoryID,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data['data'];

        if (data != null && data is List) {
          return data
              .map((elem) => CertificateDataEntity.fromJSON(elem))
              .toList();
        } else {
          return [];
        }
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

  Future<void> downloadCertificatePDFOrZip(
    String categoryName,
    String categoryID,
    String fileID,
    bool downloadAll,
  ) async {
    try {
      AppLogger.info(ApiEndpoints.baseUrl + ApiEndpoints.certificateDownload);
      final url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.certificateDownload)
              .replace(
                queryParameters: {
                  ApiEndpoints.categoryIDQuery: categoryID,
                  ApiEndpoints.categoryNameQuery: categoryName,
                  ApiEndpoints.fileIDQuery: fileID,
                  ApiEndpoints.isDownloadAllQuery: downloadAll.toString(),
                },
              )
              .toString();

      print('Generated URL: $url');
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
      } else {
        throw Errorz(message: 'Could not launch $url', statusCode: 404);
      }
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }

  Future<void> getCertificateHTMLPreview(String id, String hash) async {
    try {
      final url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.certificatePreview)
              .replace(
                queryParameters: {
                  ApiEndpoints.idQuery: id,
                  ApiEndpoints.certificateHashQuery: hash,
                },
              )
              .toString();

      print('Generated URL: $url');

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
      } else {
        throw Errorz(message: 'Could not launch $url', statusCode: 404);
      }
    } catch (e) {
      throw Errorz(message: e.toString(), statusCode: e.hashCode);
    }
  }
}
