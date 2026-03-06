import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/core/enums/education_system_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class StudyLevelModel extends Equatable {
  const StudyLevelModel({
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

  factory StudyLevelModel.fromEntity(StudyLevelEntity entity) {
    return StudyLevelModel(
      entityId: entity.entityId,
      arabicName: entity.arabicName,
      englishName: entity.englishName,
      educationSystem: entity.educationSystem,
      order: entity.order,
      createdAt: entity.createdAt.toUtc(),
    );
  }
  StudyLevelEntity toEntity() {
    return StudyLevelEntity(
      entityId: entityId,
      arabicName: arabicName,
      englishName: englishName,
      educationSystem: educationSystem,
      order: order,
      createdAt: createdAt.toUtc(),
    );
  }

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
