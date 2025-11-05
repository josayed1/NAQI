import 'dart:async';
import 'dart:typed_data';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:permission_handler/permission_handler.dart';
import 'nsfw_detector.dart';
import 'text_detector.dart';
import 'image_processor.dart';
import '../models/detection_result.dart';

class ScreenCaptureService {
  static final ScreenCaptureService _instance = ScreenCaptureService._internal();
  factory ScreenCaptureService() => _instance;
  ScreenCaptureService._internal();

  bool _isRunning = false;
  Timer? _captureTimer;
  
  final NSFWDetector _nsfwDetector = NSFWDetector();
  final TextDetector _textDetector = TextDetector();
  final ImageProcessor _imageProcessor = ImageProcessor();

  int _filteredCount = 0;
  
  Function(int)? onFilteredCountUpdate;
  Function(Uint8List)? onProcessedFrame;

  bool get isRunning => _isRunning;
  int get filteredCount => _filteredCount;

  Future<bool> checkPermissions() async {
    // Check notification permission
    final notification = await Permission.notification.status;
    
    return notification.isGranted;
  }

  Future<bool> requestPermissions() async {
    // Request notification permission
    final notification = await Permission.notification.request();
    
    return notification.isGranted;
  }

  Future<void> startService({
    required double sensitivity,
    required bool quietMode,
  }) async {
    if (_isRunning) return;

    // Check and request permissions
    final hasPermissions = await checkPermissions();
    if (!hasPermissions) {
      final granted = await requestPermissions();
      if (!granted) {
        throw Exception('Required permissions not granted');
      }
    }

    // Initialize detectors
    await _nsfwDetector.initialize();

    // Initialize foreground task
    await _initForegroundTask(quietMode);

    // Start the foreground service
    final ServiceRequestResult result = await FlutterForegroundTask.startService(
      serviceId: 256,
      notificationTitle: quietMode ? '' : 'تم تنظيف الشاشة',
      notificationText: quietMode ? '' : 'Naqi Active 🌿',
      callback: startCallback,
    );

    if (result == ServiceRequestResult.success) {
      _isRunning = true;
      
      // Start periodic screen capture and processing
      _startPeriodicCapture(sensitivity);
    }
  }

  Future<void> _initForegroundTask(bool quietMode) async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'naqi_service',
        channelName: 'Naqi Screen Filter',
        channelDescription: 'Content filtering service',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        showWhen: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: false,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void startCallback() {
    FlutterForegroundTask.setTaskHandler(ScreenCaptureTaskHandler());
  }

  void _startPeriodicCapture(double sensitivity) {
    // Capture and process frames every 2 seconds
    _captureTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) async {
        await _captureAndProcess(sensitivity);
      },
    );
  }

  Future<void> _captureAndProcess(double sensitivity) async {
    try {
      // Note: Actual screen capture requires MediaProjection API
      // which needs platform-specific implementation
      // For now, we'll create a placeholder
      
      // In production, you would:
      // 1. Use MediaProjection API to capture screen
      // 2. Convert captured bitmap to Uint8List
      // 3. Process the image
      
      // Placeholder: Create a test image
      // In real implementation, this would be the actual screen capture
      final Uint8List? screenCapture = await _captureScreen();
      
      if (screenCapture != null) {
        // Detect NSFW content
        final nsfwResult = await _nsfwDetector.detectNSFW(
          screenCapture,
          sensitivity,
        );

        // Detect target text (يوسف)
        final textRegions = await _textDetector.detectTargetText(screenCapture);

        // Combine results
        final detectionResult = DetectionResult(
          isNsfw: nsfwResult.isNsfw,
          confidence: nsfwResult.confidence,
          sensitiveRegions: nsfwResult.sensitiveRegions,
          hasTargetText: textRegions.isNotEmpty,
          textRegions: textRegions,
        );

        // Apply blur if needed
        if (detectionResult.isNsfw || detectionResult.hasTargetText) {
          final processedImage = _imageProcessor.applyBlur(
            screenCapture,
            detectionResult,
            15, // Blur intensity
          );

          _filteredCount++;
          onFilteredCountUpdate?.call(_filteredCount);
          onProcessedFrame?.call(processedImage);

          // Update notification
          await _updateNotification();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error in capture and process: $e');
      }
    }
  }

  Future<Uint8List?> _captureScreen() async {
    // Platform-specific screen capture implementation
    // This requires native Android code using MediaProjection API
    
    // For now, return null (would be implemented in native code)
    return null;
  }

  Future<void> _updateNotification() async {
    await FlutterForegroundTask.updateService(
      notificationTitle: 'تم تنظيف الشاشة',
      notificationText: 'Naqi Active 🌿 | Filtered: $_filteredCount',
    );
  }

  Future<void> stopService() async {
    if (!_isRunning) return;

    _captureTimer?.cancel();
    _captureTimer = null;

    await FlutterForegroundTask.stopService();

    _isRunning = false;
  }

  void resetCount() {
    _filteredCount = 0;
  }

  void dispose() {
    _captureTimer?.cancel();
    _nsfwDetector.dispose();
    _textDetector.dispose();
  }
}

@pragma('vm:entry-point')
class ScreenCaptureTaskHandler extends TaskHandler {
  @override
  void onStart(DateTime timestamp) {
    // Task started
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // Periodic event
  }

  @override
  void onDestroy(DateTime timestamp) {
    // Task destroyed
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop') {
      FlutterForegroundTask.stopService();
    }
  }

  @override
  void onNotificationPressed() {
    // Notification pressed
    FlutterForegroundTask.launchApp('/');
  }
}
