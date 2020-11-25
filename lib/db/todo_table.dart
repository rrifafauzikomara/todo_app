import 'package:moor_flutter/moor_flutter.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();

  TextColumn get title => text()();

  TextColumn get description => text()();
}