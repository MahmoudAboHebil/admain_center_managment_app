import 'package:dart_either/dart_either.dart';

import '../../../core/error/failure.dart';
import '../../../core/error/netwrok_response.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/operation.dart';
import '../repository/sync_repository.dart';

class SendOperationToServerUseCaseParams {
  final Operation operation;
  final String deviceId;
  const SendOperationToServerUseCaseParams({
    required this.operation,
    required this.deviceId,
  });
}

class SendOperationToServerUseCase
    implements
        UseCase<Either<Failure, void>, SendOperationToServerUseCaseParams> {
  final SyncRepository _repository;
  const SendOperationToServerUseCase(this._repository);
  @override
  Future<Either<Failure, NetworkResponse>> call(
    SendOperationToServerUseCaseParams params,
  ) async {
    return await _repository.sendOperationToServer(
      params.operation,
      params.deviceId,
    );
  }
}
