part of 'pill_model.dart';

class PillAdapter extends TypeAdapter<PillModel> {
  @override
  final int typeId = 0;

  @override
  PillModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PillModel()
      ..name = fields[0] as String
      ..totalNumber = fields[1] as String
      ..dayNumber = fields[2] as String
      ..startDate = fields[3] as String
      ..dayTime = fields[4] as String
      ..dayOfWeekAndTime = (fields[5] as Map).cast<String, String>();
  }

  @override
  void write(BinaryWriter writer, PillModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.totalNumber)
      ..writeByte(2)
      ..write(obj.dayNumber)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.dayTime)
      ..writeByte(5)
      ..write(obj.dayOfWeekAndTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PillAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
