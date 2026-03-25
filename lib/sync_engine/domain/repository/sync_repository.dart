import 'package:dart_either/dart_either.dart';

import '../../../core/error/failure.dart';
import '../../../core/error/netwrok_response.dart';
import '../entities/operation.dart';

abstract class SyncRepository {
  Future<Either<Failure, NetworkResponse>> sendOperationToServer(
    Operation operation,
    String deviceId,
  );
  Future<Either<Failure, DateTime>> getLastSyncTime();
  Future<Either<Failure, void>> updateLastTimeSync(DateTime timeAsUTC);
  Future<Either<Failure, String>> getDeviceId();
}
