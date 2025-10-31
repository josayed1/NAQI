import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';
import 'settings_service.dart';
import 'screen_monitor_service.dart';

class AppProvider with ChangeNotifier {
  AppSettings _settings = AppSettings();
  bool _isLoading = true;
  final SettingsService _settingsService;

  AppProvider(this._settingsService) {
    _loadSettings();
  }

  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;
  bool get isFilterEnabled => _settings.isFilterEnabled;
  double get sensitivity => _settings.sensitivity;
  int get filteredCount => _settings.filteredCount;
  bool get silentMode => _settings.silentMode;
  bool get parentMode => _settings.parentMode;
  String get language => _settings.language;

  Future<void> _loadSettings() async {
    _isLoading = true;
    notifyListeners();

    _settings = await _settingsService.loadSettings();
    
    // If filter was enabled, restart monitoring
    if (_settings.isFilterEnabled) {
      await ScreenMonitorService.startMonitoring();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFilter() async {
    _settings = _settings.copyWith(
      isFilterEnabled: !_settings.isFilterEnabled,
    );
    
    await _settingsService.saveSettings(_settings);
    
    if (_settings.isFilterEnabled) {
      final hasPermission = await ScreenMonitorService.requestScreenCapturePermission();
      if (hasPermission) {
        await ScreenMonitorService.startMonitoring();
      } else {
        _settings = _settings.copyWith(isFilterEnabled: false);
        await _settingsService.saveSettings(_settings);
      }
    } else {
      await ScreenMonitorService.stopMonitoring();
    }
    
    notifyListeners();
  }

  Future<void> setSensitivity(double value) async {
    _settings = _settings.copyWith(sensitivity: value);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> toggleSilentMode() async {
    _settings = _settings.copyWith(silentMode: !_settings.silentMode);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> setParentMode(bool enabled, String? pin) async {
    _settings = _settings.copyWith(
      parentMode: enabled,
      parentPin: pin,
    );
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  bool verifyParentPin(String pin) {
    return _settings.parentPin == pin;
  }

  Future<void> setLanguage(String lang) async {
    _settings = _settings.copyWith(language: lang);
    await _settingsService.saveSettings(_settings);
    notifyListeners();
  }

  Future<void> resetFilteredCount() async {
    await _settingsService.resetFilteredCount();
    _settings = _settings.copyWith(filteredCount: 0);
    notifyListeners();
  }

  Future<void> incrementFilteredCount() async {
    await _settingsService.incrementFilteredCount();
    _settings = _settings.copyWith(
      filteredCount: _settings.filteredCount + 1,
    );
    notifyListeners();
  }
}
