import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_section_collection.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../core/error/sync_response.dart';

abstract class ClassSectionRepository {
  Future<Either<Failure, SyncResponse?>> createClassSection(
    ClassSectionEntity entity,
  );
  Future<Either<Failure, SyncResponse?>> updateClassSection(
    ClassSectionEntity newEntity,
  );
  Future<Either<Failure, SyncResponse?>> softDeleteClassSection(
    ClassSectionEntity entity,
  );
  Future<Either<Failure, SyncResponse?>> softDeleteClassSections(
    Set<String> ids,
  );
  Either<Failure, Stream<List<ClassSectionCollection>>>
  getAllClassSectionsStream();
  Future<Either<Failure, ClassSectionEntity?>> getClassSection(String entityId);
  Future<Either<Failure, List<ClassSectionEntity>>> getEntitiesNameStartWith(
    String name,
  );

  Either<Failure, Stream<int>> watchClassSectionsCount();

  Future<Either<Failure, List<ClassSectionEntity>>> getAllItemsNotArchived();
}
