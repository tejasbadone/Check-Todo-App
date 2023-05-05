import 'package:flutter/material.dart';
import 'package:todoey_flutter/themes.dart';

class TaskTile extends StatelessWidget {
  @override
  bool? isChecked;
  final String? taskTitle;
  final Function? checkboxCallback;
  final Function? longPressCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.checkboxCallback,
      this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback as void Function()?,
      title: Text(
        taskTitle!,
        style: TextStyle(
          decoration: isChecked! ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        fillColor: Theme.of(context).checkboxTheme.fillColor,
        value: isChecked,
        onChanged: checkboxCallback as void Function(bool?)?,
      ),
    );
  }
}
