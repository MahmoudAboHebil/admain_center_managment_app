import 'package:equatable/equatable.dart';

import '../../sync_engine/domain/entities/operation.dart';
import '../enums/DB_Table.dart';
import 'netwrok_response.dart';

class SyncResponse extends Equatable {
  final Operation? operation;
  final bool isError;
  final bool? willTry;
  final bool? isPullRecordeDeleted;
  final bool isPull;
  final Map<String, dynamic>? updatedPullData;
  final Map<String, dynamic>? insertPullData;
  final NetworkResponse? networkResponse;
  final Map<DBTable, List<String>>? deletedEntities;
  const SyncResponse({
    this.networkResponse,
    this.operation,
    this.deletedEntities,
    this.willTry,
    this.updatedPullData,
    this.insertPullData,
    this.isError = false,
    this.isPull = false,
    this.isPullRecordeDeleted = false,
  });

  @override
  String toString() {
    return """
    isPull = ${isPull}
    isPullRecordeDeleted = ${isPullRecordeDeleted}
    updatedPullData = ${updatedPullData}
    insertPullData = ${insertPullData}
    networkResponse = ${networkResponse.toString()}
    isError     = ${isError}
    willTry     = ${willTry}
    deletedEntities     = ${deletedEntities}

    """;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    isPullRecordeDeleted,
    updatedPullData,
    insertPullData,
    operation,
    isError,
    isPull,
    willTry,
    networkResponse,
    deletedEntities,
  ];
}
