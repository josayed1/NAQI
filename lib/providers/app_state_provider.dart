import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isFilterActive = false;
  double _sensitivity = 0.7; // 0.0 to 1.0
  int _filteredCount = 0;
  bool _isQuietMode = false;
  bool _isParentalControlEnabled = false;
  String? _parentalPin;
  Locale _locale = const Locale('ar', '');
  
  // Getters
  bool get isFilterActive => _isFilterActive;
  double get sensitivity => _sensitivity;
  int get filteredCount => _filteredCount;
  bool get isQuietMode => _isQuietMode;
  bool get isParentalControlEnabled => _isParentalControlEnabled;
  String? get parentalPin => _parentalPin;
  Locale get locale => _locale;
  
  AppStateProvider() {
    _loadSettings();
  }
  
  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isFilterActive = prefs.getBool('isFilterActive') ?? false;
    _sensitivity = prefs.getDouble('sensitivity') ?? 0.7;
    _filteredCount = prefs.getInt('filteredCount') ?? 0;
    _isQuietMode = prefs.getBool('isQuietMode') ?? false;
    _isParentalControlEnabled = prefs.getBool('isParentalControlEnabled') ?? false;
    _parentalPin = prefs.getString('parentalPin');
    
    final languageCode = prefs.getString('languageCode') ?? 'ar';
    _locale = Locale(languageCode, '');
    
    notifyListeners();
  }
  
  // Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFilterActive', _isFilterActive);
    await prefs.setDouble('sensitivity', _sensitivity);
    await prefs.setInt('filteredCount', _filteredCount);
    await prefs.setBool('isQuietMode', _isQuietMode);
    await prefs.setBool('isParentalControlEnabled', _isParentalControlEnabled);
    if (_parentalPin != null) {
      await prefs.setString('parentalPin', _parentalPin!);
    }
    await prefs.setString('languageCode', _locale.languageCode);
  }
  
  // Toggle filter
  void toggleFilter() {
    _isFilterActive = !_isFilterActive;
    _saveSettings();
    notifyListeners();
  }
  
  // Update sensitivity
  void updateSensitivity(double value) {
    _sensitivity = value;
    _saveSettings();
    notifyListeners();
  }
  
  // Increment filtered count
  void incrementFilteredCount() {
    _filteredCount++;
    _saveSettings();
    notifyListeners();
  }
  
  // Reset filtered count
  void resetFilteredCount() {
    _filteredCount = 0;
    _saveSettings();
    notifyListeners();
  }
  
  // Toggle quiet mode
  void toggleQuietMode() {
    _isQuietMode = !_isQuietMode;
    _saveSettings();
    notifyListeners();
  }
  
  // Set parental control
  void setParentalControl(bool enabled, String? pin) {
    _isParentalControlEnabled = enabled;
    _parentalPin = pin;
    _saveSettings();
    notifyListeners();
  }
  
  // Verify parental PIN
  bool verifyParentalPin(String pin) {
    return _parentalPin == pin;
  }
  
  // Change language
  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode, '');
    _saveSettings();
    notifyListeners();
  }
}
