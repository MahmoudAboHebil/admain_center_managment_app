import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/usecases/usecase.dart';
import 'package:dart_either/dart_either.dart';

class CreateStudentUseCaseParams {
  final StudentEntity entity;
  const CreateStudentUseCaseParams({required this.entity});
}

class CreateStudentUseCase
    implements UseCase<Either<Failure, void>, CreateStudentUseCaseParams> {
  final StudentRepository _studentRepository;
  const CreateStudentUseCase(this._studentRepository);

  @override
  Future<Either<Failure, void>> call(CreateStudentUseCaseParams params) async {
    return await _studentRepository.createStudent(params.entity);
  }
}
