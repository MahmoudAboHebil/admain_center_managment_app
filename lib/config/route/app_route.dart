import 'package:admain_center_managment_app/config/route/route_name.dart';
import 'package:admain_center_managment_app/config/route/route_path.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/class_profile_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/classes_overview_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/create_class_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/update_class_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/add_student_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/student_profile_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/students_overview_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/students_search_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/update_student_screen.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../contexts/center_management_context/presentation/screens/shell_screen.dart';
import '../../sync_engine/domain/entities/class_entity.dart';
import '../../sync_engine/domain/entities/class_section_entity.dart';

final parentNavigationKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRoute = [
  ShellRoute(
    parentNavigatorKey: parentNavigationKey,
    navigatorKey: _shellNavigatorKey,
    pageBuilder: (context, state, child) {
      return MaterialPage(
        maintainState: true,
        name: state.fullPath,
        child: ShellScreen(child: child),
      );
    },
    routes: [
      GoRoute(
        name: RouteName.studentsOverview,
        path: RoutePath.studentsOverview,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const StudentsOverviewScreen(),
          );
        },
      ),
      GoRoute(
        name: RouteName.classesOverview,
        path: RoutePath.classesOverview,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            name: state.fullPath,
            child: const ClassesOverviewScreen(),
          );
        },
      ),
    ],
  ),
  GoRoute(
    name: RouteName.createClass,
    path: RoutePath.createClass,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        name: state.fullPath,
        child: const CreateClassScreen(),
      );
    },
  ),
  GoRoute(
    name: RouteName.classProfile,
    path: RoutePath.classProfile,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return NoTransitionPage(
        name: state.fullPath,
        child: ClassProfileScreen(
          entity: data['entity'] as ClassEntity,
          sections: data['sections'] as List<ClassSectionEntity>,
          studyLevel: data['studyLevel'] as String,
        ),
      );
    },
  ),
  GoRoute(
    name: RouteName.updateClass,
    path: RoutePath.updateClass,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return NoTransitionPage(
        name: state.fullPath,
        child: UpdateClassScreen(
          entity: data['entity'] as ClassEntity,
          sections: data['sections'] as List<ClassSectionEntity>,
        ),
      );
    },
  ),
  GoRoute(
    name: RouteName.studentProfile,
    path: RoutePath.studentProfile,
    pageBuilder: (context, state) {
      final data = state.extra as StudentEntity;
      return NoTransitionPage(
        name: state.fullPath,
        child: StudentProfileScreen(student: data),
      );
    },
  ),
  GoRoute(
    name: RouteName.studentsSearch,
    path: RoutePath.studentsSearch,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return NoTransitionPage(
        name: state.fullPath,
        child: StudentsSearchScreen(
          query: data['query'] as String,
          initialData: data['initialData'] as List<StudentEntity>,
        ),
      );
    },
  ),
  GoRoute(
    name: RouteName.addStudent,
    path: RoutePath.addStudent,
    pageBuilder: (context, state) {
      return NoTransitionPage(name: state.fullPath, child: AddStudentScreen());
    },
  ),
  GoRoute(
    name: RouteName.updateStudent,
    path: RoutePath.updateStudent,
    pageBuilder: (context, state) {
      final data = state.extra as StudentEntity;
      return NoTransitionPage(
        name: state.fullPath,
        child: UpdateStudentScreen(studentEntity: data),
      );
    },
  ),
];
