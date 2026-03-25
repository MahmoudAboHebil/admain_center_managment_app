import 'package:dart_either/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/enums/operation_status.dart';
import '../../../core/error/failure.dart';
import '../entities/operation.dart';

abstract class QueueRepository {
  Future<Either<Failure, List<Operation>>> getPendingOperationOrdered(
    DBTable dbTable,
  );
  Future<Either<Failure, void>> addOperationToQueue(Operation operation);
  Future<Either<Failure, void>> updateOperation({
    required String operationId,
    OperationState? state,
    int? retryCount,
    DateTime? lastAttemptAt,
    DateTime? nextRetryAt,
  });
  Future<Either<Failure, void>> removeOperationToQueue(String operationId);
  Future<Either<Failure, void>> removeEntityOperations(String entityId);
  Future<Either<Failure, List<Operation>>> getOperationsByEntity(
    String entityId,
  );
}
