import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_student_class_enrollments_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_class_enrollment_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_class_enrollments_collection.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../../core/error/sync_response.dart';
import '../../../../sync_engine/data/models/student_class_enrollments_model.dart';
import '../../../../sync_engine/domain/entities/student_class_enrollments_entity.dart';

class StudentClassEnrollmentRepositoryImpl
    implements StudentClassEnrollmentRepository {
  final LocalStudentClassEnrollmentsDatasource _datasource;
  const StudentClassEnrollmentRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, SyncResponse?>> createStudentClassEnrollment(
    StudentClassEnrollmentsEntity entity,
  ) async {
    try {
      final result = await _datasource.create(
        StudentClassEnrollmentsModel.fromEntity(entity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "creating enrollments  has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, StudentClassEnrollmentsEntity?>>
  getStudentClassEnrollment(String entityId) async {
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
              "get $entityId enrollments details has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteStudentClassEnrollment(
    StudentClassEnrollmentsEntity entity,
  ) async {
    try {
      final result = await _datasource.softDelete(
        StudentClassEnrollmentsModel.fromEntity(entity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to soft delete this enrollments ${entity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteStudentClassEnrollments(
    Set<String> ids,
  ) async {
    SyncResponse? lastResponse;

    try {
      for (var item in ids) {
        final result = await getStudentClassEnrollment(item);
        final entity = result.getOrElse(() => null);
        if (entity != null) {
          final softResult = await _datasource.softDelete(
            StudentClassEnrollmentsModel.fromEntity(entity),
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
  Future<Either<Failure, SyncResponse?>> updateStudentClassEnrollment(
    StudentClassEnrollmentsEntity newEntity,
  ) async {
    try {
      final result = await _datasource.update(
        StudentClassEnrollmentsModel.fromEntity(newEntity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to updated this enrollments ${newEntity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<StudentClassEnrollmentsEntity>>>
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
      return Left(ProcessingFailure(message: "failed to get Students"));
    }
  }

  @override
  Either<Failure, Stream<List<StudentClassEnrollmentsCollection>>>
  getAllStudentClassEnrollmentsStream() {
    // TODO: implement getAllStudentClassEnrollmentsStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<StudentClassEnrollmentsEntity>>>
  getEntitiesNameStartWith(String name) {
    // TODO: implement getEntitiesNameStartWith
    throw UnimplementedError();
  }

  @override
  Either<Failure, Stream<int>> watchStudentClassEnrollmentsCount() {
    // TODO: implement watchStudentClassEnrollmentsCount
    throw UnimplementedError();
  }
}
