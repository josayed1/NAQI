class AppSettings {
  final bool isFilterEnabled;
  final double sensitivity;
  final bool quietMode;
  final bool autoStart;
  final String? parentPin;
  final int filteredCount;

  AppSettings({
    this.isFilterEnabled = false,
    this.sensitivity = 0.7,
    this.quietMode = false,
    this.autoStart = true,
    this.parentPin,
    this.filteredCount = 0,
  });

  AppSettings copyWith({
    bool? isFilterEnabled,
    double? sensitivity,
    bool? quietMode,
    bool? autoStart,
    String? parentPin,
    int? filteredCount,
  }) {
    return AppSettings(
      isFilterEnabled: isFilterEnabled ?? this.isFilterEnabled,
      sensitivity: sensitivity ?? this.sensitivity,
      quietMode: quietMode ?? this.quietMode,
      autoStart: autoStart ?? this.autoStart,
      parentPin: parentPin ?? this.parentPin,
      filteredCount: filteredCount ?? this.filteredCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isFilterEnabled': isFilterEnabled,
      'sensitivity': sensitivity,
      'quietMode': quietMode,
      'autoStart': autoStart,
      'parentPin': parentPin,
      'filteredCount': filteredCount,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isFilterEnabled: json['isFilterEnabled'] as bool? ?? false,
      sensitivity: (json['sensitivity'] as num?)?.toDouble() ?? 0.7,
      quietMode: json['quietMode'] as bool? ?? false,
      autoStart: json['autoStart'] as bool? ?? true,
      parentPin: json['parentPin'] as String?,
      filteredCount: json['filteredCount'] as int? ?? 0,
    );
  }
}
