import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/pages/students_page.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'injection_container.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.getInstance();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
      create: (context) => sl<StudentBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const StudentsPage(),
      ),
    );
  }
}
