import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/models/center_model.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/center_collection.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:isar/isar.dart';

class LocalCenterDatasource implements LocalDbOperations<CenterModel> {
  @override
  Future<void> deleteFromLocalDB(String modelId) async {
    try {
      await IsarService.isar.writeTxn(() async {
        IsarService.isar.centerCollections.deleteByEntityId(modelId);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CenterModel>> getAllFromLocalDB() async {
    try {
      var list = <CenterModel>[];
      final result = await IsarService.isar.centerCollections
          .where()
          .findFirst();
      if (result == null) return list;
      final model = CenterModel.fromCollection(result);
      list.add(model);
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CenterModel?> getItemFromLocalDB(String modelId) async {
    try {
      final result = await IsarService.isar.centerCollections
          .where()
          .findFirst();
      if (result == null) return null;
      return CenterModel.fromCollection(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertToLocalDB(CenterModel model) async {
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.centerCollections.where().deleteAll();
      });
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.centerCollections.put(model.toCollection());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateWithinLocalDB(CenterModel newModel) async {
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.centerCollections.where().deleteAll();
      });
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.centerCollections.put(newModel.toCollection());
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> softDeleteFromLocalDB(String modelId) async {
    try {
      await deleteFromLocalDB(modelId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertAllStudyLevel(List<CenterModel> entities) {
    throw UnimplementedError();
  }
}
