import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'settings_service.dart';

class ScreenMonitorService {
  static const platform = MethodChannel('com.naqi.app/screen_monitor');
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  
  static bool _isRunning = false;
  static Timer? _monitorTimer;

  static Future<void> initialize() async {
    // Initialize notifications
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await _notifications.initialize(initSettings);

    // Initialize background service
    final service = FlutterBackgroundService();
    await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: false,
      ),
    );
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    // Background service entry point
    if (kDebugMode) {
      debugPrint('🟢 Background service started');
    }

    service.on('stop').listen((event) {
      service.stopSelf();
      if (kDebugMode) {
        debugPrint('🔴 Background service stopped');
      }
    });

    // Monitor loop
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          // Check settings
          final settingsService = await SettingsService.getInstance();
          final settings = await settingsService.loadSettings();
          
          if (settings.isFilterEnabled) {
            // Capture and analyze screen
            await _captureAndAnalyzeScreen(settings.sensitivity);
          }
        }
      }
    });
  }

  static Future<void> startMonitoring() async {
    if (_isRunning) return;

    final service = FlutterBackgroundService();
    final isRunning = await service.isRunning();
    
    if (!isRunning) {
      await service.startService();
    }

    _isRunning = true;
    
    // Show foreground notification
    await _showForegroundNotification();
    
    if (kDebugMode) {
      debugPrint('✅ Screen monitoring started');
    }
  }

  static Future<void> stopMonitoring() async {
    if (!_isRunning) return;

    final service = FlutterBackgroundService();
    service.invoke('stop');
    
    _isRunning = false;
    _monitorTimer?.cancel();
    
    // Cancel notifications
    await _notifications.cancelAll();
    
    if (kDebugMode) {
      debugPrint('🛑 Screen monitoring stopped');
    }
  }

  static Future<void> _captureAndAnalyzeScreen(double sensitivity) async {
    try {
      // Request screen capture via platform channel
      final bool hasContent = await platform.invokeMethod('analyzeScreen', {
        'sensitivity': sensitivity,
      });

      if (hasContent) {
        // Increment counter
        final settingsService = await SettingsService.getInstance();
        await settingsService.incrementFilteredCount();
        
        // Show notification (if not in silent mode)
        final settings = await settingsService.loadSettings();
        if (!settings.silentMode) {
          await _showFilterNotification();
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to analyze screen: ${e.message}');
      }
    }
  }

  static Future<void> _showForegroundNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'naqi_service',
      'خدمة نقي',
      channelDescription: 'خدمة تنظيف المحتوى تعمل في الخلفية',
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      icon: '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(android: androidDetails);
    
    await _notifications.show(
      0,
      'نقي نشط 🌿',
      'حماية الشاشة مفعّلة',
      details,
    );
  }

  static Future<void> _showFilterNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'naqi_alerts',
      'تنبيهات نقي',
      channelDescription: 'إشعارات تنظيف المحتوى',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(android: androidDetails);
    
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'تم تنظيف الشاشة',
      'تم اكتشاف وتعتيم محتوى غير لائق',
      details,
    );
  }

  static Future<bool> requestScreenCapturePermission() async {
    try {
      final bool granted = await platform.invokeMethod('requestPermission');
      return granted;
    } on PlatformException {
      return false;
    }
  }

  static bool get isRunning => _isRunning;
}
