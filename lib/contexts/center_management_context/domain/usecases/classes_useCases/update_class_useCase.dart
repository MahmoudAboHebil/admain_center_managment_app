import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_repository.dart';
import 'package:admain_center_managment_app/core/error/sync_response.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';

class UpdateClassUseCaseParams {
  final ClassEntity updatedClass;
  UpdateClassUseCaseParams(this.updatedClass);
}

class UpdateClassUseCase
    implements
        UseCase<Either<Failure, SyncResponse?>, UpdateClassUseCaseParams> {
  final ClassRepository repository;
  UpdateClassUseCase({required this.repository});
  @override
  Future<Either<Failure, SyncResponse?>> call(params) {
    return repository.updateClass(params.updatedClass);
  }
}
