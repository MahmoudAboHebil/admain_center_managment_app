import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/center_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CenterModel extends Equatable {
  const CenterModel({
    required this.entityId,
    required this.name,
    required this.byUser,
    required this.byDevice,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });
  final String entityId;
  final String name;

  final String byUser;
  final String byDevice;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
    entityId,
    name,
    byUser,
    byDevice,
    version,
    createdAt,
    updatedAt,
  ];

  factory CenterModel.fromCollection(CenterCollection collection) {
    return CenterModel(
      entityId: collection.entityId,
      name: collection.name,
      byUser: collection.byUser,
      byDevice: collection.byDevice,
      version: collection.version,
      createdAt: collection.createdAt.toUtc(),
      updatedAt: collection.updatedAt.toUtc(),
    );
  }
  CenterCollection toCollection() {
    return CenterCollection()
      ..entityId = entityId
      ..name = name
      ..byUser = byUser
      ..byDevice = byDevice
      ..version = version
      ..createdAt = createdAt.toUtc()
      ..updatedAt = updatedAt.toUtc();
  }
}
