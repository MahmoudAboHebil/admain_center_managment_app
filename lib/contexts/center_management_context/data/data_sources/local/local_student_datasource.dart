import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/models/student_model.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:isar/isar.dart';

class LocalStudentDatasource implements LocalDbOperations<StudentModel> {
  @override
  Future<void> deleteFromLocalDB(String entityId) async {
    try {
      await IsarService.isar.writeTxn(() async {
        IsarService.isar.studentCollections.deleteByEntityId(entityId);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StudentModel>> getAllFromLocalDB() async {
    try {
      var list = <StudentModel>[];
      final result = await IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .sortByJoinDate()
          .findAll();

      for (var item in result) {
        list.add(StudentModel.fromCollection(item));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StudentModel?> getItemFromLocalDB(String entityId) async {
    try {
      final result = await IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .and()
          .entityIdEqualTo(entityId)
          .findFirst();
      if (result == null) return null;
      return StudentModel.fromCollection(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertToLocalDB(StudentModel model) async {
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentCollections.put(model.toCollection());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWithinLocalDB(StudentModel newModel) async {
    try {
      final result = await IsarService.isar.studentCollections
          .filter()
          .entityIdEqualTo(newModel.entityId)
          .findFirst();
      if (result == null) {
        await insertToLocalDB(newModel);
        return;
      }
      var newCollection = StudentCollection()
        ..id = result.id
        ..entityId = newModel.entityId
        ..centerId = newModel.centerId
        ..byUser = newModel.byUser
        ..byDevice = newModel.byDevice
        ..isDeleted = newModel.isDeleted
        ..version = newModel.version
        ..createdAt = newModel.createdAt.toUtc()
        ..updatedAt = newModel.updatedAt.toUtc()
        ..studyLevelId = newModel.studyLevelId
        ..name = newModel.name
        ..phone = newModel.phone
        ..homePhone = newModel.homePhone
        ..whatsAppPhone = newModel.whatsAppPhone
        ..schoolName = newModel.schoolName
        ..gender = newModel.gender.name
        ..birthDate = newModel.birthDate.toUtc()
        ..joinDate = newModel.joinDate.toUtc()
        ..studentStatus = newModel.studentStatus.name;

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentCollections.put(newCollection);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> softDeleteFromLocalDB(String entityId) async {
    try {
      final collection = await IsarService.isar.studentCollections
          .filter()
          .entityIdEqualTo(entityId)
          .findFirst();
      if (collection == null) {
        return;
      }
      collection.isDeleted = true;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentCollections.put(collection);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertAllStudyLevel(List<StudentModel> entities) {
    throw UnimplementedError();
  }
}
