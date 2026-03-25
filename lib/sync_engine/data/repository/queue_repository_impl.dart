import 'package:dart_either/src/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/enums/operation_action.dart';
import '../../../core/enums/operation_status.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/operation.dart';
import '../../domain/repository/queue_repository.dart';
import '../datasource/local_queue_datasource.dart';
import '../models/operation_model.dart';

class QueueRepositoryImpl extends QueueRepository {
  final LocalQueueDatasource _localQueueDatasource;
  QueueRepositoryImpl(this._localQueueDatasource);

  @override
  Future<Either<Failure, void>> addOperationToQueue(Operation operation) async {
    try {
      List<OperationModel> oldOperations = await _localQueueDatasource
          .getOperationsByEntityAscending(operation.entityId);

      final isThereCreatedOpers = oldOperations.any(
        (e) => e.action == OperationAction.create,
      );

      final isThereUpdatedOpers = oldOperations.any(
        (e) => e.action == OperationAction.update,
      );
      if (isThereCreatedOpers) {
        if (operation.action == OperationAction.update) {
          await _localQueueDatasource.removeOperationsByEntity(
            operation.entityId,
          );
          final newOperation = operation.copyWith(
            action: OperationAction.create,
          );
          await _localQueueDatasource.insertToQueue(
            OperationModel.fromOperation(newOperation),
          );
          return Right(null);
        } else if (operation.action == OperationAction.delete) {
          await _localQueueDatasource.removeOperationsByEntity(
            operation.entityId,
          );
          return Right(null);
        }
      }

      final isEntityDeleted = (operation.json["is_deleted"] as bool);
      if (isEntityDeleted && operation.action == OperationAction.update) {
        return Right(null);
      }
      await _localQueueDatasource.removeOperationsByEntity(operation.entityId);
      await _localQueueDatasource.insertToQueue(
        OperationModel.fromOperation(operation),
      );
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'Failed To add operation to Queue :${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> getOperationsByEntity(
    String entityId,
  ) async {
    try {
      final operationsModels = await _localQueueDatasource
          .getOperationsByEntityAscending(entityId);
      final operations = operationsModels
          .map((mode) => mode.toOperation())
          .toList();
      return Right(operations);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'Failed To get operation from Queue :${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Operation>>> getPendingOperationOrdered(
    DBTable dbTable,
  ) async {
    try {
      final operationsModels = await _localQueueDatasource
          .getPendingTableOperationAscending(dbTable);
      final operations = operationsModels
          .map((mode) => mode.toOperation())
          .toList();
      return Right(operations);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'Failed To get operation from Queue :${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeEntityOperations(String entityId) async {
    try {
      await _localQueueDatasource.removeOperationsByEntity(entityId);
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'Failed To delete operation from Queue :${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeOperationToQueue(
    String operationId,
  ) async {
    try {
      await _localQueueDatasource.removeFromQueue(operationId);
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'Failed To delete operation from Queue :${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateOperation({
    required String operationId,
    OperationState? state,
    int? retryCount,
    DateTime? lastAttemptAt,
    DateTime? nextRetryAt,
  }) async {
    try {
      await _localQueueDatasource.updateOperation(
        operationId: operationId,
        retryCount: retryCount,
        nextRetryAt: nextRetryAt,
        lastAttemptAt: lastAttemptAt,
        state: state,
      );
      return Right(null);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message:
              'Failed To update the state  operation from Queue :${e.toString()}',
        ),
      );
    }
  }
}
