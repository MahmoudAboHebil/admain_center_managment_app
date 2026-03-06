import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/usecases/usecase.dart';
import 'package:dart_either/dart_either.dart';

class UpdateStudentUseCaseParams {
  final StudentEntity newEntity;
  const UpdateStudentUseCaseParams({required this.newEntity});
}

class UpdateStudentUseCase
    implements UseCase<Either<Failure, void>, UpdateStudentUseCaseParams> {
  final StudentRepository _studentRepository;
  const UpdateStudentUseCase(this._studentRepository);

  @override
  Future<Either<Failure, void>> call(UpdateStudentUseCaseParams params) async {
    return await _studentRepository.updateStudent(params.newEntity);
  }
}
