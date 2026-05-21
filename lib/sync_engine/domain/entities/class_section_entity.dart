import 'package:admain_center_managment_app/sync_engine/domain/entities/standard_table_record.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ClassSectionEntity extends StandardTableRecord with EquatableMixin {
  const ClassSectionEntity({
    required super.entityId,
    required super.centerId,
    required super.byUser,
    required super.byDevice,
    required super.isDeleted,
    required super.version,
    required super.createdAt,
    required super.updatedAt,
    required this.startOn,
    required this.endOn,
    required this.day,
    required this.classId,
  });
  final DateTime startOn;
  final DateTime endOn;
  final int day;
  final String classId;

  @override
  List<Object?> get props => [
    entityId,
    centerId,
    byUser,
    byDevice,
    isDeleted,
    version,
    createdAt,
    updatedAt,
    startOn,
    endOn,
    day,
    classId,
  ];

  @override
  String toString() {
    return '$entityId {startOn: $startOn, endOn: $endOn, day: $day}';
  }

  ClassSectionEntity copyWith({
    String? entityId,
    String? centerId,
    String? byUser,
    String? byDevice,
    bool? isDeleted,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startOn,
    DateTime? endOn,
    int? day,
    String? classId,
  }) {
    return ClassSectionEntity(
      entityId: entityId ?? this.entityId,
      centerId: centerId ?? this.centerId,
      byUser: byUser ?? this.byUser,
      byDevice: byDevice ?? this.byDevice,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startOn: startOn ?? this.startOn,
      endOn: endOn ?? this.endOn,
      day: day ?? this.day,
      classId: classId ?? this.classId,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': entityId,
      'center_id': centerId,
      'by_user': byUser,
      'by_device': byDevice,
      'is_deleted': isDeleted,
      'version': version,
      'created_at': createdAt.toUtc().toIso8601String(),
      'updated_at': updatedAt.toUtc().toIso8601String(),
      'start_on': startOn.toUtc().toIso8601String(),
      'end_on': endOn.toUtc().toIso8601String(),
      'class_id': classId,
      'day': day,
    };
  }
}
