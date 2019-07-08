import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todos_model.dart';
import 'task_list.dart';
class DoneTask extends StatelessWidget {
  const DoneTask({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodoModel>(
        builder: (context, todos, child) {
          return TaskList(
            tasks: todos.doneTasks,
          );
        },
      ),
    );
  }
}
