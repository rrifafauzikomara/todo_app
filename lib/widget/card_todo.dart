import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_event.dart';
import 'package:todo_app/db/database.dart';

class CardTodo extends StatelessWidget {
  final int index;
  final TodoData data;
  final Function editPressed;

  CardTodo(
      {@required this.index, @required this.data, @required this.editPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
          radius: 20,
        ),
        title: Text(data.title),
        subtitle: Text(data.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: editPressed,
              color: Colors.green,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                context.read<TodoBloc>().add(DeleteTodo(data: data));
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
