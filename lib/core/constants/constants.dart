import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/center_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/core/enums/education_system_enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums/user_role.dart';

const String SUPABASE_ANON_KEY =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmc2FwZW5lcmhmc2FiaWtmcXBmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM5NjkxNDksImV4cCI6MjA4OTU0NTE0OX0.01XycGB2Wf2WdZKbC24EQlYtV6jdxHyACeScvLfN7zg';
const String SUPABASE_URL = 'https://bfsapenerhfsabikfqpf.supabase.co';
final supabase = Supabase.instance.client;
const UserRole currentUserRole = UserRole.admin;

final currentCenter = CenterEntity(
  entityId: "a4f213c7-2cbe-418d-8682-57f3fcebad21",
  name: 'Mahmoud Center',
  byUser: "cf91aa5b-f079-4ead-a257-9e289e95e6ce",
  byDevice: "cdddaf5f-b392-49d5-8763-358e3f0f67b4",
  version: 1,
  createdAt: DateTime.now().toUtc(),
  updatedAt: DateTime.now().toUtc(),
);
final currentUserId = "4ea4736f-d57e-41f1-b87d-f476b527c9e3";
final currentDevice = "aa420cc4-cf21-4030-b857-1b875da20415";

final List<StudyLevelEntity> studyLevels = [
  // ===== KG =====
  StudyLevelEntity(
    entityId: "c444a00b-13e3-4b05-9f5e-6b327016ad4a",
    arabicName: "الصف الدراسي",
    englishName: "Study Level",
    educationSystem: EducationSystem.General,
    order: 0,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "792387f4-432f-4668-98e2-7ebc240b6650",
    arabicName: "رياض أطفال أولى",
    englishName: "KG 1",
    educationSystem: EducationSystem.General,
    order: 1,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "1d76e654-b3e8-48ab-94d5-755a92568066",
    arabicName: "رياض أطفال ثانية",
    englishName: "KG 2",
    educationSystem: EducationSystem.General,
    order: 2,
    createdAt: DateTime(2024, 1, 1),
  ),

  // ===== Primary =====
  StudyLevelEntity(
    entityId: "70e51e8d-9ef1-4073-a0a5-0c9475666c0b",
    arabicName: "الصف الأول الابتدائي",
    englishName: "Primary 1",
    educationSystem: EducationSystem.General,
    order: 3,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "a22b906e-9b50-4458-a05e-ee0a52080a33",
    arabicName: "الصف الثاني الابتدائي",
    englishName: "Primary 2",
    educationSystem: EducationSystem.General,
    order: 4,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "1ecd798c-8605-4621-a31b-e38ff8244726",
    arabicName: "الصف الثالث الابتدائي",
    englishName: "Primary 3",
    educationSystem: EducationSystem.General,
    order: 5,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "f954e395-38f2-43fc-a899-3e4180228be0",
    arabicName: "الصف الرابع الابتدائي",
    englishName: "Primary 4",
    educationSystem: EducationSystem.General,
    order: 6,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "975d8383-4303-4130-9b16-5539e182bfe8",
    arabicName: "الصف الخامس الابتدائي",
    englishName: "Primary 5",
    educationSystem: EducationSystem.General,
    order: 7,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "d79fb538-a5f0-4794-9885-022b7fc06f31",
    arabicName: "الصف السادس الابتدائي",
    englishName: "Primary 6",
    educationSystem: EducationSystem.General,
    order: 8,
    createdAt: DateTime(2024, 1, 1),
  ),

  // ===== Preparatory =====
  StudyLevelEntity(
    entityId: "dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61",
    arabicName: "الصف الأول الإعدادي",
    englishName: "Preparatory 1",
    educationSystem: EducationSystem.General,
    order: 9,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "4b05e1ba-1063-465a-8f5e-6dd46ab562fa",
    arabicName: "الصف الثاني الإعدادي",
    englishName: "Preparatory 2",
    educationSystem: EducationSystem.General,
    order: 10,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "8fcdb091-afad-4be0-a516-d35365286e20",
    arabicName: "الصف الثالث الإعدادي",
    englishName: "Preparatory 3",
    educationSystem: EducationSystem.General,
    order: 11,
    createdAt: DateTime(2024, 1, 1),
  ),

  // ===== Secondary =====
  StudyLevelEntity(
    entityId: "3a1a3053-8508-4374-8409-f43abc1f2df0",
    arabicName: "الصف الأول الثانوي",
    englishName: "Secondary 1",
    educationSystem: EducationSystem.General,
    order: 12,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "b756566b-fd68-46ad-9a83-1abc0f397b83",
    arabicName: "الصف الثاني الثانوي",
    englishName: "Secondary 2",
    educationSystem: EducationSystem.General,
    order: 13,
    createdAt: DateTime(2024, 1, 1),
  ),
  StudyLevelEntity(
    entityId: "472222ab-14bb-4693-9695-97c371ec081e",
    arabicName: "الصف الثالث الثانوي",
    englishName: "Secondary 3",
    educationSystem: EducationSystem.General,
    order: 14,
    createdAt: DateTime(2024, 1, 1),
  ),
];

final List<StudyLevelEntity> studyLevelsWithAll = [
  StudyLevelEntity(
    entityId: "all",
    arabicName: "الكل",
    englishName: "All",
    educationSystem: EducationSystem.General,
    order: 0,
    createdAt: DateTime.now(),
  ),
  ...(studyLevels.where((element) => element.order != 0).toList()),
];
