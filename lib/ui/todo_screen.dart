import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/bloc/todo_event.dart';
import 'package:todo_app/bloc/todo_state.dart';
import 'package:todo_app/db/database.dart';
import 'package:todo_app/widget/card_todo.dart';
import 'package:todo_app/widget/custom_snackbar.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  Future<AlertDialog> _displayDialog(
      BuildContext context, bool isUpdate, TodoData data) async {
    if (data == null) {
      _titleController.text = "";
      _descController.text = "";
    } else {
      _titleController.text = data.title;
      _descController.text = data.description;
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a task to your list'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Enter task title'),
              ),
              TextField(
                controller: _descController,
                decoration: InputDecoration(hintText: 'Enter task desc'),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: isUpdate ? Text("Update") : Text("Add"),
              onPressed: () {
                Navigator.pop(context);
                if (isUpdate) {
                  context.read<TodoBloc>().add(UpdateTodo(
                          data: TodoData(
                        id: data.id,
                        title: _titleController.text,
                        description: _descController.text,
                      )));
                } else {
                  context.read<TodoBloc>().add(InsertTodo(
                          data: TodoData(
                        title: _titleController.text,
                        description: _descController.text,
                      )));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetAllTodo());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context, false, null),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is Success) {
            CustomSnackBar.showSuccess(state.message, context);
            context.read<TodoBloc>().add(GetAllTodo());
          } else if (state is Error) {
            CustomSnackBar.showError(state.message, context);
          }
        },
        child: Center(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is HasData) {
                return ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) => CardTodo(
                    index: index,
                    data: state.data[index],
                    editPressed: () =>
                        _displayDialog(context, true, state.data[index]),
                  ),
                );
              } else if (state is NoData) {
                return Text(state.message);
              } else if (state is Error) {
                return Text(state.message);
              } else {
                return Text("No State");
              }
            },
          ),
        ),
      ),
    );
  }
}
