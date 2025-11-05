import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class NSFWDetectionService {
  static final NSFWDetectionService _instance = NSFWDetectionService._internal();
  factory NSFWDetectionService() => _instance;
  NSFWDetectionService._internal();

  Interpreter? _interpreter;
  bool _isInitialized = false;
  
  final List<String> _labels = [
    'drawing',
    'hentai',
    'neutral',
    'porn',
    'sexy',
  ];

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Load the TFLite model
      _interpreter = await Interpreter.fromAsset('assets/models/nsfw_mobilenet_v2.tflite');
      _isInitialized = true;
      if (kDebugMode) {
        debugPrint('✅ NSFW Detection Service initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error initializing NSFW Detection Service: $e');
      }
      rethrow;
    }
  }

  Future<Map<String, double>> detectNSFW(Uint8List imageBytes) async {
    if (!_isInitialized || _interpreter == null) {
      await initialize();
    }

    try {
      // Decode image
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) {
        throw Exception('Failed to decode image');
      }

      // Resize to 224x224 (model input size)
      img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

      // Prepare input tensor (normalize to 0-1)
      var input = List.generate(
        1,
        (i) => List.generate(
          224,
          (y) => List.generate(
            224,
            (x) => List.generate(3, (c) {
              final pixel = resizedImage.getPixel(x, y);
              if (c == 0) return pixel.r / 255.0;
              if (c == 1) return pixel.g / 255.0;
              return pixel.b / 255.0;
            }),
          ),
        ),
      );

      // Prepare output tensor
      var output = List.filled(1, List.filled(5, 0.0)).map((e) => List<double>.filled(5, 0.0)).toList();

      // Run inference
      _interpreter!.run(input, output);

      // Parse results
      Map<String, double> results = {};
      for (int i = 0; i < _labels.length; i++) {
        results[_labels[i]] = output[0][i];
      }

      return results;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error during NSFW detection: $e');
      }
      rethrow;
    }
  }

  bool isNSFW(Map<String, double> results, double threshold) {
    double nsfwScore = (results['porn'] ?? 0.0) + 
                       (results['hentai'] ?? 0.0) + 
                       (results['sexy'] ?? 0.0);
    return nsfwScore > threshold;
  }

  String getDominantCategory(Map<String, double> results) {
    String dominant = 'neutral';
    double maxScore = 0.0;
    
    results.forEach((category, score) {
      if (score > maxScore) {
        maxScore = score;
        dominant = category;
      }
    });
    
    return dominant;
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _isInitialized = false;
  }
}
