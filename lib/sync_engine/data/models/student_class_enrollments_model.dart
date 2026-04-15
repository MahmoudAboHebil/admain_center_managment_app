import 'package:admain_center_managment_app/core/enums/payment_type_enum.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_class_enrollments_collection.dart';
import 'package:admain_center_managment_app/sync_engine/data/models/standard_table_record_model.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_class_enrollments_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudentClassEnrollmentsModel extends StandardTableRecordModel
    with EquatableMixin {
  const StudentClassEnrollmentsModel({
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

  // ================== FROM JSON ==================
  factory StudentClassEnrollmentsModel.fromJson(Map<String, dynamic> json) {
    return StudentClassEnrollmentsModel(
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
      studentId: json['student_id'],
      paymentType: PaymentTypeEnum.getPaymentFromString(json["payment_type"]),
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
      'student_id': studentId,
      'class_id': classId,
      'payment_type': paymentType.name,
    };
  }

  // ================== TO ENTITY ==================
  StudentClassEnrollmentsEntity toEntity() {
    return StudentClassEnrollmentsEntity(
      entityId: entityId,
      centerId: centerId,
      byUser: byUser,
      byDevice: byDevice,
      isDeleted: isDeleted,
      version: version,
      createdAt: createdAt.toUtc(),
      updatedAt: updatedAt.toUtc(),
      classId: classId,
      paymentType: paymentType,
      studentId: studentId,
    );
  }

  // ================== TO COLLECTION ==================
  StudentClassEnrollmentsCollection toCollection() {
    return StudentClassEnrollmentsCollection()
      ..entityId = entityId
      ..centerId = centerId
      ..byUser = byUser
      ..byDevice = byDevice
      ..isDeleted = isDeleted
      ..version = version
      ..createdAt = createdAt.toUtc()
      ..updatedAt = updatedAt.toUtc()
      ..paymentType = paymentType.name
      ..studentId = studentId
      ..classId = classId;
  }

  // ================== FROM COLLECTION ==================
  factory StudentClassEnrollmentsModel.fromCollection(
    StudentClassEnrollmentsCollection c,
  ) {
    return StudentClassEnrollmentsModel(
      entityId: c.entityId,
      centerId: c.centerId,
      byUser: c.byUser,
      byDevice: c.byDevice,
      isDeleted: c.isDeleted,
      version: c.version,
      createdAt: c.createdAt.toUtc(),
      updatedAt: c.updatedAt.toUtc(),
      classId: c.classId,
      studentId: c.studentId,
      paymentType: PaymentTypeEnum.getPaymentFromString(c.paymentType),
    );
  }
  factory StudentClassEnrollmentsModel.fromEntity(
    StudentClassEnrollmentsEntity entity,
  ) {
    return StudentClassEnrollmentsModel(
      entityId: entity.entityId,
      centerId: entity.centerId,
      byUser: entity.byUser,
      byDevice: entity.byDevice,
      isDeleted: entity.isDeleted,
      version: entity.version,
      createdAt: entity.createdAt.toUtc(),
      updatedAt: entity.updatedAt.toUtc(),
      classId: entity.classId,
      paymentType: entity.paymentType,
      studentId: entity.studentId,
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
    studentId,
    classId,
    paymentType,
  ];
  @override
  String toString() {
    return entityId;
  }

  StudentClassEnrollmentsModel copyWith({
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
    return StudentClassEnrollmentsModel(
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
}
