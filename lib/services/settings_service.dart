import 'package:hive_flutter/hive_flutter.dart';
import '../models/app_settings.dart';

class SettingsService {
  static const String _boxName = 'settings';
  static final SettingsService _instance = SettingsService._internal();
  
  Box<AppSettings>? _box;
  
  factory SettingsService() => _instance;
  SettingsService._internal();

  Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapter if not already registered
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AppSettingsAdapter());
    }
    
    _box = await Hive.openBox<AppSettings>(_boxName);
    
    // Initialize default settings if empty
    if (_box!.isEmpty) {
      await _box!.put('default', AppSettings());
    }
  }

  AppSettings getSettings() {
    return _box?.get('default') ?? AppSettings();
  }

  Future<void> updateSettings(AppSettings settings) async {
    await _box?.put('default', settings);
  }

  Future<void> toggleFilter(bool enabled) async {
    final current = getSettings();
    await updateSettings(current.copyWith(isFilterEnabled: enabled));
  }

  Future<void> setSensitivity(double value) async {
    final current = getSettings();
    await updateSettings(current.copyWith(sensitivity: value));
  }

  Future<void> toggleQuietMode(bool enabled) async {
    final current = getSettings();
    await updateSettings(current.copyWith(quietMode: enabled));
  }

  Future<void> setParentMode(bool enabled, String? pin) async {
    final current = getSettings();
    await updateSettings(current.copyWith(
      parentModeEnabled: enabled,
      parentPin: pin,
    ));
  }

  Future<void> incrementFilterCount() async {
    final current = getSettings();
    await updateSettings(current.copyWith(
      filteredScenesCount: current.filteredScenesCount + 1,
    ));
  }

  bool verifyParentPin(String pin) {
    final settings = getSettings();
    return settings.parentPin == pin;
  }

  Future<void> resetFilterCount() async {
    final current = getSettings();
    await updateSettings(current.copyWith(filteredScenesCount: 0));
  }

  Future<void> setAutoStart(bool enabled) async {
    final current = getSettings();
    await updateSettings(current.copyWith(autoStartOnBoot: enabled));
  }
}
