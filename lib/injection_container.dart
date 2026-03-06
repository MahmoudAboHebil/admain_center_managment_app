import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_student_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/repository/student_repository_impl.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/create_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/get_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/soft_delete_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/student_usecases/update_student_usecase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:get_it/get_it.dart';

import 'contexts/center_management_context/domain/repository/student_repository.dart';
import 'contexts/center_management_context/domain/usecases/student_usecases/get_all_student_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies
  sl.registerSingleton<LocalStudentDatasource>(LocalStudentDatasource());

  sl.registerSingleton<StudentRepository>(StudentRepositoryImpl(sl()));
  //UseCases
  sl.registerSingleton<GetAllStudentUseCase>(GetAllStudentUseCase(sl()));
  sl.registerSingleton<SoftDeleteStudentUseCase>(
    SoftDeleteStudentUseCase(sl()),
  );
  sl.registerSingleton<GetStudentUseCase>(GetStudentUseCase(sl()));
  sl.registerSingleton<CreateStudentUseCase>(CreateStudentUseCase(sl()));
  sl.registerSingleton<UpdateStudentUseCase>(UpdateStudentUseCase(sl()));
  //Blocs
  sl.registerFactory<StudentBloc>(
    () => StudentBloc(
      sl<GetAllStudentUseCase>(),
      sl<SoftDeleteStudentUseCase>(),
      sl<GetStudentUseCase>(),
      sl<CreateStudentUseCase>(),
      sl<UpdateStudentUseCase>(),
    ),
  );
}
