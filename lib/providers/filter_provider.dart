import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterProvider with ChangeNotifier {
  bool _isFilterActive = false;
  double _sensitivity = 0.7;
  int _filteredCount = 0;
  bool _quietMode = false;
  bool _parentalControlEnabled = false;
  String _parentalPin = '';
  
  bool get isFilterActive => _isFilterActive;
  double get sensitivity => _sensitivity;
  int get filteredCount => _filteredCount;
  bool get quietMode => _quietMode;
  bool get parentalControlEnabled => _parentalControlEnabled;
  String get parentalPin => _parentalPin;

  FilterProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isFilterActive = prefs.getBool('isFilterActive') ?? false;
    _sensitivity = prefs.getDouble('sensitivity') ?? 0.7;
    _filteredCount = prefs.getInt('filteredCount') ?? 0;
    _quietMode = prefs.getBool('quietMode') ?? false;
    _parentalControlEnabled = prefs.getBool('parentalControlEnabled') ?? false;
    _parentalPin = prefs.getString('parentalPin') ?? '';
    notifyListeners();
  }

  Future<void> toggleFilter() async {
    _isFilterActive = !_isFilterActive;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFilterActive', _isFilterActive);
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('Filter ${_isFilterActive ? "activated" : "deactivated"}');
    }
  }

  Future<void> setSensitivity(double value) async {
    _sensitivity = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sensitivity', _sensitivity);
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('Sensitivity set to: $value');
    }
  }

  void incrementFilteredCount() {
    _filteredCount++;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('filteredCount', _filteredCount);
    });
    notifyListeners();
  }

  Future<void> toggleQuietMode() async {
    _quietMode = !_quietMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quietMode', _quietMode);
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('Quiet mode ${_quietMode ? "enabled" : "disabled"}');
    }
  }

  Future<void> setParentalPin(String pin) async {
    _parentalPin = pin;
    _parentalControlEnabled = pin.isNotEmpty;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('parentalPin', _parentalPin);
    await prefs.setBool('parentalControlEnabled', _parentalControlEnabled);
    notifyListeners();
    
    if (kDebugMode) {
      debugPrint('Parental control ${_parentalControlEnabled ? "enabled" : "disabled"}');
    }
  }

  bool verifyParentalPin(String pin) {
    return _parentalPin == pin;
  }

  Future<void> resetFilteredCount() async {
    _filteredCount = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('filteredCount', _filteredCount);
    notifyListeners();
  }
}
