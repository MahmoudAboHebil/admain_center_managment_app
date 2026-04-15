import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_class_enrollments_collection.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_class_enrollments_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../core/error/sync_response.dart';

abstract class StudentClassEnrollmentRepository {
  Future<Either<Failure, SyncResponse?>> createStudentClassEnrollment(
    StudentClassEnrollmentsEntity entity,
  );
  Future<Either<Failure, SyncResponse?>> updateStudentClassEnrollment(
    StudentClassEnrollmentsEntity newEntity,
  );
  Future<Either<Failure, SyncResponse?>> softDeleteStudentClassEnrollment(
    StudentClassEnrollmentsEntity entity,
  );
  Future<Either<Failure, SyncResponse?>> softDeleteStudentClassEnrollments(
    Set<String> ids,
  );
  Either<Failure, Stream<List<StudentClassEnrollmentsCollection>>>
  getAllStudentClassEnrollmentsStream();
  Future<Either<Failure, StudentClassEnrollmentsEntity?>>
  getStudentClassEnrollment(String entityId);
  Future<Either<Failure, List<StudentClassEnrollmentsEntity>>>
  getEntitiesNameStartWith(String name);

  Either<Failure, Stream<int>> watchStudentClassEnrollmentsCount();

  Future<Either<Failure, List<StudentClassEnrollmentsEntity>>>
  getAllItemsNotArchived();
}
