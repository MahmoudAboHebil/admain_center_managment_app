import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/selection_cubit/selection_cubit.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:admain_center_managment_app/sync_engine/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc_observer.dart';
import 'config/theme/app_theme.dart';
import 'contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'core/internet_service/internet_bloc/internet_bloc.dart';
import 'injection_container.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  await IsarService.getInstance();
  await initializeDependencies();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
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
        BlocProvider<SelectionCubit>(
          create: (BuildContext context) => sl<SelectionCubit>(),
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
        home: const StudentsListScreen(),
      ),
    );
  }
}
