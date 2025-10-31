import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class NSFWDetector {
  static Interpreter? _interpreter;
  static bool _isInitialized = false;

  static const String modelPath = 'assets/models/nsfw_model.tflite';
  static const int inputSize = 224;

  /// Initialize the TensorFlow Lite interpreter
  static Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      if (kDebugMode) {
        debugPrint('🔄 Initializing NSFW Detector...');
      }

      _interpreter = await Interpreter.fromAsset(modelPath);
      _isInitialized = true;

      if (kDebugMode) {
        debugPrint('✅ NSFW Detector initialized successfully');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Failed to initialize NSFW Detector: $e');
        debugPrint('⚠️ Please add nsfw_model.tflite to assets/models/');
      }
      return false;
    }
  }

  /// Detect NSFW content in image bytes
  static Future<NSFWResult> detectFromBytes(Uint8List imageBytes) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_interpreter == null) {
      return NSFWResult(isNSFW: false, confidence: 0.0, error: 'Model not loaded');
    }

    try {
      // Decode image
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) {
        return NSFWResult(isNSFW: false, confidence: 0.0, error: 'Failed to decode image');
      }

      // Resize to model input size
      img.Image resized = img.copyResize(image, width: inputSize, height: inputSize);

      // Convert to float32 input [1, 224, 224, 3]
      var input = _imageToByteListFloat32(resized);

      // Prepare output buffer
      var output = List.generate(1, (_) => List.filled(2, 0.0));

      // Run inference
      _interpreter!.run(input, output);

      // Parse results
      // Assuming output format: [safe_score, nsfw_score]
      double safeScore = output[0][0];
      double nsfwScore = output[0][1];

      bool isNSFW = nsfwScore > safeScore;
      double confidence = isNSFW ? nsfwScore : safeScore;

      if (kDebugMode) {
        debugPrint('📊 Detection result: Safe=$safeScore, NSFW=$nsfwScore');
      }

      return NSFWResult(
        isNSFW: isNSFW,
        confidence: confidence,
        safeScore: safeScore,
        nsfwScore: nsfwScore,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Detection error: $e');
      }
      return NSFWResult(isNSFW: false, confidence: 0.0, error: e.toString());
    }
  }

  /// Convert image to Float32 input for TensorFlow Lite
  static List<List<List<List<double>>>> _imageToByteListFloat32(img.Image image) {
    var input = List.generate(
      1,
      (_) => List.generate(
        inputSize,
        (_) => List.generate(
          inputSize,
          (_) => List.filled(3, 0.0),
        ),
      ),
    );

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        var pixel = image.getPixel(x, y);
        
        // Normalize to [0, 1]
        input[0][y][x][0] = pixel.r / 255.0;
        input[0][y][x][1] = pixel.g / 255.0;
        input[0][y][x][2] = pixel.b / 255.0;
      }
    }
    return input;
  }

  /// Clean up resources
  static void dispose() {
    _interpreter?.close();
    _interpreter = null;
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
