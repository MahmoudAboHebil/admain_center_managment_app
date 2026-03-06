import 'package:admain_center_managment_app/contexts/center_management_context/data/models/standard_table_record_model.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/core/enums/gender_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudentModel extends StandardTableRecordModel with EquatableMixin {
  const StudentModel({
    required super.entityId,
    required super.centerId,
    required super.byUser,
    required super.byDevice,
    required super.isDeleted,
    required super.version,
    required super.createdAt,
    required super.updatedAt,
    required this.studyLevelId,
    required this.name,
    this.phone,
    this.homePhone,
    this.whatsAppPhone,
    required this.schoolName,
    required this.gender,
    required this.birthDate,
    required this.joinDate,
    required this.studentStatus,
  });
  final String studyLevelId;
  final String name;
  final String? phone;
  final String? homePhone;
  final String? whatsAppPhone;
  final String schoolName;
  final Gender gender;
  final DateTime birthDate;
  final DateTime joinDate;
  final StudentStatus studentStatus;
  factory StudentModel.fromCollection(StudentCollection collection) {
    return StudentModel(
      entityId: collection.entityId,
      centerId: collection.centerId,
      byUser: collection.byUser,
      byDevice: collection.byDevice,
      isDeleted: collection.isDeleted,
      version: collection.version,
      createdAt: collection.createdAt.toUtc(),
      updatedAt: collection.updatedAt.toUtc(),
      studyLevelId: collection.studyLevelId,
      name: collection.name,
      schoolName: collection.schoolName,
      gender: Gender.getGenderEnumFromString(collection.gender),
      birthDate: collection.birthDate.toUtc(),
      joinDate: collection.joinDate.toUtc(),
      studentStatus: StudentStatus.getStudentStatusEnumFromString(
        collection.studentStatus,
      ),
      homePhone: collection.homePhone,
      phone: collection.phone,
      whatsAppPhone: collection.whatsAppPhone,
    );
  }
  factory StudentModel.fromEntity(StudentEntity entity) {
    return StudentModel(
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
      schoolName: entity.schoolName,
      gender: entity.gender,
      birthDate: entity.birthDate.toUtc(),
      joinDate: entity.joinDate.toUtc(),
      studentStatus: entity.studentStatus,
      homePhone: entity.homePhone,
      phone: entity.phone,
      whatsAppPhone: entity.whatsAppPhone,
    );
  }

  StudentEntity toEntity() {
    return StudentEntity(
      entityId: entityId,
      centerId: centerId,
      byUser: byUser,
      byDevice: byDevice,
      isDeleted: isDeleted,
      version: version,
      createdAt: createdAt.toUtc(),
      updatedAt: updatedAt.toUtc(),
      studyLevelId: studyLevelId,
      name: name,
      schoolName: schoolName,
      gender: gender,
      birthDate: birthDate.toUtc(),
      joinDate: joinDate.toUtc(),
      studentStatus: studentStatus,
      homePhone: homePhone,
      phone: phone,
      whatsAppPhone: whatsAppPhone,
    );
  }

  StudentCollection toCollection() {
    return StudentCollection()
      ..entityId = entityId
      ..centerId = centerId
      ..byUser = byUser
      ..byDevice = byDevice
      ..isDeleted = isDeleted
      ..version = version
      ..createdAt = createdAt.toUtc()
      ..updatedAt = updatedAt.toUtc()
      ..studyLevelId = studyLevelId
      ..name = name
      ..phone = phone
      ..homePhone = homePhone
      ..whatsAppPhone = whatsAppPhone
      ..schoolName = schoolName
      ..gender = gender.name
      ..birthDate = birthDate.toUtc()
      ..joinDate = joinDate.toUtc()
      ..studentStatus = studentStatus.name;
  }

  @override
  String toString() {
    return entityId;
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
    studyLevelId,
    name,
    phone,
    homePhone,
    whatsAppPhone,
    schoolName,
    gender,
    birthDate,
    joinDate,
    studentStatus,
  ];

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
      'study_level_id': studyLevelId,
      'name': name,
      'phone': phone,
      'home_phone': homePhone,
      'whats_app_phone': whatsAppPhone,
      'school_name': schoolName,
      'gender': gender.name,
      'birth_date': birthDate.toUtc().toIso8601String(),
      'join_date': joinDate.toUtc().toIso8601String(),
      'student_status': studentStatus.name,
    };
  }
}
