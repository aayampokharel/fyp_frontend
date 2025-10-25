class AppLogger {
  static void info(Object message) {
    _printLog('INFO', '👀', '\x1B[32m', message.toString());
  }

  static void debug(Object message) {
    _printLog('DEBUG', '🐛', '\x1B[34m', message.toString());
  }

  static void warning(Object message) {
    _printLog('WARNING', '⚠️', '\x1B[33m', message.toString());
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    final traceInfo = _getTraceInfo();

    print('\x1B[31m❌ ERROR:\x1B[0m $message');
    print('\x1B[90m📍 Location: ${traceInfo.file}:${traceInfo.line}\x1B[0m');

    if (error != null) {
      print('\x1B[31m🔴 Exception:\x1B[0m $error');
    }
    if (stackTrace != null) {
      print('\x1B[31m📋 StackTrace:\x1B[0m $stackTrace');
    }
  }

  static void apiError(String endpoint, int statusCode, Object response) {
    final traceInfo = _getTraceInfo();
    print('\x1B[31m🌐 API ERROR:\x1B[0m $endpoint');
    print('\x1B[33m📊 Status:\x1B[0m $statusCode');
    print('\x1B[33m📄 Response:\x1B[0m ${response.toString()}');
    print('\x1B[90m📍 Location: ${traceInfo.file}:${traceInfo.line}\x1B[0m');
  }

  static void _printLog(
    String level,
    String emoji,
    String color,
    String message,
  ) {
    final traceInfo = _getTraceInfo();

    print('$color$emoji $level:\x1B[0m $message');
    print('\x1B[90m📍 Location: ${traceInfo.file}:${traceInfo.line}\x1B[0m');
  }

  static _TraceInfo _getTraceInfo() {
    try {
      final trace = StackTrace.current.toString().split('\n');

      for (int i = 3; i < trace.length; i++) {
        final line = trace[i].trim();
        if (line.isNotEmpty &&
            !line.contains('AppLogger') &&
            !line.contains('app_logger') &&
            line.contains('.dart')) {
          final regExp = RegExp(r'([^/]+\.dart)(?:[^\d]+)(\d+):\d+');
          final match = regExp.firstMatch(line);

          if (match != null) {
            return _TraceInfo(file: match.group(1)!, line: match.group(2)!);
          }
        }
      }

      for (int i = 0; i < trace.length; i++) {
        final line = trace[i].trim();
        if (line.isNotEmpty &&
            !line.contains('AppLogger') &&
            !line.contains('app_logger') &&
            line.contains('.dart')) {
          final regExp = RegExp(r'([^/]+\.dart)(?:[^\d]+)(\d+):\d+');
          final match = regExp.firstMatch(line);

          if (match != null) {
            return _TraceInfo(file: match.group(1)!, line: match.group(2)!);
          }
        }
      }
    } catch (e) {
      return _TraceInfo(file: 'unknown_file', line: '0');
    }

    return _TraceInfo(file: 'unknown_file', line: '0');
  }
}

class _TraceInfo {
  final String file;
  final String line;
  _TraceInfo({required this.file, required this.line});
}
