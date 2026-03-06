import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/standard_table_record.dart';
import 'package:admain_center_managment_app/core/enums/gender_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudentEntity extends StandardTableRecord with EquatableMixin {
  const StudentEntity({
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
  String toString() {
    return entityId;
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
