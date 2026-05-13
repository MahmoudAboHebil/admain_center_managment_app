import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_model.dart';
import 'package:dart_either/dart_either.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/enums/DB_Table.dart';
import '../../../../../core/enums/operation_action.dart';
import '../../../../../core/enums/operation_status.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/error/netwrok_response.dart';
import '../../../../../core/error/sync_response.dart';
import '../../../../../core/isar_local_database/isar/isar_service.dart';
import '../../../../../sync_engine/domain/entities/operation.dart';
import '../../../../../sync_engine/domain/repository/queue_repository.dart';
import '../../../../../sync_engine/domain/repository/sync_repository.dart';
import '../../../../../sync_engine/domain/repository/table_repository.dart';
import '../../../../../sync_engine/domain/use_cases/add_entity_local_usecase.dart';
import '../../../../../sync_engine/domain/use_cases/add_operation_local_usecase.dart';
import '../../../../../sync_engine/domain/use_cases/push_single_operation_usecase.dart';

class LocalClassDatasource implements LocalDbOperations<ClassModel> {
  final AddEntityLocalUseCase _addEntityLocalUseCase;
  final AddOperationLocalUseCase _addOperationLocalUseCase;
  final PushSingleOperationUseCase _pushSingleOperationUseCase;
  final QueueRepository _queueRepository;
  final SyncRepository _syncRepository;
  final TableRepository _tableRepository;
  const LocalClassDatasource(
    this._addEntityLocalUseCase,
    this._addOperationLocalUseCase,
    this._queueRepository,
    this._syncRepository,
    this._pushSingleOperationUseCase,
    this._tableRepository,
  );
  @override
  Future<Either<Failure, SyncResponse?>> create(ClassModel model) async {
    final uuid = Uuid();
    final operation = Operation(
      id: uuid.v4(),
      entityId: model.entityId,
      centerId: model.centerId,
      action: OperationAction.create,
      table: DBTable.classes,
      json: model.toJson(),
      version: 1,
      userRole: currentUserRole,
      createdBy: currentUserId,
      createdAt: DateTime.now().toUtc(),
      retryCount: 0,
      lastAttemptAt: DateTime.now().toUtc(),
      nextRetryAt: DateTime.now().toUtc(),
      status: OperationState.pending,
    );

    final bool hasInternet = await InternetConnection().hasInternetAccess;

    if (!hasInternet) {
      final addResult = await _addOperationLocalUseCase.call(
        AddOperationLocalUseCaseParams(operation: operation),
      );

      if (addResult.isLeft) {
        return Left(
          addResult.fold(
            ifLeft: (l) => l,
            ifRight: (_) =>
                ProcessingFailure(message: 'Please Try again Later'),
          ),
        );
      }

      final result = await _addEntityLocalUseCase.call(
        AddEntityLocalUseCaseParams(
          table: DBTable.classes,
          jsonEntity: null,
          entity: model.toEntity(),
        ),
      );
      if (result.isLeft) {
        await _queueRepository.removeOperationToQueue(operation.id);
        return Left(
          result.fold(
            ifLeft: (l) => l,
            ifRight: (_) =>
                ProcessingFailure(message: 'Please Try again Later'),
          ),
        );
      }
      return Right(null);
    } else {
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();
      final sendResult = await _pushSingleOperationUseCase.call(
        PushSingleOperationUseCaseParams(
          table: DBTable.classes,
          deviceId: deviceId,
          operation: operation,
        ),
      );

      if (sendResult.isLeft) {
        return Left(
          sendResult.fold(
            ifLeft: (l) => l,
            ifRight: (_) =>
                ProcessingFailure(message: 'Please Try again Later'),
          ),
        );
      }

      final sendData = sendResult.getOrThrow();
      if (sendData.networkResponse is NetworkSuccess &&
          sendData.networkResponse is! OperationAlreadyProcessed &&
          sendData.isError != true) {
        final result = await _addEntityLocalUseCase.call(
          AddEntityLocalUseCaseParams(
            table: DBTable.classes,
            jsonEntity: null,
            entity: model.toEntity(),
          ),
        );
        if (result.isLeft) {
          return Left(
            result.fold(
              ifLeft: (l) => l,
              ifRight: (_) =>
                  ProcessingFailure(message: 'Please Try again Later'),
            ),
          );
        }
        return Right(null);
      }
      return Right(sendData);
    }
  }

