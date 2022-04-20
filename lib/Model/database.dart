import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'operations_model.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [Operations])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Operation>> getOperations() async {
    return await select(operations).get();
  }

  Future<Operation> getOperation(int id) async{
    return await (select(operations)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<bool> updateOperation(OperationsCompanion entity) async {
    return await update(operations).replace(entity);
  }

  Future<int> insertOperation(OperationsCompanion entity) async {
    return await into(operations).insert(entity);
  }

  Future<int> deleteOperation(int id) async {
    return await (delete(operations)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}