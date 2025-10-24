class AppLogger {
  static void info(String message) {
    print('ℹ️ INFO: $message');
  }

  static void debug(String message) {
    print('🐛 DEBUG: $message');
  }

  static void warning(String message) {
    print('⚠️ WARNING: $message');
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    print('❌ ERROR: $message');
    if (error != null) {
      print('🔴 Exception: $error');
    }
    if (stackTrace != null) {
      print('📋 StackTrace: $stackTrace');
    }
  }

  static void apiError(String endpoint, int statusCode, String response) {
    print('🌐 API ERROR: $endpoint');
    print('📊 Status: $statusCode');
    print('📄 Response: $response');
  }
}

// Usage
