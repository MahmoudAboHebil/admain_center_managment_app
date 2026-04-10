import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/selection_cubit/selection_cubit.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/isar_local_database/isar/isar_service.dart';
import 'package:admain_center_managment_app/sync_engine/presentation/blocs/sync_bloc/sync_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc_observer.dart';
import 'config/theme/app_theme.dart';
import 'contexts/center_management_context/presentation/screens/mobile_app_screens/students_list_screen.dart';
import 'core/enums/languages.dart';
import 'core/internet_service/internet_bloc/internet_bloc.dart';
import 'core/providers/language_provider.dart';
import 'generated/l10n.dart';
import 'injection_container.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  await IsarService.getInstance();
  await initializeDependencies();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) {
        return ScreenUtilInit(
          builder: (context, child) => ProviderScope(child: MyApp()),
          designSize: Size(400, 857),
        );
      }, // Wrap your app
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final languageState = ref.watch(languageProvider);

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
        locale: Locale(languageState.value?.name ?? Language.en.name),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const StudentsListScreen(),
      ),
    );
  }
}
