import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_collection.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../core/error/sync_response.dart';
import '../../../../sync_engine/domain/entities/class_entity.dart';

abstract class ClassRepository {
  Future<Either<Failure, SyncResponse?>> createClass(ClassEntity entity);
  Future<Either<Failure, SyncResponse?>> updateClass(ClassEntity newEntity);
  Future<Either<Failure, SyncResponse?>> softDeleteClass(ClassEntity entity);
  Future<Either<Failure, SyncResponse?>> softDeleteClasses(Set<String> ids);
  Either<Failure, Stream<List<ClassCollection>>> getAllClassesStream();
  Future<Either<Failure, ClassEntity?>> getClass(String entityId);
  Future<Either<Failure, List<ClassEntity>>> getEntitiesNameStartWith(
    String name,
  );

  Either<Failure, Stream<int>> watchClassesCount();

  Future<Either<Failure, List<ClassEntity>>> getAllItemsNotArchived();
}
