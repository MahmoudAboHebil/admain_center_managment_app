import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_section_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/class_section_model.dart';
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

class LocalClassSectionDatasource
    implements LocalDbOperations<ClassSectionModel> {
  final AddEntityLocalUseCase _addEntityLocalUseCase;
  final AddOperationLocalUseCase _addOperationLocalUseCase;
  final PushSingleOperationUseCase _pushSingleOperationUseCase;
  final QueueRepository _queueRepository;
  final SyncRepository _syncRepository;
  final TableRepository _tableRepository;
  const LocalClassSectionDatasource(
    this._addEntityLocalUseCase,
    this._addOperationLocalUseCase,
    this._queueRepository,
    this._syncRepository,
    this._pushSingleOperationUseCase,
    this._tableRepository,
  );
  @override
  Future<Either<Failure, SyncResponse?>> create(ClassSectionModel model) async {
    final uuid = Uuid();
    final operation = Operation(
      id: uuid.v4(),
      entityId: model.entityId,
      centerId: model.centerId,
      action: OperationAction.create,
      table: DBTable.class_sections,
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
          table: DBTable.class_sections,
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
          table: DBTable.class_sections,
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
            table: DBTable.class_sections,
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

  Future<void> _updateEntity(ClassSectionModel model) async {
    final modelOne = model;

    final oldCollection = await IsarService.isar.classSectionCollections
        .filter()
        .entityIdEqualTo(modelOne.entityId)
        .findFirst();

    if (oldCollection != null) {
      final newCollection = ClassSectionCollection()
        ..id = oldCollection.id
        ..entityId = oldCollection.entityId
        ..centerId = modelOne.centerId
        ..byUser = modelOne.byUser
        ..byDevice = modelOne.byDevice
        ..isDeleted = modelOne.isDeleted
        ..version = modelOne.version
        ..createdAt = modelOne.createdAt.toUtc()
        ..updatedAt = modelOne.updatedAt.toUtc()
        ..startOn = modelOne.startOn.toUtc()
        ..endOn = modelOne.endOn.toUtc()
        ..day = modelOne.day
        ..classId = modelOne.classId;

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.classSectionCollections.put(newCollection);
      });
    } else {
      throw Exception(
        'there is no record in db for ${model.entityId} at ${DBTable.class_sections.name} table',
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> update(
    ClassSectionModel newModel,
  ) async {
    try {
      final uuid = Uuid();
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();

      ClassSectionModel modelEdited = newModel.copyWith(
        byDevice: deviceId,
        byUser: currentUserId,
        updatedAt: DateTime.now().toUtc(),
      );
      final operation = Operation(
        id: uuid.v4(),
        entityId: modelEdited.entityId,
        centerId: modelEdited.centerId,
        action: OperationAction.update,
        table: DBTable.class_sections,
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
            table: DBTable.class_sections,
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
  Future<Either<Failure, SyncResponse?>> softDelete(
    ClassSectionModel model,
  ) async {
    try {
      final uuid = Uuid();
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();
      ClassSectionModel modelEdited = model.copyWith(
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
        table: DBTable.class_sections,
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
          DBTable.class_sections,
          modelEdited.entityId,
        );
        return Right(null);
      } else {
        final sendResult = await _pushSingleOperationUseCase.call(
          PushSingleOperationUseCaseParams(
            table: DBTable.class_sections,
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
            DBTable.class_sections,
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
  Either<Failure, Stream<List<ClassSectionCollection>>> getCollectionsStream() {
    try {
      final stream = IsarService.isar.classSectionCollections
          .filter()
          .isDeletedEqualTo(false)
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
      return Right(stream);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to get Stream for classes section Collections $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ClassSectionModel?>> getModel(String entityID) async {
    try {
      final collection = await IsarService.isar.classSectionCollections
          .filter()
          .isDeletedEqualTo(false)
          .and()
          .entityIdEqualTo(entityID)
          .findFirst();
      if (collection == null) return Right(null);
      return Right(ClassSectionModel.fromCollection(collection));
    } catch (e) {
      return Left(
        ProcessingFailure(message: 'failed to get this $entityID class  '),
      );
    }
  }

  @override
  Future<Either<Failure, List<ClassSectionModel>>>
  getAllItemsNotArchived() async {
    try {
      List<ClassSectionModel> items = [];
      final collections = await IsarService.isar.classSectionCollections
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
      for (var item in collections) {
        items.add(ClassSectionModel.fromCollection(item));
      }
      return Right(items);
    } catch (e) {
      return Left(
        ProcessingFailure(message: 'failed to get classes sections '),
      );
    }
  }

  @override
  Either<Failure, Stream<int>> watchCollectionsCount() {
    try {
      final query = IsarService.isar.classSectionCollections
          .filter()
          .isDeletedEqualTo(false)
          .build();

      final stream = query.watchLazy(fireImmediately: true).asyncMap((_) {
        return query.count();
      });
      return Right(stream);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to get Stream for class sections count $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ClassSectionModel>>> getModelsNameStartWith(
    String name,
  ) {
    throw UnimplementedError();
  }
}
