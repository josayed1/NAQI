import 'dart:typed_data';
import 'package:image/image.dart' as img;
import '../models/detection_result.dart';

class NSFWDetector {
  static final NSFWDetector _instance = NSFWDetector._internal();
  factory NSFWDetector() => _instance;
  NSFWDetector._internal();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // Using heuristic-based detection instead of TFLite
    // This provides immediate functionality without model dependencies
    _isInitialized = true;
  }

  Future<DetectionResult> detectNSFW(Uint8List imageBytes, double threshold) async {
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
    // Simplified skin tone detection using RGB values
    // Based on research: skin tones have R>95, G>40, B>20
    // and R>G, R>B, with certain differences
    return r > 95 && g > 40 && b > 20 &&
           r > g && r > b &&
           (r - g).abs() > 15 &&
           r - b > 15;
  }

  List<BoundingBox> _generateMockRegions(int width, int height) {
    // Generate bounding boxes for detected regions
    // In production with real model, this would come from object detection
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
    _isInitialized = false;
  }
}
