import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_section_repository.dart';
import 'package:admain_center_managment_app/core/error/sync_response.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:dart_either/dart_either.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';

class DeleteClassSectionsUseCaseParams {
  final List<ClassSectionEntity> classSections;
  DeleteClassSectionsUseCaseParams(this.classSections);
}

class DeleteClassSectionsUseCase
    implements
        UseCase<
          Either<Failure, SyncResponse?>,
          DeleteClassSectionsUseCaseParams
        > {
  final ClassSectionRepository repository;
  DeleteClassSectionsUseCase({required this.repository});
  @override
  Future<Either<Failure, SyncResponse?>> call(params) {
    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(params.classSections.map((e) => e.entityId).toSet());
    return repository.softDeleteClassSections(
      params.classSections.map((e) => e.entityId).toSet(),
    );
  }
}
