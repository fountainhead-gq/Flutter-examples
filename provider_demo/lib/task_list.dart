import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todos_model.dart';
import 'task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getTasks(),
    );
  }

  List<Widget> getTasks() {
    return tasks.map((todo) => TaskListItem(task: todo)).toList();
  }
}

class TaskListItem extends StatelessWidget {
  final Task task;
  const TaskListItem({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.completed,
        onChanged: (_) {
          Provider.of<TodoModel>(context, listen: false).toggleTodo(task);
        },
      ),
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          Provider.of<TodoModel>(context, listen: false).deleteTodo(task);
        },
      ),
    );
  }
}
