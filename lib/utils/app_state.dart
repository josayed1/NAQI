import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../models/detection_result.dart';
import '../services/settings_service.dart';
import '../services/filter_service.dart';
import '../services/foreground_service.dart';

class AppState extends ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  final FilterService _filterService = FilterService();
  final NaqiForegroundService _foregroundService = NaqiForegroundService();

  AppSettings _settings = AppSettings();
  bool _isInitialized = false;
  DetectionResult? _lastDetection;

  AppSettings get settings => _settings;
  bool get isInitialized => _isInitialized;
  DetectionResult? get lastDetection => _lastDetection;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _settingsService.initialize();
      await _filterService.initialize();
      await _foregroundService.initForegroundTask();

      _settings = await _settingsService.getSettings();

      // Listen to detection stream
      _filterService.detectionStream.listen((detection) {
        _lastDetection = detection;
        notifyListeners();
      });

      _isInitialized = true;
      notifyListeners();

      if (kDebugMode) {
        debugPrint('✅ AppState initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ Error initializing AppState: $e');
      }
    }
  }

  Future<void> toggleFilter(bool enabled) async {
    _settings = _settings.copyWith(isFilterEnabled: enabled);
    await _settingsService.saveSettings(_settings);

    if (enabled) {
      await _foregroundService.startService();
    } else {
      await _foregroundService.stopService();
    }

    notifyListeners();
  }

  Future<void> updateSensitivity(double value) async {
    _settings = _settings.copyWith(sensitivity: value);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> toggleQuietMode(bool enabled) async {
    _settings = _settings.copyWith(quietMode: enabled);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> toggleAutoStart(bool enabled) async {
    _settings = _settings.copyWith(autoStart: enabled);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> setParentPin(String? pin) async {
    _settings = _settings.copyWith(parentPin: pin);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<bool> verifyParentPin(String pin) async {
    return await _settingsService.verifyParentPin(pin);
  }

  Future<void> resetFilteredCount() async {
    _settings = _settings.copyWith(filteredCount: 0);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> refreshSettings() async {
    _settings = await _settingsService.getSettings();
    notifyListeners();
  }
}
