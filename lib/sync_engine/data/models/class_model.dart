import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/class_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/standard_table_record_model.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ClassModel extends StandardTableRecordModel with EquatableMixin {
  const ClassModel({
    required super.entityId,
    required super.centerId,
    required super.byUser,
    required super.byDevice,
    required super.isDeleted,
    required super.version,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.room,
    required this.studyLevelId,
    required this.divisionEnum,
    required this.semester,
  });
  final String name;
  final String room;
  final String studyLevelId;
  final DivisionEnum divisionEnum;
  final int semester;

  // ================== FROM JSON ==================
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
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

      name: json['name'] ?? '',
      studyLevelId: json['study_level_id'] ?? '',
      divisionEnum: DivisionEnum.values.firstWhere(
        (e) => e.name == json['division'],
      ),
      room: json['room'] ?? '',
      semester: json['semester'] ?? 1,
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
      'name': name,
      'semester': semester,
      'room': room,
      'division': divisionEnum.name,
      'study_level_id': studyLevelId,
    };
  }

  // ================== TO ENTITY ==================
  ClassEntity toEntity() {
    return ClassEntity(
      entityId: entityId,
      centerId: centerId,
      byUser: byUser,
      byDevice: byDevice,
      isDeleted: isDeleted,
      version: version,
      createdAt: createdAt.toUtc(),
      updatedAt: updatedAt.toUtc(),
      studyLevelId: studyLevelId,
      semester: semester,
      room: room,
      divisionEnum: divisionEnum,
      name: name,
    );
  }

  // ================== TO COLLECTION ==================
  ClassCollection toCollection() {
    return ClassCollection()
      ..entityId = entityId
      ..centerId = centerId
      ..byUser = byUser
      ..byDevice = byDevice
      ..isDeleted = isDeleted
      ..version = version
      ..createdAt = createdAt.toUtc()
      ..updatedAt = updatedAt.toUtc()
      ..name = name
      ..studyLevelId = studyLevelId
      ..room = room
      ..divisionEnum = divisionEnum.name
      ..semester = semester;
  }

  // ================== FROM COLLECTION ==================
  factory ClassModel.fromCollection(ClassCollection c) {
    return ClassModel(
      entityId: c.entityId,
      centerId: c.centerId,
      byUser: c.byUser,
      byDevice: c.byDevice,
      isDeleted: c.isDeleted,
      version: c.version,
      createdAt: c.createdAt.toUtc(),
      updatedAt: c.updatedAt.toUtc(),
      name: c.name,
      studyLevelId: c.studyLevelId,
      divisionEnum: DivisionEnum.getDivisionFromString(c.divisionEnum),
      room: c.room,
      semester: c.semester,
    );
  }
  factory ClassModel.fromEntity(ClassEntity entity) {
    return ClassModel(
      entityId: entity.entityId,
      centerId: entity.centerId,
      byUser: entity.byUser,
      byDevice: entity.byDevice,
      isDeleted: entity.isDeleted,
      version: entity.version,
      createdAt: entity.createdAt.toUtc(),
      updatedAt: entity.updatedAt.toUtc(),
      studyLevelId: entity.studyLevelId,
      name: entity.name,
      semester: entity.semester,
      room: entity.room,
      divisionEnum: entity.divisionEnum,
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
    name,
    room,
    studyLevelId,
    divisionEnum,
    semester,
  ];
  @override
  String toString() {
    return entityId;
  }

  ClassModel copyWith({
    String? entityId,
    String? centerId,
    String? byUser,
    String? byDevice,
    bool? isDeleted,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,

    String? name,
    String? room,
    String? studyLevelId,
    DivisionEnum? divisionEnum,
    int? semester,
  }) {
    return ClassModel(
      entityId: entityId ?? this.entityId,
      centerId: centerId ?? this.centerId,
      byUser: byUser ?? this.byUser,
      byDevice: byDevice ?? this.byDevice,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      room: room ?? this.room,
      studyLevelId: studyLevelId ?? this.studyLevelId,
      divisionEnum: divisionEnum ?? this.divisionEnum,
      semester: semester ?? this.semester,
    );
  }
}
