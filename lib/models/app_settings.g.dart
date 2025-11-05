// GENERATED CODE - Hive TypeAdapter for AppSettings

part of 'app_settings.dart';

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 0;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      isFilterEnabled: fields[0] as bool? ?? false,
      sensitivity: fields[1] as double? ?? 0.7,
      quietMode: fields[2] as bool? ?? false,
      parentModeEnabled: fields[3] as bool? ?? false,
      parentPin: fields[4] as String?,
      filteredScenesCount: fields[5] as int? ?? 0,
      autoStartOnBoot: fields[6] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.isFilterEnabled)
      ..writeByte(1)
      ..write(obj.sensitivity)
      ..writeByte(2)
      ..write(obj.quietMode)
      ..writeByte(3)
      ..write(obj.parentModeEnabled)
      ..writeByte(4)
      ..write(obj.parentPin)
      ..writeByte(5)
      ..write(obj.filteredScenesCount)
      ..writeByte(6)
      ..write(obj.autoStartOnBoot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
