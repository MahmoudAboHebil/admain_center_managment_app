import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_student_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/student_model.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dart_either/src/dart_either.dart';

import '../../../../core/error/sync_response.dart';
import '../../../../sync_engine/domain/entities/student_entity.dart';

class StudentRepositoryImpl implements StudentRepository {
  final LocalStudentDatasource _datasource;
  const StudentRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, SyncResponse?>> createStudent(
    StudentEntity entity,
  ) async {
    try {
      final result = await _datasource.create(StudentModel.fromEntity(entity));
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "creating student has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Either<Failure, Stream<List<StudentCollection>>> getAllStudentsStream() {
    try {
      final result = _datasource.getCollectionsStream();
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "getting students Stream has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Either<Failure, Stream<int>> watchStudentsCount() {
    try {
      final result = _datasource.watchCollectionsCount();
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "getting students Stream count has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, StudentEntity?>> getStudent(String entityId) async {
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
          message: "get $entityId student details has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteStudent(
    StudentEntity entity,
  ) async {
    try {
      final result = await _datasource.softDelete(
        StudentModel.fromEntity(entity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to soft delete this student ${entity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDeleteStudents(
    Set<String> ids,
  ) async {
    SyncResponse? lastResponse;

    try {
      for (var item in ids) {
        final result = await getStudent(item);
        final entity = result.getOrElse(() => null);
        if (entity != null) {
          final softResult = await _datasource.softDelete(
            StudentModel.fromEntity(entity),
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
  Future<Either<Failure, SyncResponse?>> updateStudent(
    StudentEntity newEntity,
  ) async {
    try {
      final result = await _datasource.update(
        StudentModel.fromEntity(newEntity),
      );
      return result;
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to updated this student ${newEntity.entityId} =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllItemsNotArchived() async {
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
  Future<Either<Failure, List<StudentEntity>>> getEntitiesNameStartWith(
    String name,
  ) async {
    try {
      final result = await _datasource.getModelsNameStartWith(name);
      return result.fold(
        ifLeft: (value) {
          return Left(value);
        },
        ifRight: (mainList) {
          var list = <StudentEntity>[];
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
