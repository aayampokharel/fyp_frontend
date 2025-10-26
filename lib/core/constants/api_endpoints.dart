class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8000';

  //========================auth endpoints===============================
  static const String authInstitution = '/auth/new-institution';
  static const String authUser = '/auth/new-user';
  static const String authFaculty = '/auth/new-faculty';
  //========================admin endpoints===============================
  static const String adminLogin = '/admin/login';
  static const String authNewAdmin = '/admin/signup';
  //========================sse endpoints===============================
  static const String sseInstitution = '/sse/institution';
}
