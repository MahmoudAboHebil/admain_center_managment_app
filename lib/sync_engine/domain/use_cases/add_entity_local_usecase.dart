import 'package:dart_either/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/standard_table_record.dart';
import '../repository/table_repository.dart';

class AddEntityLocalUseCaseParams {
  final DBTable table;
  final Map<String, dynamic>? jsonEntity;
  final StandardTableRecord? entity;
  const AddEntityLocalUseCaseParams({
    required this.table,
    required this.jsonEntity,
    required this.entity,
  });
}

class AddEntityLocalUseCase
    implements UseCase<Either<Failure, void>, AddEntityLocalUseCaseParams> {
  final TableRepository _repository;
  const AddEntityLocalUseCase(this._repository);
  @override
  Future<Either<Failure, void>> call(AddEntityLocalUseCaseParams params) async {
    return await _repository.insertEntityToTable(
      params.table,
      params.jsonEntity,
      params.entity,
    );
  }
}