  Future<void> _updateEntity(ClassModel model) async {
    final modelOne = model;

    final oldCollection = await IsarService.isar.classCollections
        .filter()
        .entityIdEqualTo(modelOne.entityId)
        .findFirst();

    if (oldCollection != null) {
      final newCollection = ClassCollection()
        ..id = oldCollection.id
        ..entityId = oldCollection.entityId
        ..centerId = modelOne.centerId
        ..byUser = modelOne.byUser
        ..byDevice = modelOne.byDevice
        ..isDeleted = modelOne.isDeleted
        ..version = modelOne.version
        ..createdAt = modelOne.createdAt.toUtc()
        ..updatedAt = modelOne.updatedAt.toUtc()
        ..name = modelOne.name
        ..room = modelOne.room
        ..semester = modelOne.semester
        ..divisionEnum = modelOne.divisionEnum.name
        ..studyLevelId = modelOne.studyLevelId;

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.classCollections.put(newCollection);
      });
    } else {
      throw Exception(
        'there is no record in db for ${model.entityId} at ${DBTable.classes.name} table',
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> update(ClassModel newModel) async {
    try {
      final uuid = Uuid();
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();

      ClassModel modelEdited = newModel.copyWith(
        byDevice: deviceId,
        byUser: currentUserId,
        updatedAt: DateTime.now().toUtc(),
      );
      final operation = Operation(
        id: uuid.v4(),
        entityId: modelEdited.entityId,
        centerId: modelEdited.centerId,
        action: OperationAction.update,
        table: DBTable.classes,
        json: modelEdited.toJson(),
        version: modelEdited.version,
        userRole: currentUserRole,
        createdBy: currentUserId,
        createdAt: DateTime.now().toUtc(),
        retryCount: 0,
        lastAttemptAt: DateTime.now().toUtc(),
        nextRetryAt: DateTime.now().toUtc(),
        status: OperationState.pending,
      );
      final bool hasInternet = await InternetConnection().hasInternetAccess;

      if (!hasInternet) {
        final addResult = await _addOperationLocalUseCase.call(
          AddOperationLocalUseCaseParams(operation: operation),
        );

        if (addResult.isLeft) {
          return Left(
            addResult.fold(
              ifLeft: (l) => l,
              ifRight: (_) =>
                  ProcessingFailure(message: 'Please Try again Later'),
            ),
          );
        }

        await _updateEntity(modelEdited);
        return Right(null);
      } else {
        final sendResult = await _pushSingleOperationUseCase.call(
          PushSingleOperationUseCaseParams(
            table: DBTable.classes,
            deviceId: deviceId,
            operation: operation,
          ),
        );

        if (sendResult.isLeft) {
          return Left(
            sendResult.fold(
              ifLeft: (l) => l,
              ifRight: (_) =>
                  ProcessingFailure(message: 'Please Try again Later'),
            ),
          );
        }
        final sendData = sendResult.getOrThrow();

        if (sendData.networkResponse is NetworkSuccess &&
            sendData.networkResponse is! OperationAlreadyProcessed &&
            sendData.isError != true) {
          await _updateEntity(modelEdited);
          return Right(null);
        }

        return Right(sendData);
      }
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to update for ${newModel.entityId} $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDelete(ClassModel model) async {
    try {
      final uuid = Uuid();
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();
      ClassModel modelEdited = model.copyWith(
        isDeleted: true,
        byDevice: deviceId,
        byUser: currentUserId,
        updatedAt: DateTime.now().toUtc(),
      );
      final operation = Operation(
        id: uuid.v4(),
        entityId: modelEdited.entityId,
        centerId: modelEdited.centerId,
        action: OperationAction.delete,
        table: DBTable.classes,
        json: modelEdited.toJson(),
        version: modelEdited.version,
        userRole: currentUserRole,
        createdBy: currentUserId,
        createdAt: DateTime.now().toUtc(),
        retryCount: 0,
        lastAttemptAt: DateTime.now().toUtc(),
        nextRetryAt: DateTime.now().toUtc(),
        status: OperationState.pending,
      );
      final bool hasInternet = await InternetConnection().hasInternetAccess;

      if (!hasInternet) {
        final addResult = await _addOperationLocalUseCase.call(
          AddOperationLocalUseCaseParams(operation: operation),
        );

        if (addResult.isLeft) {
          return Left(
            addResult.fold(
              ifLeft: (l) => l,
              ifRight: (_) =>
                  ProcessingFailure(message: 'Please Try again Later'),
            ),
          );
        }
        await _tableRepository.deleteEntityCascadeNotNull(
          DBTable.classes,
          modelEdited.entityId,
        );
        return Right(null);
      } else {
        final sendResult = await _pushSingleOperationUseCase.call(
          PushSingleOperationUseCaseParams(
            table: DBTable.classes,
            deviceId: deviceId,
            operation: operation,
          ),
        );

        if (sendResult.isLeft) {
          return Left(
            sendResult.fold(
              ifLeft: (l) => l,
              ifRight: (_) =>
                  ProcessingFailure(message: 'Please Try again Later'),
            ),
          );
        }
        final sendData = sendResult.getOrThrow();
        if (sendData.networkResponse is! InternalServerError &&
            sendData.isError != true) {
          await _tableRepository.deleteEntityCascadeNotNull(
            DBTable.classes,
            modelEdited.entityId,
          );
          return Right(null);
        }
        return Right(sendData);
      }
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to softDelete for ${model.entityId} $e ',
        ),
      );
    }
  }

  @override
  Either<Failure, Stream<List<ClassCollection>>> getCollectionsStream() {
    try {
      final stream = IsarService.isar.classCollections
          .filter()
          .isDeletedEqualTo(false)
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
      return Right(stream);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to get Stream for classes Collections $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ClassModel?>> getModel(String entityID) async {
    try {
      final collection = await IsarService.isar.classCollections
          .filter()
          .isDeletedEqualTo(false)
          .and()
          .entityIdEqualTo(entityID)
          .findFirst();
      if (collection == null) return Right(null);
      return Right(ClassModel.fromCollection(collection));
    } catch (e) {
      return Left(
        ProcessingFailure(message: 'failed to get this $entityID class  '),
      );
    }
  }

  @override
  Future<Either<Failure, List<ClassModel>>> getAllItemsNotArchived() async {
    try {
      List<ClassModel> items = [];
      final collections = await IsarService.isar.classCollections
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
      for (var item in collections) {
        items.add(ClassModel.fromCollection(item));
      }
      return Right(items);
    } catch (e) {
      return Left(ProcessingFailure(message: 'failed to get classes  '));
    }
  }

  @override
  Either<Failure, Stream<int>> watchCollectionsCount() {
    try {
      final query = IsarService.isar.classCollections
          .filter()
          .isDeletedEqualTo(false)
          .build();

      final stream = query.watchLazy(fireImmediately: true).asyncMap((_) {
        return query.count();
      });
      return Right(stream);
    } catch (e) {
      return Left(
        ProcessingFailure(message: 'failed to get Stream for class count $e '),
      );
    }
  }

  @override
  Future<Either<Failure, List<ClassModel>>> getModelsNameStartWith(
    String name,
  ) async {
    try {
      final collections = await IsarService.isar.classCollections
          .filter()
          .isDeletedEqualTo(false)
          .and()
          .nameStartsWith(name, caseSensitive: false)
          .findAll();

      final list = collections
          .map((item) => ClassModel.fromCollection(item))
          .toList();

      return Right(list);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to get models NameStartWith $name class  ',
        ),
      );
    }
  }
}
