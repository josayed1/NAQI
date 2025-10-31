import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

class FilterService {
  static const MethodChannel _channel = MethodChannel('naqi/filter');
  
  bool _isInitialized = false;
  bool _isMonitoring = false;
  Timer? _monitoringTimer;
  
  // Simulated NSFW detection (In production, use actual TFLite model)
  Future<void> initialize() async {
    try {
      // Initialize native platform channel
      await _channel.invokeMethod('initialize');
      _isInitialized = true;
    } catch (e) {
      if (kDebugMode) debugPrint('Filter service initialization error: $e');
      _isInitialized = true; // Continue anyway for demo
    }
  }
  
  Future<bool> startMonitoring() async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      // Request screen capture permission
      final bool? granted = await _channel.invokeMethod('requestPermission');
      
      if (granted == true) {
        _isMonitoring = true;
        _startPeriodicScreenCapture();
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) debugPrint('Start monitoring error: $e');
      // Fallback: start demo mode
      _isMonitoring = true;
      _startDemoMode();
      return true;
    }
  }
  
  Future<void> stopMonitoring() async {
    _isMonitoring = false;
    _monitoringTimer?.cancel();
    
    try {
      await _channel.invokeMethod('stopMonitoring');
    } catch (e) {
      if (kDebugMode) debugPrint('Stop monitoring error: $e');
    }
  }
  
  void _startPeriodicScreenCapture() {
    _monitoringTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      if (!_isMonitoring) {
        timer.cancel();
        return;
      }
      
      try {
        // Capture screen
        final Uint8List? screenshot = await _channel.invokeMethod('captureScreen');
        
        if (screenshot != null) {
          // Analyze screenshot
          final result = await _analyzeImage(screenshot);
          
          if (result.isNSFW) {
            // Apply blur to detected regions
            await _applyBlur(result.detectedRegions);
          }
        }
      } catch (e) {
        if (kDebugMode) debugPrint('Screen capture error: $e');
      }
    });
  }
  
  void _startDemoMode() {
    // Demo mode: simulate random detection for testing
    _monitoringTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!_isMonitoring) {
        timer.cancel();
        return;
      }
      
      // Random detection simulation (10% chance)
      if (math.Random().nextDouble() < 0.1) {
        if (kDebugMode) debugPrint('🌿 Demo: NSFW content detected (simulated)');
      }
    });
  }
  
  Future<DetectionResult> _analyzeImage(Uint8List imageData) async {
    // Decode image
    final image = img.decodeImage(imageData);
    if (image == null) {
      return DetectionResult(isNSFW: false, confidence: 0.0, detectedRegions: []);
    }
    
    // Simulated NSFW detection logic
    // In production, use actual TFLite model inference here
    
    // For demo: Detect based on skin tone pixels (simplified)
    int skinPixels = 0;
    int totalPixels = image.width * image.height;
    
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        if (_isSkinTone(pixel)) {
          skinPixels++;
        }
      }
    }
    
    final double skinRatio = skinPixels / totalPixels;
    
    // If more than 30% skin tone, flag as potential NSFW
    final bool isNSFW = skinRatio > 0.3;
    
    List<DetectedRegion> regions = [];
    if (isNSFW) {
      // For demo: blur entire screen
      regions.add(DetectedRegion(
        x: 0,
        y: 0,
        width: image.width,
        height: image.height,
      ));
    }
    
    return DetectionResult(
      isNSFW: isNSFW,
      confidence: skinRatio,
      detectedRegions: regions,
    );
  }
  
  bool _isSkinTone(img.Pixel pixel) {
    final r = pixel.r.toInt();
    final g = pixel.g.toInt();
    final b = pixel.b.toInt();
    
    // Simple skin tone detection
    return (r > 95 && g > 40 && b > 20 &&
        r > g && r > b &&
        (r - g).abs() > 15);
  }
  
  Future<void> _applyBlur(List<DetectedRegion> regions) async {
    try {
      for (final region in regions) {
        await _channel.invokeMethod('applyBlur', {
          'x': region.x,
          'y': region.y,
          'width': region.width,
          'height': region.height,
        });
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Apply blur error: $e');
    }
  }
  
  bool get isMonitoring => _isMonitoring;
}

class DetectionResult {
  final bool isNSFW;
  final double confidence;
  final List<DetectedRegion> detectedRegions;
  
  DetectionResult({
    required this.isNSFW,
    required this.confidence,
    required this.detectedRegions,
  });
}

class DetectedRegion {
  final int x;
  final int y;
  final int width;
  final int height;
  
  DetectedRegion({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}
