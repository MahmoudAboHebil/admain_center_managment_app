import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_section_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/standard_table_record_model.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ClassSectionModel extends StandardTableRecordModel with EquatableMixin {
  const ClassSectionModel({
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

  // ================== FROM JSON ==================
  factory ClassSectionModel.fromJson(Map<String, dynamic> json) {
    return ClassSectionModel(
      entityId: json['id'],
      centerId: json['center_id'],
      byUser: json['by_user'],
      byDevice: json['by_device'],
      isDeleted: json['is_deleted'] ?? false,
      version: json['version'] ?? 0,

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toUtc()
          : DateTime.now().toUtc(),

      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at']).toUtc()
          : DateTime.now().toUtc(),
      classId: json['class_id'],
      day: json['day'],
      endOn: DateTime.parse(json['end_on']).toUtc(),
      startOn: DateTime.parse(json['start_on']).toUtc(),
    );
  }
  // ================== TO JSON ==================
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

  // ================== TO ENTITY ==================
  ClassSectionEntity toEntity() {
    return ClassSectionEntity(
      entityId: entityId,
      centerId: centerId,
      byUser: byUser,
      byDevice: byDevice,
      isDeleted: isDeleted,
      version: version,
      createdAt: createdAt.toUtc(),
      updatedAt: updatedAt.toUtc(),
      startOn: startOn.toUtc(),
      endOn: endOn.toUtc(),
      day: day,
      classId: classId,
    );
  }

  // ================== TO COLLECTION ==================
  ClassSectionCollection toCollection() {
    return ClassSectionCollection()
      ..entityId = entityId
      ..centerId = centerId
      ..byUser = byUser
      ..byDevice = byDevice
      ..isDeleted = isDeleted
      ..version = version
      ..createdAt = createdAt.toUtc()
      ..updatedAt = updatedAt.toUtc()
      ..startOn = startOn.toUtc()
      ..endOn = endOn.toUtc()
      ..day = day
      ..classId = classId;
  }

  // ================== FROM COLLECTION ==================
  factory ClassSectionModel.fromCollection(ClassSectionCollection c) {
    return ClassSectionModel(
      entityId: c.entityId,
      centerId: c.centerId,
      byUser: c.byUser,
      byDevice: c.byDevice,
      isDeleted: c.isDeleted,
      version: c.version,
      createdAt: c.createdAt.toUtc(),
      updatedAt: c.updatedAt.toUtc(),
      classId: c.classId,
      day: c.day,
      endOn: c.endOn.toUtc(),
      startOn: c.startOn.toUtc(),
    );
  }

  factory ClassSectionModel.fromEntity(ClassSectionEntity entity) {
    return ClassSectionModel(
      entityId: entity.entityId,
      centerId: entity.centerId,
      byUser: entity.byUser,
      byDevice: entity.byDevice,
      isDeleted: entity.isDeleted,
      version: entity.version,
      createdAt: entity.createdAt.toUtc(),
      updatedAt: entity.updatedAt.toUtc(),
      startOn: entity.startOn.toUtc(),
      endOn: entity.endOn.toUtc(),
      day: entity.day,
      classId: entity.classId,
    );
  }

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
    return entityId;
  }

  ClassSectionModel copyWith({
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
    return ClassSectionModel(
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
}
