import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/create_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/get_all_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/get_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/soft_delete_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/update_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_event.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetAllStudentUseCase _getStudents;
  final SoftDeleteStudentUseCase _softDelete;
  final GetStudentUseCase _getStudent;
  final CreateStudentUseCase _createStudent;
  final UpdateStudentUseCase _updateStudentUseCase;
  StudentBloc(
    this._getStudents,
    this._softDelete,
    this._getStudent,
    this._createStudent,
    this._updateStudentUseCase,
  ) : super(StudentInitial()) {
    on<GetStudentEvent>((event, emit) async {
      emit(StudentLoading());
      final student = await _getStudent.call(
        GetStudentUseCaseParams(entityId: event.entityId),
      );

      await student.fold(
        ifLeft: (err) async {
          emit(StudentError(error: err));
        },
        ifRight: (data) async {
          if (data == null) {
            emit(
              StudentDone(
                studentEntities: event.cachedStudentEntity,
                searchedStudent: data,
              ),
            );
          } else {
            final List<StudentEntity>? newData;
            if (event.cachedStudentEntity == null) {
              newData = [data];
            } else {
              newData = {...?event.cachedStudentEntity, data}.toList();
            }
            emit(StudentDone(studentEntities: newData, searchedStudent: data));
          }
        },
      );
    });
    on<GetAllStudentsEvent>((event, emit) async {
      emit(StudentLoading());
      final students = await _getStudents.call(null);
      await students.fold(
        ifLeft: (err) async {
          emit(StudentError(error: err));
        },
        ifRight: (data) async {
          emit(StudentDone(studentEntities: data, searchedStudent: null));
        },
      );
    });
    on<UpdateStudentEvent>((event, emit) async {
      emit(StudentLoading());

      final updatedResult = await _updateStudentUseCase.call(
        UpdateStudentUseCaseParams(newEntity: event.newEntity),
      );

      await updatedResult.fold(
        ifLeft: (err) async {
          emit(StudentError(error: err));
        },
        ifRight: (_) async {
          await _reloadStudents(emit);
        },
      );
    });
    on<CreateStudentEvent>((event, emit) async {
      emit(StudentLoading());

      final createResult = await _createStudent.call(
        CreateStudentUseCaseParams(entity: event.entity),
      );

      await createResult.fold(
        ifLeft: (err) async {
          emit(StudentError(error: err));
        },
        ifRight: (_) async {
          await _reloadStudents(emit);
        },
      );
    });
    on<SoftDeleteStudentEvent>((event, emit) async {
      emit(StudentLoading());

      final deleteResult = await _softDelete.call(
        SoftDeleteStudentUseCaseParams(entityId: event.entityId),
      );

      await deleteResult.fold(
        ifLeft: (err) async {
          emit(StudentError(error: err));
        },
        ifRight: (_) async {
          await _reloadStudents(emit);
        },
      );
    });
  }

  Future<void> _reloadStudents(Emitter<StudentState> emit) async {
    final students = await _getStudents.call(null);

    await students.fold(
      ifLeft: (err) async {
        emit(StudentError(error: err));
      },
      ifRight: (data) async {
        emit(StudentDone(studentEntities: data, searchedStudent: null));
      },
    );
  }
}
