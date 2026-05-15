import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../core/error/sync_response.dart';
import '../../../../sync_engine/domain/entities/student_entity.dart';

abstract class StudentRepository {
  Future<Either<Failure, SyncResponse?>> createStudent(StudentEntity entity);
  Future<Either<Failure, SyncResponse?>> updateStudent(StudentEntity newEntity);
  Future<Either<Failure, SyncResponse?>> softDeleteStudent(
    StudentEntity entity,
  );
  Future<Either<Failure, SyncResponse?>> softDeleteStudents(Set<String> ids);
  Either<Failure, Stream<List<StudentCollection>>> getAllStudentsStream();

  Future<Either<Failure, StudentEntity?>> getStudent(String entityId);
  Future<Either<Failure, List<StudentEntity>>> getEntitiesNameStartWith(
    String name,
  );

  Either<Failure, Stream<int>> watchStudentsCount();

  Future<Either<Failure, List<StudentEntity>>> getAllItemsNotArchived();
}
