import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/bloc/todo_event.dart';
import 'package:todo_app/bloc/todo_state.dart';
import 'package:todo_app/db/database.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AppDatabase appDatabase;

  TodoBloc({@required this.appDatabase}) : super(Initial());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is InsertTodo) {
      yield* _insertTodo(event.data);
    } else if (event is GetAllTodo) {
      yield* _getAllTodo();
    } else if (event is UpdateTodo) {
      yield* _updateTodo(event.data);
    } else if (event is DeleteTodo) {
      yield* _deleteTodo(event.data);
    }
  }

  Stream<TodoState> _insertTodo(TodoData data) async* {
    try {
      await appDatabase.todoDao.insertTodo(data);
      yield Success(message: "Insert Success");
    } catch (e) {
      yield Error(message: e.toString());
    }
  }

  Stream<TodoState> _getAllTodo() async* {
    try {
      final todo = await appDatabase.todoDao.getAllTodo();
      if (todo.isEmpty) {
        yield NoData(message: "Todo Empty");
      } else {
        yield HasData(data: todo);
      }
    } catch (e) {
      yield Error(message: e.toString());
    }
  }

  Stream<TodoState> _updateTodo(TodoData data) async* {
    try {
      await appDatabase.todoDao.updateTodo(data);
      yield Success(message: "Update Success");
    } catch (e) {
      yield Error(message: e.toString());
    }
  }

  Stream<TodoState> _deleteTodo(TodoData data) async* {
    try {
      await appDatabase.todoDao.deleteTodo(data);
      yield Success(message: "Delete Success");
    } catch (e) {
      yield Error(message: e.toString());
    }
  }
}
