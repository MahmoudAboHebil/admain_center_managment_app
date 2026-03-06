import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/models/guardian_model.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/guardian_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:isar/isar.dart';

class LocalGuardianDatasource implements LocalDbOperations<GuardianModel> {
  @override
  Future<void> deleteFromLocalDB(String modelId) async {
    try {
      await IsarService.isar.writeTxn(() async {
        IsarService.isar.guardianCollections.deleteByEntityId(modelId);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GuardianModel>> getAllFromLocalDB() async {
    try {
      var list = <GuardianModel>[];
      final result = await IsarService.isar.guardianCollections
          .where()
          .findAll();

      for (var item in result) {
        list.add(GuardianModel.fromCollection(item));
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GuardianModel?> getItemFromLocalDB(String entityId) async {
    try {
      final result = await IsarService.isar.guardianCollections
          .filter()
          .entityIdEqualTo(entityId)
          .findFirst();
      if (result == null) return null;
      return GuardianModel.fromCollection(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertToLocalDB(GuardianModel model) async {
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.guardianCollections.put(model.toCollection());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWithinLocalDB(GuardianModel newModel) async {
    try {
      final result = await IsarService.isar.guardianCollections
          .filter()
          .entityIdEqualTo(newModel.entityId)
          .findFirst();
      if (result == null) {
        await insertToLocalDB(newModel);
        return;
      }
      var newCollection = GuardianCollection()
        ..id = result.id
        ..entityId = newModel.entityId
        ..centerId = newModel.centerId
        ..byUser = newModel.byUser
        ..byDevice = newModel.byDevice
        ..isDeleted = newModel.isDeleted
        ..version = newModel.version
        ..createdAt = newModel.createdAt.toUtc()
        ..updatedAt = newModel.updatedAt.toUtc()
        ..name = newModel.name
        ..relation = newModel.relation.name
        ..phone = newModel.phone
        ..whatsAppPhone = newModel.whatsAppPhone
        ..addressLine1 = newModel.addressLine1
        ..addressLine2 = newModel.addressLine2
        ..email = newModel.email;

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.guardianCollections.put(newCollection);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> softDeleteFromLocalDB(String entityId) async {
    try {
      final collection = await IsarService.isar.guardianCollections
          .filter()
          .entityIdEqualTo(entityId)
          .findFirst();
      if (collection == null) {
        return;
      }
      collection.isDeleted = true;
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.guardianCollections.put(collection);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertAllStudyLevel(List<GuardianModel> entities) {
    throw UnimplementedError();
  }
}
