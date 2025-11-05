class AppSettings {
  bool isFilterEnabled;
  double sensitivity; // 0.0 to 1.0
  int filteredCount;
  bool quietMode;
  bool parentModeEnabled;
  String? parentPin;
  bool autoStartOnBoot;
  
  AppSettings({
    this.isFilterEnabled = false,
    this.sensitivity = 0.7,
    this.filteredCount = 0,
    this.quietMode = false,
    this.parentModeEnabled = false,
    this.parentPin,
    this.autoStartOnBoot = false,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'isFilterEnabled': isFilterEnabled,
      'sensitivity': sensitivity,
      'filteredCount': filteredCount,
      'quietMode': quietMode,
      'parentModeEnabled': parentModeEnabled,
      'parentPin': parentPin,
      'autoStartOnBoot': autoStartOnBoot,
    };
  }
  
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isFilterEnabled: json['isFilterEnabled'] ?? false,
      sensitivity: json['sensitivity'] ?? 0.7,
      filteredCount: json['filteredCount'] ?? 0,
      quietMode: json['quietMode'] ?? false,
      parentModeEnabled: json['parentModeEnabled'] ?? false,
      parentPin: json['parentPin'],
      autoStartOnBoot: json['autoStartOnBoot'] ?? false,
    );
  }
}
