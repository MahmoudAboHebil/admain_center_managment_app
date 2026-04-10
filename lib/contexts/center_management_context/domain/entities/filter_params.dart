import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';

import '../../../../core/enums/division_enum.dart';
import '../../../../core/enums/payment_type_enum.dart';
import '../../../../core/enums/student_status_enum.dart';

class FilterParams {
  final PaymentTypeEnum? selectedPaymentType;
  final StudyLevelEntity selectedStudyLevel;
  final DivisionEnum selectedDivision;
  final StudentStatus? selectedStudentStates;
  const FilterParams({
    required this.selectedPaymentType,
    required this.selectedStudentStates,
    required this.selectedDivision,
    required this.selectedStudyLevel,
  });

  @override
  String toString() {
    return 'FilterParams{selectedPaymentType: $selectedPaymentType, selectedStudyLevel: $selectedStudyLevel, selectedDivision: $selectedDivision, selectedStudentStates: $selectedStudentStates}';
  }
}
