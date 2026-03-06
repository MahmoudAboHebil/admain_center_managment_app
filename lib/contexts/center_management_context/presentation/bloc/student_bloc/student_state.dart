import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:equatable/equatable.dart';

abstract class StudentState extends Equatable {
  const StudentState();
}

class StudentLoading extends StudentState {
  const StudentLoading();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {
  const StudentInitial();

  @override
  List<Object?> get props => [];
}

class StudentDone extends StudentState {
  final List<StudentEntity>? studentEntities;
  final StudentEntity? searchedStudent;
  const StudentDone({
    required this.studentEntities,
    required this.searchedStudent,
  });

  @override
  List<Object?> get props => [...?studentEntities, searchedStudent];

  @override
  String toString() {
    return "studentEntities: $studentEntities /searchedStudent $searchedStudent";
  }
}

class StudentError extends StudentState {
  final Failure error;
  const StudentError({required this.error});

  @override
  List<Object?> get props => [error];
}
