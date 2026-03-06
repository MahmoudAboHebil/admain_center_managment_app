import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/usecases/usecase.dart';
import 'package:dart_either/dart_either.dart';

class SoftDeleteStudentUseCaseParams {
  final String entityId;
  const SoftDeleteStudentUseCaseParams({required this.entityId});
}

class SoftDeleteStudentUseCase
    implements UseCase<Either<Failure, void>, SoftDeleteStudentUseCaseParams> {
  final StudentRepository _studentRepository;
  const SoftDeleteStudentUseCase(this._studentRepository);

  @override
  Future<Either<Failure, void>> call(
    SoftDeleteStudentUseCaseParams params,
  ) async {
    return await _studentRepository.softDeleteStudent(params.entityId);
  }
}
