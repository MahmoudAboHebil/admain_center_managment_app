import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_class_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_class_section_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/data_sources/local/local_student_datasource.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/repository/class_repository_impl.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/repository/class_section_repository_impl.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/data/repository/student_repository_impl.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_repository.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/classes_sections_useCases/create_class_section_useCase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/classes_sections_useCases/delete_class_sections_useCase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/classes_sections_useCases/update_class_section_useCase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/classes_useCases/create_class_useCase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/classes_useCases/update_class_useCase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/selection_cubit/selection_cubit.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/local_queue_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/datasource/sync_datasource.dart';
import 'package:admain_center_managment_app/sync_engine/data/repository/queue_repository_impl.dart';
import 'package:admain_center_managment_app/sync_engine/data/repository/sync_repository_impl.dart';
import 'package:admain_center_managment_app/sync_engine/data/repository/table_repository_impl.dart';
import 'package:admain_center_managment_app/sync_engine/domain/repository/queue_repository.dart';
import 'package:admain_center_managment_app/sync_engine/domain/repository/sync_repository.dart';
import 'package:admain_center_managment_app/sync_engine/domain/repository/table_repository.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/add_entity_local_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/add_operation_local_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/get_server_updated_records_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/get_table_queue_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/pull_single_table_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/push_single_operation_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/push_single_table_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/send_operation_to_server_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/sync_all_tables_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/domain/use_cases/sync_table_usecase.dart';
import 'package:admain_center_managment_app/sync_engine/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:get_it/get_it.dart';

import 'contexts/center_management_context/domain/repository/class_section_repository.dart';
import 'core/internet_service/internet_bloc/internet_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Data Sources
  sl.registerSingleton<SyncDatasource>(SyncDatasource());
  sl.registerSingleton<LocalQueueDatasource>(LocalQueueDatasource());

  // Repositories
  sl.registerSingleton<QueueRepository>(
    QueueRepositoryImpl(sl<LocalQueueDatasource>()),
  );

  sl.registerSingleton<TableRepository>(
    TableRepositoryImpl(sl<LocalQueueDatasource>()),
  );

  sl.registerSingleton<SyncRepository>(
    SyncRepositoryImpl(sl<TableRepository>(), sl<SyncDatasource>()),
  );

  //UseCases
  sl.registerSingleton<SendOperationToServerUseCase>(
    SendOperationToServerUseCase(sl<SyncRepository>()),
  );
  sl.registerSingleton<PushSingleOperationUseCase>(
    PushSingleOperationUseCase(
      sl<QueueRepository>(),
      sl<TableRepository>(),
      sl<SendOperationToServerUseCase>(),
    ),
  );

  sl.registerSingleton<AddOperationLocalUseCase>(
    AddOperationLocalUseCase(sl<QueueRepository>()),
  );
  sl.registerSingleton<AddEntityLocalUseCase>(
    AddEntityLocalUseCase(sl<TableRepository>()),
  );
  sl.registerSingleton<GetServerUpdatedRecordsUseCase>(
    GetServerUpdatedRecordsUseCase(sl<TableRepository>()),
  );
  sl.registerSingleton<GetTableQueueUseCase>(
    GetTableQueueUseCase(sl<QueueRepository>()),
  );
  sl.registerSingleton<PullSingleTableUseCase>(
    PullSingleTableUseCase(
      sl<GetServerUpdatedRecordsUseCase>(),
      sl<TableRepository>(),
    ),
  );
  sl.registerSingleton<PushSingleTableUseCase>(
    PushSingleTableUseCase(
      sl<QueueRepository>(),
      sl<TableRepository>(),
      sl<GetTableQueueUseCase>(),
      sl<SendOperationToServerUseCase>(),
    ),
  );

  sl.registerSingleton<SyncTableUseCase>(
    SyncTableUseCase(
      sl<PullSingleTableUseCase>(),
      sl<PushSingleTableUseCase>(),
    ),
  );

  sl.registerSingleton<SyncAllTablesUseCase>(
    SyncAllTablesUseCase(sl<SyncTableUseCase>(), sl<SyncRepository>()),
  );

  // real work throw

  sl.registerSingleton<LocalStudentDatasource>(
    LocalStudentDatasource(
      sl<AddEntityLocalUseCase>(),
      sl<AddOperationLocalUseCase>(),
      sl<QueueRepository>(),
      sl<SyncRepository>(),
      sl<PushSingleOperationUseCase>(),
      sl<TableRepository>(),
    ),
  );

  sl.registerSingleton<StudentRepository>(
    StudentRepositoryImpl(sl<LocalStudentDatasource>()),
  );

  sl.registerSingleton<LocalClassDatasource>(
    LocalClassDatasource(
      sl<AddEntityLocalUseCase>(),
      sl<AddOperationLocalUseCase>(),
      sl<QueueRepository>(),
      sl<SyncRepository>(),
      sl<PushSingleOperationUseCase>(),
      sl<TableRepository>(),
    ),
  );

  sl.registerSingleton<ClassRepository>(
    ClassRepositoryImpl(sl<LocalClassDatasource>()),
  );

  sl.registerSingleton<LocalClassSectionDatasource>(
    LocalClassSectionDatasource(
      sl<AddEntityLocalUseCase>(),
      sl<AddOperationLocalUseCase>(),
      sl<QueueRepository>(),
      sl<SyncRepository>(),
      sl<PushSingleOperationUseCase>(),
      sl<TableRepository>(),
    ),
  );

  sl.registerSingleton<UpdateClassUseCase>(
    UpdateClassUseCase(repository: sl<ClassRepository>()),
  );
  sl.registerSingleton<CreateClassUseCase>(
    CreateClassUseCase(repository: sl<ClassRepository>()),
  );

  sl.registerSingleton<ClassSectionRepository>(
    ClassSectionRepositoryImpl(sl<LocalClassSectionDatasource>()),
  );
  sl.registerSingleton<UpdateClassSectionUseCase>(
    UpdateClassSectionUseCase(repository: sl<ClassSectionRepository>()),
  );
  sl.registerSingleton<DeleteClassSectionsUseCase>(
    DeleteClassSectionsUseCase(repository: sl<ClassSectionRepository>()),
  );
  sl.registerSingleton<CreateClassSectionUseCase>(
    CreateClassSectionUseCase(repository: sl<ClassSectionRepository>()),
  );

  //Blocs
  sl.registerFactory<SyncBloc>(() => SyncBloc(sl<SyncAllTablesUseCase>()));
  sl.registerFactory<InternetBloc>(() => InternetBloc());
  sl.registerFactory<SelectionCubit>(() => SelectionCubit());
}
