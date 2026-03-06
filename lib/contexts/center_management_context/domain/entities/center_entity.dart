import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CenterEntity extends Equatable {
  const CenterEntity({
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
}
