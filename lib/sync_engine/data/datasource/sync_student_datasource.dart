import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_table_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/standard_table_record_model.dart';
import 'package:isar/isar.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/helper/helper.dart';
import '../../../core/isar_local_database/isar/isar_service.dart';
import '../models/student_model.dart';

class SyncStudentDatasource implements SyncTableDatasource {
  @override
  Future<void> softDelete(String entityId) async {
    final records = await IsarService.isar.studentCollections
        .filter()
        .entityIdEqualTo(entityId)
        .findAll();

    for (final r in records) {
      r.isDeleted = true;
    }

    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.studentCollections.putAll(records);
    });
  }

  @override
  Future<List<String>> getForeignkeyEntitiesIdsBulk(
    DBTable parentTable,
    List<String> parentsIds,
  ) {
    throw Exception('there are no fornKey in tableOne table');
  }

  @override
  DBTable get table => DBTable.students;

  @override
  Future<void> softDeleteEntities(List<String> ids) async {
    final uniqueIds = ids.toSet();
    List<StudentCollection> results = [];
    const batchSize = 200;
    for (final batch in Helper.chunk(uniqueIds.toList(), batchSize)) {
      final result = await IsarService.isar.studentCollections
          .filter()
          .anyOf(batch, (q, id) => q.entityIdEqualTo(id))
          .findAll();
      results = [...results, ...result];
    }

    for (final r in results) {
      r.isDeleted = true;
    }

    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.studentCollections.putAll(results);
    });
  }

  @override
  Future<void> updateEntity<T>(T model) async {
    final modelOne = model as StudentModel;

    final oldCollection = await IsarService.isar.studentCollections
        .filter()
        .entityIdEqualTo(modelOne.entityId)
        .findFirst();

    if (oldCollection != null) {
      final newCollection = StudentCollection()
        ..id = oldCollection.id
        ..entityId = oldCollection.entityId
        ..centerId = modelOne.centerId
        ..byUser = modelOne.byUser
        ..byDevice = modelOne.byDevice
        ..isDeleted = modelOne.isDeleted
        ..version = modelOne.version
        ..createdAt = modelOne.createdAt.toUtc()
        ..updatedAt = modelOne.updatedAt.toUtc()
        ..name = modelOne.name
        ..studyLevelId = modelOne.studyLevelId
        ..studentCode = modelOne.studentCode
        ..gender = modelOne.gender.name
        ..studentStatus = modelOne.studentStatus.name
        ..email = modelOne.email
        ..address = modelOne.address
        ..phone = modelOne.phone
        ..homePhone = modelOne.homePhone
        ..parentPhone = modelOne.parentPhone
        ..parentJob = modelOne.parentJob
        ..schoolName = modelOne.schoolName
        ..bookingDeposit = modelOne.bookingDeposit
        ..studentClasses = modelOne.studentClasses
        ..notes = modelOne.notes
        ..paymentTypeEnum = modelOne.paymentTypeEnum?.name
        ..divisionEnum = modelOne.divisionEnum?.name
        ..birthDate = modelOne.birthDate?.toUtc();
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentCollections.put(newCollection);
      });
    } else {
      throw Exception(
        'there is no record in db for ${model.entityId} at ${DBTable.students.name} table',
      );
    }
  }

  @override
  Future<StandardTableRecordModel?> getEntity(String entityId) async {
    final record = await IsarService.isar.studentCollections
        .filter()
        .entityIdEqualTo(entityId)
        .findFirst();
    if (record == null) return null;
    return StudentModel.fromCollection(record);
  }

  @override
  Future<void> insertEntity<T>(T model) async {
    final tableModel = model as StudentModel;
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.studentCollections.put(tableModel.toCollection());
    });
  }
}
