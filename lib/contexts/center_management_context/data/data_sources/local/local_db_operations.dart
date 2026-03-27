import 'package:dart_either/dart_either.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/error/sync_response.dart';

abstract class LocalDbOperations<T> {
  Future<Either<Failure, SyncResponse?>> softDelete(T entity);
  Future<Either<Failure, SyncResponse?>> update(T newEntity);
  Future<Either<Failure, SyncResponse?>> create(T entity);
  Future<Either<Failure, T?>> getEntity(String entityID);
  Future<Either<Failure, List<T>>> getEntitiesNameStartWith(String name);
  Either<Failure, Stream> getCollectionsStream();
  Either<Failure, Stream> watchStudentsCount();
  Future<Either<Failure, List<T>>> getAllItemsNotArchived();
}
