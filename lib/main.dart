import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:admain_center_managment_app/sync_engine/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc_observer.dart';
import 'config/theme/app_theme.dart';
import 'contexts/center_management_context/presentation/screens/students_directory_screen.dart';
import 'core/internet_service/internet_bloc/internet_bloc.dart';
import 'injection_container.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  await IsarService.getInstance();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SyncBloc>(
          create: (BuildContext context) => sl<SyncBloc>(),
        ),
        BlocProvider<InternetBloc>(
          create: (BuildContext context) => sl<InternetBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // Arabic
        ],
        locale: const Locale('ar', 'AE'), // Default to Arabic RTL
        home: const StudentsDirectoryScreen(),
      ),
    );
  }
}
