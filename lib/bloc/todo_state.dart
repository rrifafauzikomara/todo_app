import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/db/database.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class Initial extends TodoState {}

class Error extends TodoState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

class Success extends TodoState {
  final String message;

  Success({@required this.message});

  @override
  List<Object> get props => [message];
}

class NoData extends TodoState {
  final String message;

  NoData({@required this.message});

  @override
  List<Object> get props => [message];
}

class HasData extends TodoState {
  final List<TodoData> data;

  HasData({@required this.data});

  @override
  List<Object> get props => [data];
}
