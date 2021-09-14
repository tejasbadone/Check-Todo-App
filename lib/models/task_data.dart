import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoey_flutter/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void init() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    String? jsonTask = sPref.getString("task");
    print(jsonTask);
    if (jsonTask != null) {
      _tasks = taskFromJson(jsonTask);
      notifyListeners();
    }
  }

  saveToPreference() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    sPref.setString("task", taskToJson(_tasks));
  }

  void addTask(String? newTaskTitle) async {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    await saveToPreference();
    notifyListeners();
  }

  void updateTask(Task task) async {
    task.toggleDone();
    await saveToPreference();
    notifyListeners();
  }

  void deleteTask(Task task) async {
    _tasks.remove(task);
    await saveToPreference();
    notifyListeners();
  }
}
