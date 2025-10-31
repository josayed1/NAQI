import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

class NSFWDetector {
  static bool _isInitialized = false;

  static const String modelPath = 'assets/models/nsfw_model.tflite';
  static const int inputSize = 224;

  /// Initialize the TensorFlow Lite interpreter
  static Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      if (kDebugMode) {
        debugPrint('🔄 Initializing NSFW Detector...');
        debugPrint('⚠️  TensorFlow Lite is disabled in this build');
        debugPrint('⚠️  To enable: Add tflite_flutter package and model file');
      }

      _isInitialized = true;
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to initialize NSFW Detector: $e');
      }
      return false;
    }
  }

  /// Detect NSFW content in image bytes
  static Future<NSFWResult> detectFromBytes(Uint8List imageBytes) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      if (kDebugMode) {
        debugPrint('📊 NSFW Detection: Model not available (demo mode)');
      }

      // Return safe result in demo mode
      return NSFWResult(
        isNSFW: false,
        confidence: 0.0,
        safeScore: 1.0,
        nsfwScore: 0.0,
        error: 'TensorFlow Lite model not available. Add model to enable detection.',
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Detection error: $e');
      }
      return NSFWResult(isNSFW: false, confidence: 0.0, error: e.toString());
    }
  }

  /// Clean up resources
  static void dispose() {
    _isInitialized = false;
  }
}

class NSFWResult {
  final bool isNSFW;
  final double confidence;
  final double? safeScore;
  final double? nsfwScore;
  final String? error;

  NSFWResult({
    required this.isNSFW,
    required this.confidence,
    this.safeScore,
    this.nsfwScore,
    this.error,
  });

  bool shouldFilter(double threshold) {
    if (error != null) return false;
    return isNSFW && confidence > threshold;
  }
}
