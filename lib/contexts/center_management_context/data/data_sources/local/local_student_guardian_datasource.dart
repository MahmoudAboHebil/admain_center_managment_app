import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/models/student_guardian_model.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_guardian_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:isar/isar.dart';

class LocalStudentGuardianDatasource
    implements LocalDbOperations<StudentGuardianModel> {
  @override
  Future<void> deleteFromLocalDB(String entityId) async {
    try {
      await IsarService.isar.writeTxn(() async {
        IsarService.isar.studentGuardianCollections.deleteByEntityId(entityId);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<StudentGuardianModel>> getAllFromLocalDB() async {
    try {
      var list = <StudentGuardianModel>[];
      final result = await IsarService.isar.studentGuardianCollections
          .where()
          .findAll();

      for (var item in result) {
        list.add(StudentGuardianModel.fromCollection(item));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<StudentGuardianModel?> getItemFromLocalDB(String entityId) async {
    try {
      final result = await IsarService.isar.studentGuardianCollections
          .filter()
          .entityIdEqualTo(entityId)
          .findFirst();
      if (result == null) return null;
      return StudentGuardianModel.fromCollection(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertToLocalDB(StudentGuardianModel model) async {
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentGuardianCollections.put(
          model.toCollection(),
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWithinLocalDB(StudentGuardianModel newModel) async {
    try {
      final result = await IsarService.isar.studentGuardianCollections
          .filter()
          .entityIdEqualTo(newModel.entityId)
          .findFirst();
      if (result == null) {
        await insertToLocalDB(newModel);
        return;
      }
      var newCollection = StudentGuardianCollection()
        ..id = result.id
        ..entityId = newModel.entityId
        ..studentId = newModel.studentId
        ..guardianId = newModel.guardianId
        ..createdAt = newModel.createdAt.toUtc();

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentGuardianCollections.put(newCollection);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> softDeleteFromLocalDB(String entityId) async {
    try {
      await deleteFromLocalDB(entityId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertAllStudyLevel(List<StudentGuardianModel> entities) {
    throw UnimplementedError();
  }
}
