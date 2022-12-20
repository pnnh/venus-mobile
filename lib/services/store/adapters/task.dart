import 'package:dream/services/models/task.dart';
import 'package:hive/hive.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final typeId = 0;

  @override
  Task read(BinaryReader reader) {
    return Task(reader.readString(), reader.readString(), reader.readString(),
        DateTime.fromMicrosecondsSinceEpoch(reader.readInt()));
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.writeString(obj.key);
    writer.writeString(obj.title);
    writer.writeString(obj.body);
    writer.writeInt(obj.time.millisecondsSinceEpoch);
  }
}
