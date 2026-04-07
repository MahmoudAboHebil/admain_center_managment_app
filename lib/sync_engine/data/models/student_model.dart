import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/enums/division_enum.dart';
import '../../../core/enums/gender_enum.dart';
import '../../../core/enums/payment_type_enum.dart';
import '../../../core/enums/student_status_enum.dart';
import '../../../core/isar_local_database/isar/collections/student_collection.dart';
import '../../domain/entities/student_entity.dart';
import 'standard_table_record_model.dart';

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
  final String? notes;
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

  // ================== FROM JSON ==================
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
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
      studentCode: json['student_code'] ?? '',

      gender: Gender.values.firstWhere(
        (e) => e.name == json['gender'],
        orElse: () => Gender.male,
      ),

      studentStatus: StudentStatus.values.firstWhere(
        (e) => e.name == json['student_status'],
        orElse: () => StudentStatus.active,
      ),

      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      homePhone: json['home_phone'],
      parentPhone: json['parent_phone'],
      parentJob: json['parent_job'],
      schoolName: json['school_name'],

      bookingDeposit: json['booking_deposit'] != null
          ? (json['booking_deposit'] as num).toDouble()
          : null,

      notes: json['notes'],

      paymentTypeEnum: json['payment_type_enum'] != null
          ? PaymentTypeEnum.values.firstWhere(
              (e) => e.name == json['payment_type_enum'],
            )
          : null,

      divisionEnum: json['division_enum'] != null
          ? DivisionEnum.values.firstWhere(
              (e) => e.name == json['division_enum'],
            )
          : null,

      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date']).toUtc()
          : null,
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
      'study_level_id': studyLevelId,
      'name': name,
      'gender': gender.name,
      'student_code': studentCode,
      'phone': phone,
      'home_phone': homePhone,
      'parent_phone': parentPhone,
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

  // ================== TO ENTITY ==================
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
      gender: gender,
      studentCode: studentCode,
      phone: phone,
      homePhone: homePhone,
      parentPhone: parentPhone,
      studentClasses: studentClasses,
      bookingDeposit: bookingDeposit,
      notes: notes,
      paymentTypeEnum: paymentTypeEnum,
      address: address,
      schoolName: schoolName,
      parentJob: parentJob,
      divisionEnum: divisionEnum,
      birthDate: birthDate?.toUtc(),
      email: email,
      studentStatus: studentStatus,
    );
  }

  // ================== TO COLLECTION ==================
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
      ..name = name
      ..studyLevelId = studyLevelId
      ..studentCode = studentCode
      ..gender = gender.name
      ..studentStatus = studentStatus.name
      ..email = email
      ..address = address
      ..phone = phone
      ..homePhone = homePhone
      ..parentPhone = parentPhone
      ..parentJob = parentJob
      ..schoolName = schoolName
      ..bookingDeposit = bookingDeposit
      ..studentClasses = studentClasses
      ..notes = notes
      ..paymentTypeEnum = paymentTypeEnum?.name
      ..divisionEnum = divisionEnum?.name
      ..birthDate = birthDate?.toUtc();
  }

  // ================== FROM COLLECTION ==================
  factory StudentModel.fromCollection(StudentCollection c) {
    return StudentModel(
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
      studentCode: c.studentCode,
      gender: Gender.getGenderEnumFromString(c.gender),
      studentStatus: StudentStatus.getStudentStatusEnumFromString(
        c.studentStatus,
      ),
      phone: c.phone,
      homePhone: c.homePhone,
      parentPhone: c.parentPhone,
      studentClasses: c.studentClasses,
      bookingDeposit: c.bookingDeposit,
      notes: c.notes,
      paymentTypeEnum: c.paymentTypeEnum != null
          ? PaymentTypeEnum.getPaymentFromString(c.paymentTypeEnum!)
          : null,
      address: c.address,
      schoolName: c.schoolName,
      parentJob: c.parentJob,
      divisionEnum: c.divisionEnum != null
          ? DivisionEnum.getDivisionFromString(c.divisionEnum!)
          : null,
      birthDate: c.birthDate?.toUtc(),
      email: c.email,
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
      birthDate: entity.birthDate?.toUtc(),
      studentStatus: entity.studentStatus,
      homePhone: entity.homePhone,
      phone: entity.phone,
      studentCode: entity.studentCode,
      studentClasses: entity.studentClasses,
      paymentTypeEnum: entity.paymentTypeEnum,
      parentPhone: entity.parentPhone,
      parentJob: entity.parentJob,
      notes: entity.notes,
      divisionEnum: entity.divisionEnum,
      bookingDeposit: entity.bookingDeposit,
      address: entity.address,
      email: entity.email,
    );
  }
}
