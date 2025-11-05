import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import '../services/settings_service.dart';
import '../services/screen_capture_service.dart';

class AppState extends ChangeNotifier {
  final SettingsService _settingsService = SettingsService();
  final ScreenCaptureService _screenCaptureService = ScreenCaptureService();
  
  AppSettings _settings = AppSettings();
  bool _isLoading = true;

  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;
  bool get isServiceRunning => _screenCaptureService.isRunning;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    await _settingsService.initialize();
    _settings = await _settingsService.loadSettings();

    // Setup callbacks
    _screenCaptureService.onFilteredCountUpdate = (count) {
      _settings.filteredCount = count;
      _saveSettings();
    };

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFilter(bool enabled) async {
    _settings.isFilterEnabled = enabled;
    
    if (enabled) {
      await _startService();
    } else {
      await _stopService();
    }
    
    await _saveSettings();
    notifyListeners();
  }

  Future<void> _startService() async {
    try {
      await _screenCaptureService.startService(
        sensitivity: _settings.sensitivity,
        quietMode: _settings.quietMode,
      );
    } catch (e) {
      _settings.isFilterEnabled = false;
      rethrow;
    }
  }

  Future<void> _stopService() async {
    await _screenCaptureService.stopService();
  }

  Future<void> updateSensitivity(double value) async {
    _settings.sensitivity = value;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> toggleQuietMode(bool enabled) async {
    _settings.quietMode = enabled;
    await _saveSettings();
    notifyListeners();
    
    // Restart service if running to apply quiet mode
    if (_settings.isFilterEnabled) {
      await _stopService();
      await _startService();
    }
  }

  Future<void> toggleParentMode(bool enabled, String? pin) async {
    _settings.parentModeEnabled = enabled;
    _settings.parentPin = pin;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> resetFilterCount() async {
    _settings.filteredCount = 0;
    _screenCaptureService.resetCount();
    await _saveSettings();
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    await _settingsService.saveSettings(_settings);
  }

  bool verifyParentPin(String pin) {
    return _settings.parentPin == pin;
  }

  @override
  void dispose() {
    _screenCaptureService.dispose();
    super.dispose();
  }
}
