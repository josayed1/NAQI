import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SensitivityLevel {
  low,
  medium,
  high,
}

class AppState extends ChangeNotifier {
  bool _isFilterActive = false;
  bool _quietMode = false;
  SensitivityLevel _sensitivity = SensitivityLevel.medium;
  int _filteredCount = 0;
  String? _parentalPin;
  bool _isParentalLocked = false;

  bool get isFilterActive => _isFilterActive;
  bool get quietMode => _quietMode;
  SensitivityLevel get sensitivity => _sensitivity;
  int get filteredCount => _filteredCount;
  String? get parentalPin => _parentalPin;
  bool get isParentalLocked => _isParentalLocked;

  double get sensitivityThreshold {
    switch (_sensitivity) {
      case SensitivityLevel.low:
        return 0.8; // Only very explicit content
      case SensitivityLevel.medium:
        return 0.6; // Moderate filtering
      case SensitivityLevel.high:
        return 0.4; // More aggressive filtering
    }
  }

  AppState() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isFilterActive = prefs.getBool('isFilterActive') ?? false;
    _quietMode = prefs.getBool('quietMode') ?? false;
    _filteredCount = prefs.getInt('filteredCount') ?? 0;
    _parentalPin = prefs.getString('parentalPin');
    _isParentalLocked = prefs.getBool('isParentalLocked') ?? false;
    
    final sensitivityIndex = prefs.getInt('sensitivity') ?? 1;
    _sensitivity = SensitivityLevel.values[sensitivityIndex];
    
    notifyListeners();
  }

  Future<void> toggleFilter() async {
    _isFilterActive = !_isFilterActive;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFilterActive', _isFilterActive);
    notifyListeners();
  }

  Future<void> setQuietMode(bool value) async {
    _quietMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quietMode', value);
    notifyListeners();
  }

  Future<void> setSensitivity(SensitivityLevel level) async {
    _sensitivity = level;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sensitivity', level.index);
    notifyListeners();
  }

  Future<void> incrementFilteredCount() async {
    _filteredCount++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('filteredCount', _filteredCount);
    notifyListeners();
  }

  Future<void> setParentalPin(String pin) async {
    _parentalPin = pin;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('parentalPin', pin);
    notifyListeners();
  }

  Future<void> toggleParentalLock(bool locked) async {
    _isParentalLocked = locked;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isParentalLocked', locked);
    notifyListeners();
  }

  bool verifyPin(String pin) {
    return _parentalPin == pin;
  }
}
