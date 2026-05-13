import 'dart:collection';

import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_class_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_class_section_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_student_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_table_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_model.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_section_model.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/student_model.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_entity.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:dart_either/dart_either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/constants.dart';
import '../../../core/enums/DB_Table.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/netwrok_response.dart';
import '../../../core/helper/helper.dart';
import '../../domain/entities/operation.dart';
import '../../domain/entities/standard_table_record.dart';
import '../../domain/repository/table_repository.dart';
import '../datasource/local_queue_datasource.dart';
import '../models/operation_model.dart';
import '../models/standard_table_record_model.dart';

class TableRepositoryImpl implements TableRepository {
  final LocalQueueDatasource _queueDatasource;
  TableRepositoryImpl(this._queueDatasource);

  SyncTableDatasource _getTableDataSource(DBTable table) {
    if (table == DBTable.students) {
      return SyncStudentDatasource();
    } else if (table == DBTable.classes) {
      return SyncClassDatasource();
    } else if (table == DBTable.class_sections) {
      return SyncClassSectionDatasource();
    } else {
      throw Exception(
        'there is not datasource file for this ${table.name} table',
      );
    }
  }

  StandardTableRecordModel _getTableModel(
    DBTable table,
    Map<String, dynamic> jsonModel,
  ) {
    if (table == DBTable.students) {
      return StudentModel.fromJson(jsonModel);
    } else if (table == DBTable.classes) {
      return ClassModel.fromJson(jsonModel);
    } else if (table == DBTable.class_sections) {
      return ClassSectionModel.fromJson(jsonModel);
    } else {
      throw Exception('there is not model file for this ${table.name} table');
    }
  }

  Map<DBTable, List<String>> _getForginKeysIds(
    DBTable table,
    Operation operation,
  ) {
    if (table == DBTable.students) {
      return {};
    } else if (table == DBTable.classes) {
      return {};
    } else if (table == DBTable.class_sections) {
      final model = _getTableModel(table, operation.json) as ClassSectionModel;
      return {
        DBTable.classes: [model.classId],
      };
    } else {
      return {};
    }
  }

  StandardTableRecordModel _getTableModelFromEntity(
    DBTable table,
    StandardTableRecord entity,
  ) {
    if (table == DBTable.students) {
      return StudentModel.fromEntity(entity as StudentEntity);
    } else if (table == DBTable.classes) {
      return ClassModel.fromEntity(entity as ClassEntity);
    } else if (table == DBTable.class_sections) {
      return ClassSectionModel.fromEntity(entity as ClassSectionEntity);
    } else {
      throw Exception('there is not model  for this ${table.name} table');
    }
  }

