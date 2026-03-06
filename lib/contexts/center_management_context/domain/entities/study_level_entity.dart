import 'package:admain_center_managment_app/core/enums/education_system_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudyLevelEntity extends Equatable {
  const StudyLevelEntity({
    required this.entityId,
    required this.arabicName,
    required this.englishName,
    required this.educationSystem,
    required this.order,
    required this.createdAt,
  });
  final String entityId;
  final String arabicName;
  final String englishName;
  final EducationSystem educationSystem;
  final int order;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    entityId,
    arabicName,
    englishName,
    educationSystem,
    order,
    createdAt,
  ];
}
