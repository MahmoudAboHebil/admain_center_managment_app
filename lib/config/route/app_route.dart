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

import '../../contexts/center_management_context/domain/entities/filter_params.dart';
import '../../contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/student_filter_screen.dart';
import '../../contexts/center_management_context/presentation/screens/shell_screen.dart';
import '../../sync_engine/domain/entities/class_entity.dart';
import '../../sync_engine/domain/entities/class_section_entity.dart';

final parentNavigationKey = GlobalKey<NavigatorState>();

final appRoute = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ShellScreen(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: RouteName.classesOverview,
            path: RoutePath.classesOverview,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: ClassesOverviewScreen(key: ValueKey(state.extra)),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            name: RouteName.studentsOverview,
            path: RoutePath.studentsOverview,
            pageBuilder: (context, state) {
              final data = state.extra as Map<String, dynamic>?;
              return NoTransitionPage(
                child: StudentsOverviewScreen(
                  key: ValueKey(data),
                  filterDataList:
                      data?['filterDataList'] as List<StudentEntity>?,
                  params: data?['params'] as FilterParams?,
                ),
              );
            },
          ),
        ],
      ),
    ],
  ),

  GoRoute(
    name: RouteName.createClass,
    path: RoutePath.createClass,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: const CreateClassScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.classProfile,
    path: RoutePath.classProfile,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),

        child: ClassProfileScreen(
          entity: data['entity'] as ClassEntity,
          sections: data['sections'] as List<ClassSectionEntity>,
          studyLevel: data['studyLevel'] as String,
        ),

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);

          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.updateClass,
    path: RoutePath.updateClass,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: UpdateClassScreen(
          entity: data['entity'] as ClassEntity,
          sections: data['sections'] as List<ClassSectionEntity>,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.studentProfile,
    path: RoutePath.studentProfile,
    pageBuilder: (context, state) {
      final student = state.extra as StudentEntity;
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),

        child: StudentProfileScreen(student: student),

        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);

          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.studentsSearch,
    path: RoutePath.studentsSearch,
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: StudentsSearchScreen(
          query: data['query'] as String,
          initialData: data['initialData'] as List<StudentEntity>,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.addStudent,
    path: RoutePath.addStudent,
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: AddStudentScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.studentFilterScreen,
    path: RoutePath.studentFilterScreen,
    pageBuilder: (context, state) {
      final params = state.extra as FilterParams?;
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: StudentFilterScreen(initialParams: params),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
  GoRoute(
    name: RouteName.updateStudent,
    path: RoutePath.updateStudent,
    pageBuilder: (context, state) {
      final student = state.extra as StudentEntity;
      return CustomTransitionPage(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        child: UpdateStudentScreen(studentEntity: student),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final fade = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(position: slide, child: child),
          );
        },
      );
    },
  ),
];
