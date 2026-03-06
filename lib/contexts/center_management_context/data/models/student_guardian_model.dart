import 'package:admain_center_managment_app/core/isar_local_database/isar/collections/student_guardian_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudentGuardianModel extends Equatable {
  const StudentGuardianModel({
    required this.entityId,
    required this.studentId,
    required this.guardianId,
    required this.createdAt,
  });
  final String entityId;
  final String studentId;
  final String guardianId;

  final DateTime createdAt;

  factory StudentGuardianModel.fromCollection(
    StudentGuardianCollection collection,
  ) {
    return StudentGuardianModel(
      entityId: collection.entityId,
      studentId: collection.studentId,
      guardianId: collection.guardianId,
      createdAt: collection.createdAt.toUtc(),
    );
  }

  StudentGuardianCollection toCollection() {
    return StudentGuardianCollection()
      ..entityId = entityId
      ..studentId = studentId
      ..guardianId = guardianId
      ..createdAt = createdAt.toUtc();
  }

  @override
  List<Object?> get props => [entityId, studentId, createdAt, guardianId];
}
