import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:admain_center_managment_app/core/enums/gender_enum.dart';
import 'package:admain_center_managment_app/core/enums/payment_type_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/standard_table_record.dart';
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
    required this.name,
    required this.studyLevelId,
    required this.gender,
    required this.studentCode,
    this.phone,
    this.homePhone,
    this.parentPhone,
    this.studentClasses,
    this.bookingDeposit,
    this.notes,
    this.paymentTypeEnum,
    this.address,
    this.schoolName,
    this.parentJob,
    this.divisionEnum,
    this.birthDate,
    this.email,
    required this.studentStatus,
  });
  final String name;
  final String studyLevelId;
  final Gender gender;
  final String studentCode;

  final String? phone;
  final String? homePhone;
  final String? parentPhone;
  final List<String>? studentClasses;
  final double? bookingDeposit;
  final List<String>? notes;
  final PaymentTypeEnum? paymentTypeEnum;

  final String? address;
  final String? schoolName;
  final String? parentJob;
  final DivisionEnum? divisionEnum;
  final DateTime? birthDate;
  final String? email;
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
    name,
    studyLevelId,
    gender,
    studentCode,
    phone,
    homePhone,
    parentPhone,
    studentClasses,
    bookingDeposit,
    notes,
    paymentTypeEnum,
    address,
    schoolName,
    parentJob,
    divisionEnum,
    birthDate,
    email,
    studentStatus,
  ];
  @override
  String toString() {
    return entityId;
  }

  StudentEntity copyWith({
    String? entityId,
    String? centerId,
    String? byUser,
    String? byDevice,
    bool? isDeleted,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? studyLevelId,
    Gender? gender,
    String? studentCode,

    String? phone,
    String? homePhone,
    String? parentPhone,
    List<String>? studentClasses,
    double? bookingDeposit,
    List<String>? notes,
    PaymentTypeEnum? paymentTypeEnum,

    String? address,
    String? schoolName,
    String? parentJob,
    DivisionEnum? divisionEnum,
    DateTime? birthDate,
    String? email,
    StudentStatus? studentStatus,
  }) {
    return StudentEntity(
      entityId: entityId ?? this.entityId,
      centerId: centerId ?? this.centerId,
      byUser: byUser ?? this.byUser,
      byDevice: byDevice ?? this.byDevice,
      isDeleted: isDeleted ?? this.isDeleted,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      studyLevelId: studyLevelId ?? this.studyLevelId,
      name: name ?? this.name,
      schoolName: schoolName ?? this.schoolName,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      studentStatus: studentStatus ?? this.studentStatus,
      homePhone: homePhone ?? this.homePhone,
      phone: phone ?? this.phone,
      studentCode: studentCode ?? this.studentCode,
      divisionEnum: divisionEnum ?? this.divisionEnum,
      paymentTypeEnum: paymentTypeEnum ?? this.paymentTypeEnum,
      email: email ?? this.email,
      address: address ?? this.address,
      bookingDeposit: bookingDeposit ?? this.bookingDeposit,
      notes: notes ?? this.notes,
      parentJob: parentJob ?? this.parentJob,
      parentPhone: parentPhone ?? this.parentPhone,
      studentClasses: studentClasses ?? this.studentClasses,
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
      'study_level_id': studyLevelId,
      'name': name,
      'gender': gender.name,
      'student_code': studentCode,
      'phone': phone,
      'home_phone': homePhone,
      'parent_phone': parentPhone,
      'student_classes': studentClasses,
      'booking_deposit': bookingDeposit,
      'notes': notes,
      'payment_type_enum': paymentTypeEnum?.name,
      'address': address,
      'school_name': schoolName,
      'parent_job': parentJob,
      'division_enum': divisionEnum?.name,
      'birth_date': birthDate?.toUtc().toIso8601String(),
      'email': email,
      'student_status': studentStatus.name,
    };
  }
}
