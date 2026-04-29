import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../contexts/center_management_context/domain/entities/study_level_entity.dart';
import '../enums/division_enum.dart';

class CreateClassData {
  const CreateClassData({
    this.levelId,
    this.semester = 0,
    this.divisionEnum,
    this.selectedDaysData,
  });
  final StudyLevelEntity? levelId;
  final int semester;
  final DivisionEnum? divisionEnum;
  final Map<int, Map<String, DateTime>>? selectedDaysData;

  @override
  String toString() {
    return """
    level     : ${levelId?.arabicName}
    semester  : $semester
    divisionEnum     : ${divisionEnum?.arabic}
    """;
  }

  CreateClassData copyWith({
    StudyLevelEntity? levelId,
    int? semester,
    DivisionEnum? divisionEnum,
    Map<int, Map<String, DateTime>>? selectedDaysData,
  }) {
    return CreateClassData(
      levelId: levelId ?? this.levelId,
      semester: semester ?? this.semester,
      divisionEnum: divisionEnum ?? this.divisionEnum,
      selectedDaysData: selectedDaysData ?? this.selectedDaysData,
    );
  }
}

class CreateClassDataNotifier extends AutoDisposeNotifier<CreateClassData> {
  @override
  CreateClassData build() {
    print('CreateClassData New');
    return CreateClassData();
  }

  void clearData() {
    state = CreateClassData();
  }

  void updateLevelId(StudyLevelEntity levelId) {
    state = state.copyWith(levelId: levelId);
  }

  void updateSemester(int semester) {
    state = state.copyWith(semester: semester);
  }

  void updateDivisionEnum(DivisionEnum divisionEnum) {
    state = state.copyWith(divisionEnum: divisionEnum);
  }

  void updateSelectedDaysData(
    Map<int, Map<String, DateTime>> selectedDaysData,
  ) {
    state = state.copyWith(selectedDaysData: selectedDaysData);
  }
}

final createClassDataProvider =
    NotifierProvider.autoDispose<CreateClassDataNotifier, CreateClassData>(
      CreateClassDataNotifier.new,
    );
