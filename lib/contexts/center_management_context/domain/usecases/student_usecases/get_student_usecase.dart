import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:admain_center_managment_app/core/usecases/usecase.dart';
import 'package:dart_either/dart_either.dart';

class GetStudentUseCaseParams {
  final String entityId;
  const GetStudentUseCaseParams({required this.entityId});
}

class GetStudentUseCase
    implements
        UseCase<Either<Failure, StudentEntity?>, GetStudentUseCaseParams> {
  final StudentRepository _studentRepository;
  const GetStudentUseCase(this._studentRepository);

  @override
  Future<Either<Failure, StudentEntity?>> call(
    GetStudentUseCaseParams params,
  ) async {
    return await _studentRepository.getStudent(params.entityId);
  }
}
