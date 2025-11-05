import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import '../models/detection_result.dart';

class NSFWDetector {
  static final NSFWDetector _instance = NSFWDetector._internal();
  factory NSFWDetector() => _instance;
  NSFWDetector._internal();

  Interpreter? _interpreter;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Load the TFLite model
      // Note: In production, use a real NSFW detection model like NSFW_MobileNet
      final options = InterpreterOptions()..threads = 4;
      
      // Try to load the model from assets
      try {
        _interpreter = await Interpreter.fromAsset(
          'assets/models/nsfw_mobilenet.tflite',
          options: options,
        );
        _isInitialized = true;
      } catch (e) {
        // If model file doesn't exist or is invalid, create a mock detector
        // In production, you must provide a real TFLite model
        if (kDebugMode) {
          debugPrint('Warning: TFLite model not loaded. Using mock detector.');
          debugPrint('Download a real NSFW model from: https://github.com/GantMan/nsfw_model');
        }
        _isInitialized = false;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error initializing NSFW detector: $e');
      }
      _isInitialized = false;
    }
  }

  Future<DetectionResult> detectNSFW(Uint8List imageBytes, double threshold) async {
    if (!_isInitialized || _interpreter == null) {
      // Mock detection for demo purposes
      return _mockDetection(imageBytes, threshold);
    }

    try {
      // Decode image
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        return DetectionResult(
          isNsfw: false,
          confidence: 0.0,
          sensitiveRegions: [],
        );
      }

      // Resize to model input size (typically 224x224 for MobileNet)
      final resized = img.copyResize(image, width: 224, height: 224);

      // Convert to input tensor format (normalize to 0-1)
      final input = _imageToByteListFloat32(resized, 224);

      // Prepare output
      final output = List.filled(1 * 5, 0.0).reshape([1, 5]);
      // Output classes: [drawings, hentai, neutral, porn, sexy]

      // Run inference
      _interpreter!.run(input, output);

      // Parse results
      final scores = output[0] as List<double>;
      final nsfwScore = scores[3] + scores[4]; // porn + sexy
      final isNsfw = nsfwScore > threshold;

      // For body part detection, we would need a separate model
      // Using simple heuristics for now
      List<BoundingBox> regions = [];
      if (isNsfw) {
        // Mock bounding boxes for detected regions
        // In production, use a proper object detection model
        regions = _generateMockRegions(image.width, image.height);
      }

      return DetectionResult(
        isNsfw: isNsfw,
        confidence: nsfwScore,
        sensitiveRegions: regions,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error during NSFW detection: $e');
      }
      return _mockDetection(imageBytes, threshold);
    }
  }

  Uint8List _imageToByteListFloat32(img.Image image, int inputSize) {
    final convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    final buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y);
        final r = img.getRed(pixel);
        final g = img.getGreen(pixel);
        final b = img.getBlue(pixel);
        buffer[pixelIndex++] = r / 255.0;
        buffer[pixelIndex++] = g / 255.0;
        buffer[pixelIndex++] = b / 255.0;
      }
    }

    return convertedBytes.buffer.asUint8List();
  }

  DetectionResult _mockDetection(Uint8List imageBytes, double threshold) {
    // Simple heuristic-based detection for demo
    // Analyzes image properties to estimate NSFW probability
    
    try {
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        return DetectionResult(
          isNsfw: false,
          confidence: 0.0,
          sensitiveRegions: [],
        );
      }

      // Analyze skin tone pixels (simplified NSFW heuristic)
      double skinToneRatio = _analyzeSkinTone(image);
      
      // Simple threshold-based classification
      bool isNsfw = skinToneRatio > threshold;
      
      List<BoundingBox> regions = [];
      if (isNsfw) {
        regions = _generateMockRegions(image.width, image.height);
      }

      return DetectionResult(
        isNsfw: isNsfw,
        confidence: skinToneRatio,
        sensitiveRegions: regions,
      );
    } catch (e) {
      return DetectionResult(
        isNsfw: false,
        confidence: 0.0,
        sensitiveRegions: [],
      );
    }
  }

  double _analyzeSkinTone(img.Image image) {
    int skinPixels = 0;
    int totalPixels = 0;
    
    // Sample every 10th pixel for performance
    for (int y = 0; y < image.height; y += 10) {
      for (int x = 0; x < image.width; x += 10) {
        final pixel = image.getPixel(x, y);
        final r = img.getRed(pixel);
        final g = img.getGreen(pixel);
        final b = img.getBlue(pixel);
        
        // Simple skin tone detection
        if (_isSkinTone(r, g, b)) {
          skinPixels++;
        }
        totalPixels++;
      }
    }
    
    return totalPixels > 0 ? skinPixels / totalPixels : 0.0;
  }

  bool _isSkinTone(int r, int g, int b) {
    // Simplified skin tone detection
    return r > 95 && g > 40 && b > 20 &&
           r > g && r > b &&
           (r - g).abs() > 15 &&
           r - b > 15;
  }

  List<BoundingBox> _generateMockRegions(int width, int height) {
    // Generate mock bounding boxes for sensitive regions
    // In production, use a proper object detection model
    return [
      BoundingBox(
        x: width * 0.25,
        y: height * 0.3,
        width: width * 0.5,
        height: height * 0.4,
        confidence: 0.85,
      ),
    ];
  }

  void dispose() {
    _interpreter?.close();
    _isInitialized = false;
  }
}

// Debug print helper
bool get kDebugMode {
  bool debug = false;
  assert(() {
    debug = true;
    return true;
  }());
  return debug;
}

void debugPrint(String message) {
  if (kDebugMode) {
    print(message); // ignore: avoid_print
  }
}
