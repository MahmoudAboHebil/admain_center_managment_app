import 'package:dart_either/dart_either.dart';

import '../../../core/enums/DB_Table.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../repository/table_repository.dart';

class GetServerUpdatedRecordsUseCaseParams {
  final DBTable table;
  final String deviceId;
  final String centerId;
  final DateTime lastSyncTime;
  const GetServerUpdatedRecordsUseCaseParams({
    required this.table,
    required this.deviceId,
    required this.centerId,
    required this.lastSyncTime,
  });
}

class GetServerUpdatedRecordsUseCase
    implements
        UseCase<
          Either<Failure, List<Map<String, dynamic>>>,
          GetServerUpdatedRecordsUseCaseParams
        > {
  final TableRepository _repository;
  const GetServerUpdatedRecordsUseCase(this._repository);
  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> call(
    GetServerUpdatedRecordsUseCaseParams params,
  ) async {
    return await _repository.getUpdatedServerEntities(
      params.table,
      params.deviceId,
      params.lastSyncTime,
      params.centerId,
    );
  }
}
