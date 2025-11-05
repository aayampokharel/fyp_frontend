class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8000';

  //========================auth endpoints===============================
  static const String authInstitution = '/auth/new-institution';
  static const String authUser = '/auth/new-user';
  static const String authFaculty = '/auth/new-faculty';
  static const String authVerifyInstitution = '/auth/verify-institution';
  //========================admin endpoints===============================
  static const String adminLogin = '/admin/login';
  static const String authNewAdmin = '/admin/signup';
  //========================sse endpoints===============================
  static const String sseInstitution = '/sse/institution';
  //========================fileuploadendpoints==============================
  static const String certificatesupload = '/blockchain/certificates';
  //========================categoryBatchendpoints==============================
  static const String getcategories = '/institution/categories';
  static const String getCertificates = '/institution/certificates';
  static const String postcategory = '/institution/category';
  static const String institutionIDQuery = "institution_id";
  static const String institutionFacultyIDQuery = "institution_faculty_id";
  static const String institutionCategoryIDQuery = "category_id";
  //========================fileuploadendpoints==============================
  static const String institutionStatus = '/institution/status';
}
