import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_class_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_model.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../../core/error/sync_response.dart';
import '../../../../core/isar_local_database/isar/collections/class_collection.dart';
import '../../../../sync_engine/domain/entities/class_entity.dart';

class ClassRepositoryImpl implements ClassRepository {
  final LocalClassDatasource _datasource;
  const ClassRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, SyncResponse?>> createClass(ClassEntity entity) async {
    try {
      final result = await _datasource.create(ClassModel.fromEntity(entity));
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "creating class  has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Either<Failure, Stream<List<ClassCollection>>> getAllClassesStream() {
    try {
      final result = _datasource.getCollectionsStream();
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "getting class Stream has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Either<Failure, Stream<int>> watchClassesCount() {
    try {
      final result = _datasource.watchCollectionsCount();
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "getting classes Stream count has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ClassEntity?>> getClass(String entityId) async {
    try {
      final result = await _datasource.getModel(entityId);
      return result.fold(
        ifLeft: (value) {
          return Left(value);
        },
        ifRight: (value) {
          return Right(value?.toEntity());
        },
      );
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "get $entityId class details has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteClass(
    ClassEntity entity,
  ) async {
    try {
      final result = await _datasource.softDelete(
        ClassModel.fromEntity(entity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to soft delete this class ${entity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteClasses(
    Set<String> ids,
  ) async {
    SyncResponse? lastResponse;

    try {
      for (var item in ids) {
        final result = await getClass(item);
        final entity = result.getOrElse(() => null);
        if (entity != null) {
          final softResult = await _datasource.softDelete(
            ClassModel.fromEntity(entity),
          );
          lastResponse = softResult.getOrElse(() => null);
        }
      }

      return Right(lastResponse);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "failed to soft delete students => ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> updateClass(
    ClassEntity newEntity,
  ) async {
    try {
      final result = await _datasource.update(ClassModel.fromEntity(newEntity));
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to updated this class ${newEntity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ClassEntity>>> getAllItemsNotArchived() async {
    try {
      final result = await _datasource.getAllItemsNotArchived();
      result.fold(
        ifLeft: (value) {
          return Left(value);
        },
        ifRight: (mainList) {
          var list = [];
          for (var item in mainList) {
            list.add(item.toEntity());
          }
          return Right(list);
        },
      );
      return Right([]);
    } catch (e) {
      return Left(ProcessingFailure(message: "failed to get Students"));
    }
  }

  @override
  Future<Either<Failure, List<ClassEntity>>> getEntitiesNameStartWith(
    String name,
  ) async {
    try {
      final result = await _datasource.getModelsNameStartWith(name);
      return result.fold(
        ifLeft: (value) {
          return Left(value);
        },
        ifRight: (mainList) {
          var list = <ClassEntity>[];
          for (var item in mainList) {
            list.add(item.toEntity());
          }
          return Right(list);
        },
      );
    } catch (e) {
      return Left(
        ProcessingFailure(message: "failed to  getEntities NameStartWith"),
      );
    }
  }
}
