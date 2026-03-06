import 'package:admain_center_managment_app/contexts/center_management_context/data/models/standard_table_record_model.dart';
import 'package:admain_center_managment_app/core/enums/guardian_relation_enum.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/guardian_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GuardianModel extends StandardTableRecordModel with EquatableMixin {
  const GuardianModel({
    required super.entityId,
    required super.centerId,
    required super.byUser,
    required super.byDevice,
    required super.isDeleted,
    required super.version,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.relation,
    required this.phone,
    required this.whatsAppPhone,
    required this.addressLine1,
    this.email,
    this.addressLine2,
  });
  final String name;
  final GuardianRelation relation;
  final String phone;
  final String whatsAppPhone;
  final String? email;
  final String addressLine1;
  final String? addressLine2;

  factory GuardianModel.fromCollection(GuardianCollection collection) {
    return GuardianModel(
      entityId: collection.entityId,
      centerId: collection.centerId,
      byUser: collection.byUser,
      byDevice: collection.byDevice,
      isDeleted: collection.isDeleted,
      version: collection.version,
      createdAt: collection.createdAt.toUtc(),
      updatedAt: collection.updatedAt.toUtc(),
      name: collection.name,
      relation: GuardianRelation.getGuardianRelationFromString(
        collection.relation,
      ),
      phone: collection.phone,
      whatsAppPhone: collection.whatsAppPhone,
      addressLine1: collection.addressLine1,
      addressLine2: collection.addressLine2,
      email: collection.email,
    );
  }
  GuardianCollection toCollection() {
    return GuardianCollection()
      ..entityId = entityId
      ..centerId = centerId
      ..byUser = byUser
      ..byDevice = byDevice
      ..isDeleted = isDeleted
      ..version = version
      ..createdAt = createdAt.toUtc()
      ..updatedAt = updatedAt.toUtc()
      ..name = name
      ..relation = relation.name
      ..phone = phone
      ..whatsAppPhone = whatsAppPhone
      ..addressLine1 = addressLine1
      ..addressLine2 = addressLine2
      ..email = email;
  }

  @override
  List<Object?> get props => [
    entityId,
    centerId,
    byUser,
    byDevice,
    isDeleted,
    version,
    name,
    relation,
    phone,
    whatsAppPhone,
    email,
    addressLine1,
    addressLine2,
    createdAt,
    updatedAt,
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
      'name': name,
      'guardian_relation': relation.name,
      'phone': phone,
      'whats_app_phone': whatsAppPhone,
      'email': email,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
    };
  }
}
