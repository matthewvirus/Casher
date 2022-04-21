// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Operation extends DataClass implements Insertable<Operation> {
  final int id;
  final String operation;
  final String value;
  final int tag;
  Operation(
      {required this.id,
      required this.operation,
      required this.value,
      required this.tag});
  factory Operation.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Operation(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      operation: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}operation'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
      tag: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation'] = Variable<String>(operation);
    map['value'] = Variable<String>(value);
    map['tag'] = Variable<int>(tag);
    return map;
  }

  OperationsCompanion toCompanion(bool nullToAbsent) {
    return OperationsCompanion(
      id: Value(id),
      operation: Value(operation),
      value: Value(value),
      tag: Value(tag),
    );
  }

  factory Operation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Operation(
      id: serializer.fromJson<int>(json['id']),
      operation: serializer.fromJson<String>(json['operation']),
      value: serializer.fromJson<String>(json['value']),
      tag: serializer.fromJson<int>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operation': serializer.toJson<String>(operation),
      'value': serializer.toJson<String>(value),
      'tag': serializer.toJson<int>(tag),
    };
  }

  Operation copyWith({int? id, String? operation, String? value, int? tag}) =>
      Operation(
        id: id ?? this.id,
        operation: operation ?? this.operation,
        value: value ?? this.value,
        tag: tag ?? this.tag,
      );
  @override
  String toString() {
    return (StringBuffer('Operation(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('value: $value, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, operation, value, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Operation &&
          other.id == this.id &&
          other.operation == this.operation &&
          other.value == this.value &&
          other.tag == this.tag);
}

class OperationsCompanion extends UpdateCompanion<Operation> {
  final Value<int> id;
  final Value<String> operation;
  final Value<String> value;
  final Value<int> tag;
  const OperationsCompanion({
    this.id = const Value.absent(),
    this.operation = const Value.absent(),
    this.value = const Value.absent(),
    this.tag = const Value.absent(),
  });
  OperationsCompanion.insert({
    this.id = const Value.absent(),
    required String operation,
    required String value,
    required int tag,
  })  : operation = Value(operation),
        value = Value(value),
        tag = Value(tag);
  static Insertable<Operation> custom({
    Expression<int>? id,
    Expression<String>? operation,
    Expression<String>? value,
    Expression<int>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operation != null) 'operation': operation,
      if (value != null) 'value': value,
      if (tag != null) 'tag': tag,
    });
  }

  OperationsCompanion copyWith(
      {Value<int>? id,
      Value<String>? operation,
      Value<String>? value,
      Value<int>? tag}) {
    return OperationsCompanion(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      value: value ?? this.value,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (tag.present) {
      map['tag'] = Variable<int>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OperationsCompanion(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('value: $value, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

class $OperationsTable extends Operations
    with TableInfo<$OperationsTable, Operation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OperationsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _operationMeta = const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String?> operation = GeneratedColumn<String?>(
      'operation', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<int?> tag = GeneratedColumn<int?>(
      'tag', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, operation, value, tag];
  @override
  String get aliasedName => _alias ?? 'operations';
  @override
  String get actualTableName => 'operations';
  @override
  VerificationContext validateIntegrity(Insertable<Operation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Operation map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Operation.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OperationsTable createAlias(String alias) {
    return $OperationsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $OperationsTable operations = $OperationsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [operations];
}
