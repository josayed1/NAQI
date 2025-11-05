import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();
  factory SettingsService() => _instance;
  SettingsService._internal();

  static const String _settingsKey = 'app_settings';
  
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<AppSettings> loadSettings() async {
    if (_prefs == null) await initialize();
    
    final jsonString = _prefs!.getString(_settingsKey);
    if (jsonString == null) {
      return AppSettings();
    }
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppSettings.fromJson(json);
    } catch (e) {
      return AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    if (_prefs == null) await initialize();
    
    final jsonString = jsonEncode(settings.toJson());
    await _prefs!.setString(_settingsKey, jsonString);
  }

  Future<void> clearSettings() async {
    if (_prefs == null) await initialize();
    await _prefs!.remove(_settingsKey);
  }
}
