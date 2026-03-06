import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:dart_either/dart_either.dart';

abstract class StudentRepository {
  Future<Either<Failure, void>> createStudent(StudentEntity model);
  Future<Either<Failure, void>> updateStudent(StudentEntity newModel);
  Future<Either<Failure, void>> softDeleteStudent(String entityId);
  Future<Either<Failure, void>> hardDeleteStudent(String entityId);
  Future<Either<Failure, List<StudentEntity>>> getAllStudents();
  Future<Either<Failure, StudentEntity?>> getStudent(String entityId);
}
