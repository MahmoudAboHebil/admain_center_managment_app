import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_class_section_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_section_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_section_collection.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../../core/error/sync_response.dart';
import '../../../../sync_engine/data/models/class_section_model.dart';
import '../../../../sync_engine/domain/entities/class_section_entity.dart';

class ClassSectionRepositoryImpl implements ClassSectionRepository {
  final LocalClassSectionDatasource _datasource;
  const ClassSectionRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, SyncResponse?>> createClassSection(
    ClassSectionEntity entity,
  ) async {
    try {
      final result = await _datasource.create(
        ClassSectionModel.fromEntity(entity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "creating class section  has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ClassSectionEntity?>> getClassSection(
    String entityId,
  ) async {
    try {
      final result = await _datasource.getModel(entityId);
      result.fold(
        ifLeft: (value) {
          return Left(value);
        },
        ifRight: (value) {
          return Right(value?.toEntity());
        },
      );
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "get $entityId class section details has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteClassSection(
    ClassSectionEntity entity,
  ) async {
    try {
      final result = await _datasource.softDelete(
        ClassSectionModel.fromEntity(entity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to soft delete this class section ${entity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteClassSections(
    Set<String> ids,
  ) async {
    SyncResponse? lastResponse;

    try {
      for (var item in ids) {
        final result = await getClassSection(item);
        final entity = result.getOrElse(() => null);
        if (entity != null) {
          final softResult = await _datasource.softDelete(
            ClassSectionModel.fromEntity(entity),
          );
          lastResponse = softResult.getOrElse(() => null);
        }
      }

      return Right(lastResponse);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "failed to soft delete classes sections => ${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> updateClassSection(
    ClassSectionEntity newEntity,
  ) async {
    try {
      final result = await _datasource.update(
        ClassSectionModel.fromEntity(newEntity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to updated this class section ${newEntity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ClassSectionEntity>>>
  getAllItemsNotArchived() async {
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
      return Left(ProcessingFailure(message: "failed to get classes sections"));
    }
  }

  @override
  Either<Failure, Stream<List<ClassSectionCollection>>>
  getAllClassSectionsStream() {
    // TODO: implement getAllClassSectionsStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ClassSectionEntity>>> getEntitiesNameStartWith(
    String name,
  ) {
    // TODO: implement getEntitiesNameStartWith
    throw UnimplementedError();
  }

  @override
  Either<Failure, Stream<int>> watchClassSectionsCount() {
    // TODO: implement watchClassSectionsCount
    throw UnimplementedError();
  }
}
