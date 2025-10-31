class AppSettings {
  bool isFilterEnabled;
  double sensitivity;
  int filteredCount;
  bool silentMode;
  bool parentMode;
  String? parentPin;
  String language;

  AppSettings({
    this.isFilterEnabled = false,
    this.sensitivity = 0.7,
    this.filteredCount = 0,
    this.silentMode = false,
    this.parentMode = false,
    this.parentPin,
    this.language = 'ar',
  });

  Map<String, dynamic> toJson() {
    return {
      'isFilterEnabled': isFilterEnabled,
      'sensitivity': sensitivity,
      'filteredCount': filteredCount,
      'silentMode': silentMode,
      'parentMode': parentMode,
      'parentPin': parentPin,
      'language': language,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isFilterEnabled: json['isFilterEnabled'] ?? false,
      sensitivity: (json['sensitivity'] ?? 0.7).toDouble(),
      filteredCount: json['filteredCount'] ?? 0,
      silentMode: json['silentMode'] ?? false,
      parentMode: json['parentMode'] ?? false,
      parentPin: json['parentPin'],
      language: json['language'] ?? 'ar',
    );
  }

  AppSettings copyWith({
    bool? isFilterEnabled,
    double? sensitivity,
    int? filteredCount,
    bool? silentMode,
    bool? parentMode,
    String? parentPin,
    String? language,
  }) {
    return AppSettings(
      isFilterEnabled: isFilterEnabled ?? this.isFilterEnabled,
      sensitivity: sensitivity ?? this.sensitivity,
      filteredCount: filteredCount ?? this.filteredCount,
      silentMode: silentMode ?? this.silentMode,
      parentMode: parentMode ?? this.parentMode,
      parentPin: parentPin ?? this.parentPin,
      language: language ?? this.language,
    );
  }
}
