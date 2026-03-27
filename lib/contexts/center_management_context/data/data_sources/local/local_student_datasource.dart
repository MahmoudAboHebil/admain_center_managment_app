import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_db_operations.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/student_model.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
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

class LocalStudentDatasource implements LocalDbOperations<StudentEntity> {
  final AddEntityLocalUseCase _addEntityLocalUseCase;
  final AddOperationLocalUseCase _addOperationLocalUseCase;
  final PushSingleOperationUseCase _pushSingleOperationUseCase;
  final QueueRepository _queueRepository;
  final SyncRepository _syncRepository;
  final TableRepository _tableRepository;
  const LocalStudentDatasource(
    this._addEntityLocalUseCase,
    this._addOperationLocalUseCase,
    this._queueRepository,
    this._syncRepository,
    this._pushSingleOperationUseCase,
    this._tableRepository,
  );
  @override
  Future<Either<Failure, SyncResponse?>> create(StudentEntity entity) async {
    final uuid = Uuid();
    final operation = Operation(
      id: uuid.v4(),
      entityId: entity.entityId,
      centerId: entity.centerId,
      action: OperationAction.create,
      table: DBTable.students,
      json: entity.toJson(),
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
          table: DBTable.students,
          jsonEntity: null,
          entity: entity,
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
          table: DBTable.students,
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
            table: DBTable.students,
            jsonEntity: null,
            entity: entity,
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

  Future<void> _updateEntity(StudentModel model) async {
    final modelOne = model;

    final oldCollection = await IsarService.isar.studentCollections
        .filter()
        .entityIdEqualTo(modelOne.entityId)
        .findFirst();

    if (oldCollection != null) {
      final newCollection = StudentCollection()
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
        ..studyLevelId = modelOne.studyLevelId
        ..studentCode = modelOne.studentCode
        ..gender = modelOne.gender.name
        ..studentStatus = modelOne.studentStatus.name
        ..email = modelOne.email
        ..address = modelOne.address
        ..phone = modelOne.phone
        ..homePhone = modelOne.homePhone
        ..parentPhone = modelOne.parentPhone
        ..parentJob = modelOne.parentJob
        ..schoolName = modelOne.schoolName
        ..bookingDeposit = modelOne.bookingDeposit
        ..studentClasses = modelOne.studentClasses
        ..notes = modelOne.notes
        ..paymentTypeEnum = modelOne.paymentTypeEnum?.name
        ..divisionEnum = modelOne.divisionEnum?.name
        ..birthDate = modelOne.birthDate?.toUtc();

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.studentCollections.put(newCollection);
      });
    } else {
      throw Exception(
        'there is no record in db for ${model.entityId} at ${DBTable.students.name} table',
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> update(StudentEntity newEntity) async {
    try {
      final uuid = Uuid();
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();

      StudentEntity entityEdited = newEntity.copyWith(
        byDevice: deviceId,
        byUser: currentUserId,
        updatedAt: DateTime.now().toUtc(),
      );
      final operation = Operation(
        id: uuid.v4(),
        entityId: entityEdited.entityId,
        centerId: entityEdited.centerId,
        action: OperationAction.update,
        table: DBTable.students,
        json: entityEdited.toJson(),
        version: entityEdited.version,
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

        await _updateEntity(StudentModel.fromEntity(entityEdited));
        return Right(null);
      } else {
        final sendResult = await _pushSingleOperationUseCase.call(
          PushSingleOperationUseCaseParams(
            table: DBTable.students,
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
          await _updateEntity(StudentModel.fromEntity(entityEdited));
          return Right(null);
        }

        return Right(sendData);
      }
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to update for ${newEntity.entityId} $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SyncResponse?>> softDelete(
    StudentEntity entity,
  ) async {
    try {
      final uuid = Uuid();
      final deviceIdResult = await _syncRepository.getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();
      StudentEntity entityEdited = entity.copyWith(
        isDeleted: true,
        byDevice: deviceId,
        byUser: currentUserId,
        updatedAt: DateTime.now().toUtc(),
      );
      final operation = Operation(
        id: uuid.v4(),
        entityId: entityEdited.entityId,
        centerId: entityEdited.centerId,
        action: OperationAction.delete,
        table: DBTable.students,
        json: entityEdited.toJson(),
        version: entityEdited.version,
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
          DBTable.students,
          entity.entityId,
        );
        return Right(null);
      } else {
        final sendResult = await _pushSingleOperationUseCase.call(
          PushSingleOperationUseCaseParams(
            table: DBTable.students,
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
            DBTable.students,
            entity.entityId,
          );
          return Right(null);
        }
        return Right(sendData);
      }
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to softDelete for ${entity.entityId} $e ',
        ),
      );
    }
  }

  @override
  Either<Failure, Stream<List<StudentCollection>>> getCollectionsStream() {
    try {
      final stream = IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .sortByCreatedAtDesc()
          .watch(fireImmediately: true);
      return Right(stream);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to get Stream for student Collections $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, StudentEntity?>> getEntity(String entityID) async {
    try {
      final collection = await IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .and()
          .entityIdEqualTo(entityID)
          .findFirst();
      if (collection == null) return Right(null);
      return Right(StudentModel.fromCollection(collection).toEntity());
    } catch (e) {
      return Left(
        ProcessingFailure(message: 'failed to get this $entityID student  '),
      );
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getAllItemsNotArchived() async {
    try {
      List<StudentEntity> items = [];
      final collections = await IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .findAll();
      for (var item in collections) {
        items.add(StudentModel.fromCollection(item).toEntity());
      }
      return Right(items);
    } catch (e) {
      return Left(ProcessingFailure(message: 'failed to students  '));
    }
  }

  @override
  Either<Failure, Stream<int>> watchStudentsCount() {
    try {
      final query = IsarService.isar.studentCollections
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
          message: 'failed to get Stream for student count $e ',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<StudentEntity>>> getEntitiesNameStartWith(
    String name,
  ) async {
    try {
      final collections = await IsarService.isar.studentCollections
          .filter()
          .isDeletedEqualTo(false)
          .and()
          .nameStartsWith(name, caseSensitive: false)
          .findAll();

      final list = collections
          .map((item) => StudentModel.fromCollection(item).toEntity())
          .toList();

      return Right(list);
    } catch (e) {
      return Left(
        ProcessingFailure(
          message: 'failed to get Entities NameStartWith $name student  ',
        ),
      );
    }
  }
}
