import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class SettingsService {
  static const String _settingsKey = 'app_settings';
  static SettingsService? _instance;
  SharedPreferences? _prefs;

  SettingsService._();

  static Future<SettingsService> getInstance() async {
    _instance ??= SettingsService._();
    _instance!._prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<AppSettings> loadSettings() async {
    final String? settingsJson = _prefs?.getString(_settingsKey);
    if (settingsJson != null) {
      return AppSettings.fromJson(json.decode(settingsJson));
    }
    return AppSettings();
  }

  Future<bool> saveSettings(AppSettings settings) async {
    final String settingsJson = json.encode(settings.toJson());
    return await _prefs?.setString(_settingsKey, settingsJson) ?? false;
  }

  Future<bool> incrementFilteredCount() async {
    final settings = await loadSettings();
    settings.filteredCount++;
    return await saveSettings(settings);
  }

  Future<bool> resetFilteredCount() async {
    final settings = await loadSettings();
    settings.filteredCount = 0;
    return await saveSettings(settings);
  }
}
