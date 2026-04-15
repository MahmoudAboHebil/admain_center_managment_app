import 'package:admain_center_managment_app/core/enums/payment_type_enum.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/standard_table_record.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudentClassEnrollmentsEntity extends StandardTableRecord
    with EquatableMixin {
  const StudentClassEnrollmentsEntity({
    required super.entityId,
    required super.centerId,
    required super.byUser,
    required super.byDevice,
    required super.isDeleted,
    required super.version,
    required super.createdAt,
    required super.updatedAt,
    required this.studentId,
    required this.classId,
    required this.paymentType,
  });

  final String studentId;
  final String classId;
  final PaymentTypeEnum paymentType;
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
    studentId,
    classId,
    paymentType,
  ];
  @override
  String toString() {
    return entityId;
  }

  StudentClassEnrollmentsEntity copyWith({
    String? entityId,
    String? centerId,
    String? byUser,
    String? byDevice,
    bool? isDeleted,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? studentId,
    String? classId,
    PaymentTypeEnum? paymentType,
  }) {
    return StudentClassEnrollmentsEntity(
      entityId: entityId ?? this.entityId,
      centerId: centerId ?? this.centerId,
      byUser: byUser ?? this.byUser,
      byDevice: byDevice ?? this.byDevice,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      paymentType: paymentType ?? this.paymentType,
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
      'student_id': studentId,
      'class_id': classId,
      'payment_type': paymentType.name,
    };
  }
}
