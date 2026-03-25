import 'package:dart_either/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/operation.dart';
import '../repository/queue_repository.dart';

class GetTableQueueUseCaseParams {
  final DBTable table;

  const GetTableQueueUseCaseParams({required this.table});
}

class GetTableQueueUseCase
    implements
        UseCase<Either<Failure, List<Operation>>, GetTableQueueUseCaseParams> {
  final QueueRepository _repository;
  const GetTableQueueUseCase(this._repository);
  @override
  Future<Either<Failure, List<Operation>>> call(
    GetTableQueueUseCaseParams params,
  ) async {
    return await _repository.getPendingOperationOrdered(params.table);
  }
}
