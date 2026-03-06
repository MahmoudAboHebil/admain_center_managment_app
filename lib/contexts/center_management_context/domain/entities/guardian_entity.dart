import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/standard_table_record.dart';
import 'package:admain_center_managment_app/core/enums/guardian_relation_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class GuardianEntity extends StandardTableRecord with EquatableMixin {
  const GuardianEntity({
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