  @override
  Future<Either<Failure, Map<DBTable, List<String>>>>
  deleteEntityCascadeNotNull(
    DBTable startTable,
    String entityId, {
    bool test = false,
  }) async {
    try {
      final result = await getForwardRecursiveRelationsIds(
        startTable,
        entityId,
      );
      if (result.isLeft) {
        final leftValue = result.fold(ifLeft: (l) => l, ifRight: (d) => null);
        return Left(leftValue!);
      }
      Map<DBTable, List<String>> tableEntityRemoveIds = result.getOrThrow();
      //todo: delete subs  from db && queue
      for (final tab in tableEntityRemoveIds.entries) {
        final table = tab.key;
        final ids = tab.value;
        final dataSource = _getTableDataSource(table);
        await dataSource.softDeleteEntities(ids.toList());
        await _queueDatasource.removeOperationsByEntitiesIds(ids.toList());
      }
      //todo: delete main  from db
      final dataSource = _getTableDataSource(startTable);
      await dataSource.softDelete(entityId);
      final tableIds = tableEntityRemoveIds[startTable] ?? [];

      tableEntityRemoveIds[startTable] = {...tableIds, entityId}.toList();
      return Right(tableEntityRemoveIds);
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> replaceEntityLocalWithServer(
    DBTable table,
    Map<String, dynamic> json,
  ) async {
    try {
      final model = _getTableModel(table, json);
      final dataSource = _getTableDataSource(table);
      await dataSource.updateEntity(model);
      return Right(null);
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getEntityFromTable(
    DBTable table,
    String entityId,
  ) async {
    try {
      final dataSource = _getTableDataSource(table);
      final model = await dataSource.getEntity(entityId);
      if (model == null) return Right(null);

      return Right(model.toJson());
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getUpdatedServerEntities(
    DBTable table,
    String deviceId,
    DateTime lastTimeSync,
    String centerId,
  ) async {
    try {
      final response = await supabase
          .from(table.name)
          .select()
          .eq('center_id', centerId)
          .gt('push_time', lastTimeSync.toUtc().toIso8601String())
          .neq('by_device', deviceId);

      return Right(response);
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertEntityToTable(
    DBTable table,
    Map<String, dynamic>? jsonEntity,
    StandardTableRecord? entity,
  ) async {
    try {
      final model;
      if (entity != null) {
        model = _getTableModelFromEntity(table, entity);
      } else {
        model = _getTableModel(table, jsonEntity!);
      }
      final dataSource = _getTableDataSource(table);
      await dataSource.insertEntity(model);
      return Right(null);
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NetworkResponse>> sendOperationToServer(
    Operation operation,
    String deviceId,
  ) async {
    Map<String, dynamic> recursiveForwardRelationsIds = {};

    Map<String, dynamic> recursiveBackwordRelationsIds = {};

    final forward = await getForwardRecursiveRelationsIds(
      operation.table,
      operation.entityId,
    );
    final forwardResult = forward.getOrThrow();

    for (final item in forwardResult.entries) {
      recursiveForwardRelationsIds[item.key.name] = item.value;
    }

    final backword = _getForginKeysIds(operation.table, operation);

    for (final item in backword.entries) {
      recursiveBackwordRelationsIds[item.key.name] = item.value;
    }

    print('Forward :$recursiveForwardRelationsIds');
    print('backword :$recursiveBackwordRelationsIds');

    try {
      final operationModel = OperationModel.fromOperation(operation);
      final payload = {
        "operation": operationModel.toJson(),
        "parent_ids": recursiveBackwordRelationsIds,
        "tablesEntitiesIdsRemove": recursiveForwardRelationsIds,
        "device_id": deviceId,
        "user_id": operationModel.createdBy,
      };

      final response = await Supabase.instance.client.functions.invoke(
        'sync-operation',
        body: payload,
      );
      print('response $response');

      final result = Helper.handleSyncOperationResponse(response.data);
      print('rrrrrrrr $result');
      return Right(result);
    } on FunctionException catch (e) {
      final result = InternalServerError(details: e.details);
      return Right(result);
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<DBTable, List<String>>>>
  getForwardRecursiveRelationsIds(DBTable startTable, String entityId) async {
    try {
      final Map<DBTable, Set<String>> tableEntityRemoveIds = {
        startTable: {entityId},
      };

      final Queue<DBTable> queue = Queue();
      queue.add(startTable);

      while (queue.isNotEmpty) {
        final current = queue.removeFirst();
        final parentIds = tableEntityRemoveIds[current] ?? {};

        if (parentIds.isEmpty) continue;

        final children = tabelRelationsNotNull[current]?["forward"] ?? [];

        for (final child in children) {
          final idsList = await _getTableDataSource(
            child,
          ).getForeignkeyEntitiesIdsBulk(current, parentIds.toList());

          final ids = idsList.toSet();
          if (ids.isEmpty) continue;

          final existing = tableEntityRemoveIds[child] ?? {};

          final newIds = ids.difference(existing);

          if (newIds.isNotEmpty) {
            tableEntityRemoveIds[child] = {...existing, ...newIds};

            queue.add(child);
          }
        }
      }
      tableEntityRemoveIds.remove(startTable);

      final Map<DBTable, List<String>> result = {};
      for (final item in tableEntityRemoveIds.entries) {
        result[item.key] = item.value.toList();
      }
      return Right(result);
    } catch (e) {
      return Left(ProcessingFailure(message: e.toString()));
    }
  }
}
