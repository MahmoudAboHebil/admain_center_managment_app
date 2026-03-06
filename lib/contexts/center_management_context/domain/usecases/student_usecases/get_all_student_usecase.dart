import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/usecases/usecase.dart';
import 'package:dart_either/dart_either.dart';

class GetAllStudentUseCase
    implements UseCase<Either<Failure, List<StudentEntity>>, void> {
  final StudentRepository _studentRepository;
  const GetAllStudentUseCase(this._studentRepository);

  @override
  Future<Either<Failure, List<StudentEntity>>> call(void params) async {
    return await _studentRepository.getAllStudents();
  }
}
