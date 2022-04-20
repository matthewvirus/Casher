import 'package:drift/drift.dart';
import 'database.dart';

class Operations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operation => text().withLength(min: 6, max: 32)();
  TextColumn get value => text().named('value')();
  IntColumn get tag => integer().named('tag')();
}

late List<Operation>? operationsList = <Operation>[]; // OPERATIONS FOR LISTVIEW
late List<int> selectedOperation = <int>[]; // SELECTED OPERATION