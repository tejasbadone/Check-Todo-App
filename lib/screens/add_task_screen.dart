import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/themes.dart';

class AddTaskScreen extends StatefulWidget {
  // const AddTaskScreeen({Key? key}) : super(key: key);

  // final Function addTaskCallback;
  // AddTaskScreen({this.addTaskCallback});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    String? newTaskTitle;

    return SingleChildScrollView(
      reverse: true,
      child: Container(
        color: Theme.of(context).primaryColorLight,
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              TextField(
                autofocus: true,
                style: TextStyle(color: Mytheme.black),
                textAlign: TextAlign.center,
                cursorColor: Theme.of(context).scaffoldBackgroundColor,
                onChanged: (newText) {
                  newTaskTitle = newText;
                },
                onSubmitted: (newText) {
                  newTaskTitle = newText;
                  controller.clear();
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskTitle);
                  // print(TaskData().taskCount);
                  Navigator.pop(context);
                },
                enabled: true,
                controller: controller,
                expands: false,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: Theme.of(context)
                          .textButtonTheme
                          .style!
                          .backgroundColor,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ))),
                  // TextButton.styleFrom(backgroundColor: Colors.lightBlueAccent),
                  onPressed: () async {
                    // print(controller.text);
                    // print('onpressed $newTaskTitle');
                    if (newTaskTitle == null) {
                      // Navigator.pop(context);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('Invalid'),
                      //   ),
                      // );
                      print('null value entered');
                    } else {
                      controller.clear();
                      Provider.of<TaskData>(context, listen: false)
                          .addTask(newTaskTitle);
                      // print(TaskData().taskCount);
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
