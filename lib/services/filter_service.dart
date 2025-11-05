import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'settings_service.dart';
import '../models/detection_result.dart';

// NSFW Detection using heuristic analysis
class NSFWDetector {
  static final NSFWDetector _instance = NSFWDetector._internal();
  factory NSFWDetector() => _instance;
  NSFWDetector._internal();
  
  Future<void> initialize() async {
    if (kDebugMode) {
      debugPrint('✅ NSFW Detector initialized (heuristic mode)');
    }
  }
  
  Future<DetectionResult> detectFromImage(img.Image image, {List<TextDetection> textDetections = const []}) async {
    // Simple heuristic: analyze image color distribution
    // This is a placeholder - in production, you'd use actual ML models
    
    double skinToneRatio = _analyzeSkinTone(image);
    bool isNsfw = skinToneRatio > 0.4; // More than 40% skin tone
    
    bool containsTargetName = textDetections.any((detection) => 
      detection.containsName('يوسف') || detection.containsName('Youssef')
    );
    
    return DetectionResult(
      isNsfw: isNsfw,
      confidence: skinToneRatio,
      category: isNsfw ? 'sensitive' : 'neutral',
      textDetections: textDetections,
      containsTargetName: containsTargetName,
    );
  }
  
  double _analyzeSkinTone(img.Image image) {
    // Analyze skin tone pixels (simplified heuristic)
    int skinPixels = 0;
    int totalPixels = image.width * image.height;
    
    // Sample every 10th pixel for performance
    for (int y = 0; y < image.height; y += 10) {
      for (int x = 0; x < image.width; x += 10) {
        final pixel = image.getPixel(x, y);
        if (_isSkinTone(pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt())) {
          skinPixels++;
        }
      }
    }
    
    return skinPixels / (totalPixels / 100);
  }
  
  bool _isSkinTone(int r, int g, int b) {
    // Simplified skin tone detection
    return r > 95 && g > 40 && b > 20 &&
           r > g && r > b &&
           (r - g) > 15 &&
           (r - g).abs() > 15;
  }
  
  void dispose() {}
}

class TextDetectorService {
  static final TextDetectorService _instance = TextDetectorService._internal();
  factory TextDetectorService() => _instance;
  TextDetectorService._internal();
  
  Future<List<TextDetection>> detectText(String imagePath) async {
    return [];
  }
  void dispose() {}
}

class BlurProcessor {
  static final BlurProcessor _instance = BlurProcessor._internal();
  factory BlurProcessor() => _instance;
  BlurProcessor._internal();
  
  Future<File?> processImageFile(String inputPath, DetectionResult detection, {double sensitivity = 0.7}) async {
    // Apply blur using image package
    final bytes = await File(inputPath).readAsBytes();
    final image = img.decodeImage(bytes);
    
    if (image == null) return null;
    
    if (detection.shouldBlur()) {
      final blurred = img.gaussianBlur(image, radius: 15);
      final tempDir = Directory.systemTemp;
      final outputPath = '${tempDir.path}/naqi_blurred_${DateTime.now().millisecondsSinceEpoch}.png';
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(blurred));
      return outputFile;
    }
    
    return null;
  }
}

class FilterService extends ChangeNotifier {
  final NSFWDetector _nsfwDetector = NSFWDetector();
  final TextDetectorService _textDetector = TextDetectorService();
  final BlurProcessor _blurProcessor = BlurProcessor();
  final SettingsService _settingsService = SettingsService();
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _isProcessing = false;
  
  bool get isInitialized => _isInitialized;
  bool get isProcessing => _isProcessing;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize services
      await _settingsService.initialize();
      await _nsfwDetector.initialize();
      
      // Initialize notifications
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initSettings = InitializationSettings(android: androidSettings);
      await _notifications.initialize(initSettings);
      
      // Create notification channel
      const androidChannel = AndroidNotificationChannel(
        'naqi_filter_channel',
        'Naqi Protection Service',
        description: 'Content filtering and protection notifications',
        importance: Importance.low,
      );
      
      await _notifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
      
      _isInitialized = true;
      notifyListeners();
      
      if (kDebugMode) {
        debugPrint('✅ Filter Service initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Filter Service initialization failed: $e');
      }
      rethrow;
    }
  }

  /// Process image file and apply filtering
  Future<File?> processImageFile(String imagePath) async {
    if (!_isInitialized) {
      await initialize();
    }

    final settings = _settingsService.getSettings();
    if (!settings.isFilterEnabled) {
      return null; // Filtering disabled
    }

    _isProcessing = true;
    notifyListeners();

    try {
      // 1. Detect text
      final textDetections = await _textDetector.detectText(imagePath);
      
      // 2. Read image
      final bytes = await File(imagePath).readAsBytes();
      final image = img.decodeImage(bytes);
      
      if (image == null) {
        throw Exception('Failed to decode image');
      }
      
      // 3. Detect NSFW content
      final detection = await _nsfwDetector.detectFromImage(
        image,
        textDetections: textDetections,
      );
      
      // 4. Process if needed
      if (detection.shouldBlur()) {
        final processedFile = await _blurProcessor.processImageFile(
          imagePath,
          detection,
          sensitivity: settings.sensitivity,
        );
        
        // Increment counter
        await _settingsService.incrementFilterCount();
        
        // Show notification
        if (!settings.quietMode) {
          await _showFilterNotification(detection);
        }
        
        _isProcessing = false;
        notifyListeners();
        
        return processedFile;
      }
      
      _isProcessing = false;
      notifyListeners();
      
      return null; // No filtering needed
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Image processing error: $e');
      }
      
      _isProcessing = false;
      notifyListeners();
      
      return null;
    }
  }

  Future<void> _showFilterNotification(DetectionResult detection) async {
    String title = 'تم تنظيف الشاشة';
    String body = 'Naqi Active 🌿';
    
    if (detection.isNsfw) {
      body = 'محتوى حساس تم تصفيته';
    } else if (detection.containsTargetName) {
      body = 'تم طمس النص المستهدف';
    }
    
    const androidDetails = AndroidNotificationDetails(
      'naqi_filter_channel',
      'Naqi Protection Service',
      channelDescription: 'Content filtering notifications',
      importance: Importance.low,
      priority: Priority.low,
      icon: '@mipmap/ic_launcher',
    );
    
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      title,
      body,
      notificationDetails,
    );
  }

  @override
  void dispose() {
    _nsfwDetector.dispose();
    _textDetector.dispose();
    super.dispose();
  }
}
