import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudentGuardianEntity extends Equatable {
  const StudentGuardianEntity({
    required this.entityId,
    required this.studentId,
    required this.guardianId,
    required this.createdAt,
  });
  final String entityId;
  final String studentId;
  final String guardianId;

  final DateTime createdAt;

  @override
  List<Object?> get props => [entityId, studentId, createdAt, guardianId];
}
