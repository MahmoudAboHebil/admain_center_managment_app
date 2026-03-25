import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/sync_table_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/sync_response.dart';
import '../../../core/usecases/usecase.dart';
import '../repository/sync_repository.dart';

class SyncAllTablesUseCase
    implements UseCase<Either<Failure, List<SyncResponse>>, void> {
  final SyncTableUseCase _syncTableUseCase;
  final SyncRepository _syncRepository;
  const SyncAllTablesUseCase(this._syncTableUseCase, this._syncRepository);

  @override
  Future<Either<Failure, List<SyncResponse>>> call(void params) async {
    List<SyncResponse> results = [];
    DateTime now = DateTime.now();
    DateTime fiveMinutesAgo = now.subtract(Duration(minutes: 5));
    final getDeviceId = await _syncRepository.getDeviceId();
    if (getDeviceId.isLeft) {
      return Left(
        getDeviceId.fold(
          ifLeft: (l) => l,
          ifRight: (_) => ProcessingFailure(message: 'Please Try again Later'),
        ),
      );
    }
    final getLastSync = await _syncRepository.getLastSyncTime();
    if (getLastSync.isLeft) {
      return Left(
        getLastSync.fold(
          ifLeft: (l) => l,
          ifRight: (_) => ProcessingFailure(message: 'Please Try again Later'),
        ),
      );
    }
    final myDeviceId = getDeviceId.getOrThrow();
    final lastSyncTime = getLastSync.getOrThrow();

    for (var table in arrangedSyncTables) {
      final tableResults = await _syncTableUseCase.call(
        SyncTableUseCaseParams(
          table: table,
          deviceId: myDeviceId,
          centerId: currentCenter.entityId,
          lastSyncTime: lastSyncTime,
        ),
      );
      if (tableResults.isLeft) {
        return Left(
          tableResults.fold(
            ifLeft: (l) => l,
            ifRight: (_) =>
                ProcessingFailure(message: 'Please Try again Later'),
          ),
        );
      }
      final tabReut = tableResults.getOrThrow();
      final newList = {...results, ...tabReut}.toList();
      results = newList;
    }

    await _syncRepository.updateLastTimeSync(fiveMinutesAgo);

    return Right(results);
  }
}
