import 'package:admain_center_managment_app/sync_engine/domain/use_cases/pull_single_table_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/push_single_table_usecase.dart';
import 'package:dart_either/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/error/failure.dart';
import '../../../core/error/sync_response.dart';
import '../../../core/usecases/usecase.dart';

class SyncTableUseCaseParams {
  final DBTable table;
  final String deviceId;
  final String centerId;
  final DateTime lastSyncTime;
  const SyncTableUseCaseParams({
    required this.table,
    required this.deviceId,
    required this.centerId,
    required this.lastSyncTime,
  });
}

class SyncTableUseCase
    implements
        UseCase<Either<Failure, List<SyncResponse>>, SyncTableUseCaseParams> {
  final PullSingleTableUseCase _pullSingleTableUseCase;
  final PushSingleTableUseCase _pushSingleTableUseCase;
  const SyncTableUseCase(
    this._pullSingleTableUseCase,
    this._pushSingleTableUseCase,
  );

  @override
  Future<Either<Failure, List<SyncResponse>>> call(
    SyncTableUseCaseParams params,
  ) async {
    List<SyncResponse> results = [];
    final pushResults = await _pushSingleTableUseCase.call(
      PushSingleTableUseCaseParams(
        table: params.table,
        deviceId: params.deviceId,
      ),
    );
    if (pushResults.isLeft) {
      return Left(
        pushResults.fold(
          ifLeft: (l) => l,
          ifRight: (_) => ProcessingFailure(message: 'Please Try again Later'),
        ),
      );
    }
    final pushRetData = pushResults.getOrThrow();

    final pullResults = await _pullSingleTableUseCase.call(
      PullSingleTableUseCaseParams(
        table: params.table,
        deviceId: params.deviceId,
        centerId: params.centerId,
        lastSyncTime: params.lastSyncTime,
      ),
    );
    if (pullResults.isLeft) {
      return Left(
        pullResults.fold(
          ifLeft: (l) => l,
          ifRight: (_) => ProcessingFailure(message: 'Please Try again Later'),
        ),
      );
    }
    final pullRetData = pullResults.getOrThrow();

    results = [...pushRetData, ...pullRetData];

    return Right(results);
  }
}
