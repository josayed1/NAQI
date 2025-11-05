import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 0)
class AppSettings extends HiveObject {
  @HiveField(0)
  bool isFilterEnabled;

  @HiveField(1)
  double sensitivity; // 0.0 to 1.0

  @HiveField(2)
  bool quietMode;

  @HiveField(3)
  bool parentModeEnabled;

  @HiveField(4)
  String? parentPin;

  @HiveField(5)
  int filteredScenesCount;

  @HiveField(6)
  bool autoStartOnBoot;

  AppSettings({
    this.isFilterEnabled = false,
    this.sensitivity = 0.7,
    this.quietMode = false,
    this.parentModeEnabled = false,
    this.parentPin,
    this.filteredScenesCount = 0,
    this.autoStartOnBoot = false,
  });

  AppSettings copyWith({
    bool? isFilterEnabled,
    double? sensitivity,
    bool? quietMode,
    bool? parentModeEnabled,
    String? parentPin,
    int? filteredScenesCount,
    bool? autoStartOnBoot,
  }) {
    return AppSettings(
      isFilterEnabled: isFilterEnabled ?? this.isFilterEnabled,
      sensitivity: sensitivity ?? this.sensitivity,
      quietMode: quietMode ?? this.quietMode,
      parentModeEnabled: parentModeEnabled ?? this.parentModeEnabled,
      parentPin: parentPin ?? this.parentPin,
      filteredScenesCount: filteredScenesCount ?? this.filteredScenesCount,
      autoStartOnBoot: autoStartOnBoot ?? this.autoStartOnBoot,
    );
  }
}
