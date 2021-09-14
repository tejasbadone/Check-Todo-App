import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  final String? name;
  bool? isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
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
