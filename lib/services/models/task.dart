import 'package:uuid/uuid.dart';

import '../store/hive.dart';

class Task {
  String key;
  String title;
  String body;
  DateTime time;

  Task(this.key, this.title, this.body, this.time);

  @override
  String toString() => title;
}

// class TaskStore extends CacheStore<String, Task> {
//   TaskStore() : super("tasks");

//   Future<Task> addItem(String item, String body) async {
//     var uuid = const Uuid();
//     var key = uuid.v4().toString();
//     var task = Task(key, item, body, DateTime.now());
//     await super.putValue(key, task);
//     return task;
//   }

//   Future<Task> putItem(String key, Task task) async {
//     await super.putValue(key, task);
//     return task;
//   }
// }
