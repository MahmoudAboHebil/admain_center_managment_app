import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_section_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_table_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_section_model.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/standard_table_record_model.dart';
import 'package:isar/isar.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/helper/helper.dart';
import '../../../core/isar_local_database/isar/isar_service.dart';

class SyncClassSectionDatasource implements SyncTableDatasource {
  @override
  Future<void> softDelete(String entityId) async {
    final records = await IsarService.isar.classSectionCollections
        .filter()
        .entityIdEqualTo(entityId)
        .findAll();

    for (final r in records) {
      r.isDeleted = true;
    }

    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.classSectionCollections.putAll(records);
    });
  }

  @override
  Future<List<String>> getForeignkeyEntitiesIdsBulk(
    DBTable parentTable,
    List<String> parentsIds,
  ) async {
    Set<String> ids = {};
    List<ClassSectionCollection> collections = [];

    if (parentTable == DBTable.classes) {
      const batchSize = 200;

      for (final batch in Helper.chunk(parentsIds.toList(), batchSize)) {
        final result = await IsarService.isar.classSectionCollections
            .filter()
            .anyOf(
              batch,
              (q, id) => q.classIdEqualTo(id).and().isDeletedEqualTo(false),
            )
            .findAll();
        collections = [...collections, ...result];
      }

      for (final coll in collections) {
        ids.add(coll.entityId);
      }

      return ids.toList();
    }
    throw Exception('there are no fornKey in class section table');
  }

  @override
  DBTable get table => DBTable.class_sections;

  @override
  Future<void> softDeleteEntities(List<String> ids) async {
    final uniqueIds = ids.toSet();
    List<ClassSectionCollection> results = [];
    const batchSize = 200;
    for (final batch in Helper.chunk(uniqueIds.toList(), batchSize)) {
      final result = await IsarService.isar.classSectionCollections
          .filter()
          .anyOf(batch, (q, id) => q.entityIdEqualTo(id))
          .findAll();
      results = [...results, ...result];
    }

    for (final r in results) {
      r.isDeleted = true;
    }

    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.classSectionCollections.putAll(results);
    });
  }

  @override
  Future<void> updateEntity<T>(T model) async {
    final modelOne = model as ClassSectionModel;

    final oldCollection = await IsarService.isar.classSectionCollections
        .filter()
        .entityIdEqualTo(modelOne.entityId)
        .findFirst();

    if (oldCollection != null) {
      final newCollection = ClassSectionCollection()
        ..id = oldCollection.id
        ..entityId = oldCollection.entityId
        ..centerId = modelOne.centerId
        ..byUser = modelOne.byUser
        ..byDevice = modelOne.byDevice
        ..isDeleted = modelOne.isDeleted
        ..version = modelOne.version
        ..createdAt = modelOne.createdAt.toUtc()
        ..updatedAt = modelOne.updatedAt.toUtc()
        ..startOn = modelOne.startOn.toUtc()
        ..endOn = modelOne.endOn.toUtc()
        ..day = modelOne.day
        ..classId = modelOne.classId;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.classSectionCollections.put(newCollection);
      });
    } else {
      throw Exception(
        'there is no record in db for ${model.entityId} at ${DBTable.class_sections.name} table',
      );
    }
  }

  @override
  Future<StandardTableRecordModel?> getEntity(String entityId) async {
    final record = await IsarService.isar.classSectionCollections
        .filter()
        .entityIdEqualTo(entityId)
        .findFirst();
    if (record == null) return null;
    return ClassSectionModel.fromCollection(record);
  }

  @override
  Future<void> insertEntity<T>(T model) async {
    final tableModel = model as ClassSectionModel;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.classSectionCollections.put(
        tableModel.toCollection(),
      );
    });
  }
}
