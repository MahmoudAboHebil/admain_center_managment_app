import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_section_repository.dart';
import 'package:admain_center_managment_app/core/error/sync_response.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';

class CreateClassSectionUseCaseParams {
  final ClassSectionEntity entity;
  CreateClassSectionUseCaseParams(this.entity);
}

class CreateClassSectionUseCase
    implements
        UseCase<
          Either<Failure, SyncResponse?>,
          CreateClassSectionUseCaseParams
        > {
  final ClassSectionRepository repository;
  CreateClassSectionUseCase({required this.repository});
  @override
  Future<Either<Failure, SyncResponse?>> call(params) {
    return repository.createClassSection(params.entity);
  }
}
