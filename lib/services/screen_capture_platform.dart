import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class ScreenCapturePlatform {
  static const MethodChannel _channel = MethodChannel('com.naqi.app/screen_capture');

  /// Request screen capture permission from the system
  static Future<bool> requestPermission() async {
    try {
      final bool result = await _channel.invokeMethod('requestScreenCapturePermission');
      if (kDebugMode) {
        debugPrint('📱 Screen capture permission: $result');
      }
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to request screen capture permission: ${e.message}');
      }
      return false;
    }
  }

  /// Start screen capture service
  static Future<bool> startCapture() async {
    try {
      final bool result = await _channel.invokeMethod('startScreenCapture');
      if (kDebugMode) {
        debugPrint('📱 Screen capture started: $result');
      }
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to start screen capture: ${e.message}');
      }
      return false;
    }
  }

  /// Stop screen capture service
  static Future<bool> stopCapture() async {
    try {
      final bool result = await _channel.invokeMethod('stopScreenCapture');
      if (kDebugMode) {
        debugPrint('📱 Screen capture stopped: $result');
      }
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to stop screen capture: ${e.message}');
      }
      return false;
    }
  }
}
