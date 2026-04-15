import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/standard_table_record.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ClassEntity extends StandardTableRecord with EquatableMixin {
  const ClassEntity({
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

  ClassEntity copyWith({
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
    return ClassEntity(
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
}
