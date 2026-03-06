import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:equatable/equatable.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();
}

class GetStudentEvent extends StudentEvent {
  final List<StudentEntity>? cachedStudentEntity;
  final String entityId;
  const GetStudentEvent({required this.entityId, this.cachedStudentEntity});

  @override
  List<Object?> get props => [entityId];
}

class GetAllStudentsEvent extends StudentEvent {
  const GetAllStudentsEvent();

  @override
  List<Object?> get props => [];
}

class SoftDeleteStudentEvent extends StudentEvent {
  final String entityId;
  const SoftDeleteStudentEvent({required this.entityId});
  @override
  List<Object?> get props => [entityId];
}

class CreateStudentEvent extends StudentEvent {
  final StudentEntity entity;
  const CreateStudentEvent({required this.entity});
  @override
  List<Object?> get props => [entity];
}

class UpdateStudentEvent extends StudentEvent {
  final StudentEntity newEntity;
  const UpdateStudentEvent({required this.newEntity});
  @override
  List<Object?> get props => [newEntity];
}
