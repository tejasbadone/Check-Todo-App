import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskTile extends StatelessWidget {
  final bool? isChecked;
  final String? text;
  final Function? toggleCheckBoxState;
  final Function? longPressIdentify;

  TaskTile(
      {this.isChecked,
      this.text,
      this.toggleCheckBoxState,
      this.longPressIdentify});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressIdentify as void Function()?,
      title: Text(
        text!,
        style: TextStyle(
            decoration: isChecked! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: toggleCheckBoxState as void Function(bool?)?,
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              text: task.name,
              isChecked: task.isDone,
              toggleCheckBoxState: (bool newValue) => taskData.updateTask(task),
              longPressIdentify: () => taskData.removeTask(task),
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final controller = TextEditingController();

  String? userTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: 600,
      child: Container(
        padding: EdgeInsets.all(36.0),
        //decoration: kContainerBoxRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add a Task',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 36,
                  fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.lightBlueAccent.shade700),
                onChanged: (inputTask) {
                  userTask = inputTask;
                },
                //autofocus: true,
                cursorRadius: Radius.circular(32.0),
                enableSuggestions: true,
                enabled: true,
                expands: false,
                controller: controller,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            MaterialButton(
              onPressed: () {
                print(controller.text);
                print("onpressed $userTask");
                if (userTask == null) {
                } else {
                  controller.clear();
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(userTask);
                  print(TaskData().taskCount);
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'ADD',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  final String? name;
  bool? isDone;

  Task({this.name, this.isDone = false});

  void toggleIsDone() {
    isDone = !isDone!;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        name: json["name"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isDone": isDone,
      };
}

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

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

  void addTask(String? newTaskName) async {
    final task = Task(name: newTaskName);
    _tasks.add(task);
    await saveToPreference();
    notifyListeners();
  }

  void updateTask(Task task) async {
    task.toggleIsDone();
    await saveToPreference();
    notifyListeners();
  }

  void removeTask(Task task) async {
    _tasks.remove(task);
    await saveToPreference();
    notifyListeners();
  }
}

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 42.0, right: 36.0),
        child: FloatingActionButton(
            child: Icon(
              Icons.add,
              size: 48.0,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => AddTaskScreen(),
              );
            }),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 50.0, top: 120.0, right: 30.0, bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      color: Colors.lightBlueAccent,
                      size: 60.0,
                    ),
                    backgroundColor: Colors.white,
                    radius: 40.0,
                  ),
                  SizedBox(
                    height: 36.0,
                  ),
                  Text(
                    'Todoey',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 55.0,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${Provider.of<TaskData>(context).taskCount} Tasks',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                //decoration: kContainerBoxRadius,
                child: TaskList(),
              ),
            ),
          ]),
    );
  }
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TaskData()..init(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TaskScreen(),
    );
  }
}
