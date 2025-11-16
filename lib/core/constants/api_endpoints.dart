class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8000';

  //========================auth endpoints===============================
  static const String authInstitution = '/auth/new-institution';
  static const String authUser = '/auth/new-user';
  static const String authFaculty = '/auth/new-faculty';
  static const String authVerifyInstitution = '/auth/verify-institution';
  static const String authInstitutionLogin = "/auth/institution/login";
  //========================admin endpoints===============================
  static const String adminLogin = '/admin/login';
  static const String adminInstitution = '/admin/institution';
  static const String authNewAdmin = '/admin/signup';
  //========================sse endpoints===============================
  static const String sseInstitution = '/sse/institution';
  //========================fileuploadendpoints==============================
  static const String certificatesupload = '/blockchain/certificates';
  static const String getCertificatesBatch = '/blockchain/certificate-batch';
  //========================categoryBatchendpoints==============================
  static const String getcategories = '/institution/categories';
  static const String getCertificates = '/institution/certificates';
  static const String postcategory = '/institution/category';
  static const String institutionIDQuery = "institution_id";
  static const String isDownloadAllQuery = "is_download_all";
  static const String institutionFacultyIDQuery = "institution_faculty_id";
  static const String categoryIDQuery = "category_id";
  static const String fileIDQuery = "file_id";
  static const String idQuery =
      "id"; //not made for now , but needs to be implemented later .
  static const String categoryNameQuery = "category_name";

  //========================fileuploadendpoints==============================
  static const String institutionStatus = '/institution/status';
  static const String certificateDownload = '/certificate/download';
  static const String certificatePreview = '/certificate/preview';
  static const String removeBackground = '/image/remove-background';
}
