import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_student_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/models/student_model.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:dart_either/src/dart_either.dart';

class StudentRepositoryImpl implements StudentRepository {
  final LocalStudentDatasource _datasource;
  const StudentRepositoryImpl(this._datasource);
  @override
  Future<Either<Failure, void>> createStudent(StudentEntity entity) async {
    try {
      final result = await _datasource.insertToLocalDB(
        StudentModel.fromEntity(entity),
      );
      return Right(result);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "creating student has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllStudents() async {
    try {
      final result = await _datasource.getAllFromLocalDB();

      return Right(result.map((mode) => mode.toEntity()).toList());
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "getting students has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, StudentEntity?>> getStudent(String entityId) async {
    try {
      final result = await _datasource.getItemFromLocalDB(entityId);
      if (result == null) return Right(null);
      return Right(result.toEntity());
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: "get $entityId student details has failed =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> hardDeleteStudent(String entityId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> softDeleteStudent(String entityId) async {
    try {
      final result = await _datasource.softDeleteFromLocalDB(entityId);
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to soft delete this student $entityId =>${e.toString()}",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateStudent(StudentEntity newEntity) async {
    try {
      final result = await _datasource.updateWithinLocalDB(
        StudentModel.fromEntity(newEntity),
      );
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              "failed to updated this student ${newEntity.entityId} =>${e.toString()}",
        ),
      );
    }
  }
}
