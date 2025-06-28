import 'package:flutter/foundation.dart';

class AppLogger {
  static void info(String message) {
    if (kDebugMode) {
      debugPrint("ℹ️ INFO: $message");
    }
  }

  static void warn(String message) {
    if (kDebugMode) {
      debugPrint("⚠️ WARNING: $message");
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint("❌ ERROR: $message");
      if (error != null) debugPrint("🧩 Exception: $error");
      if (stackTrace != null) debugPrint("📌 StackTrace: $stackTrace");
    }
  }

  static void debug(String message) {
    if (kDebugMode) {
      debugPrint("🐞 DEBUG: $message");
    }
  }
}
