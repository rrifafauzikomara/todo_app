import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/db/database.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class InsertTodo extends TodoEvent {
  final TodoData data;

  InsertTodo({@required this.data});

  @override
  List<Object> get props => [data];
}

class GetAllTodo extends TodoEvent {}

class UpdateTodo extends TodoEvent {
  final TodoData data;

  UpdateTodo({@required this.data});

  @override
  List<Object> get props => [data];
}

class DeleteTodo extends TodoEvent {
  final TodoData data;

  DeleteTodo({@required this.data});

  @override
  List<Object> get props => [data];
}
