import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/l10n.dart';
import '../bloc/selection_cubit/selection_cubit.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BottomNavigationBar(
          onTap: (index) async {
            context.read<SelectionCubit>().clearSelection();
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
            // if (index == 1) {

            //   if (GoRouter.of(context).state.uri.toString() !=
            //       RoutePath.studentsOverview) {
            //     context.goNamed(RouteName.studentsOverview);
            //     print('studentsOverview');
            //   }
            // } else if (index == 0) {
            //   if (GoRouter.of(context).state.uri.toString() !=
            //       RoutePath.classesOverview) {
            //     context.goNamed(RouteName.classesOverview);
            //     print('classesOverview');
            //   }
            // }
          },
          currentIndex: navigationShell.currentIndex,
          items: [
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.dashboard_outlined, size: 24.sp),
            //   activeIcon: Icon(Icons.dashboard, size: 24.sp),
            //   label: S.of(context).dashboard,
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.class_outlined, size: 24.sp),
              activeIcon: Icon(Icons.class_, size: 24.sp),
              label: S.of(context).classes,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined, size: 24.sp),
              activeIcon: Icon(Icons.group, size: 24.sp),
              label: S.of(context).theStudents,
            ),
          ],
        ),
      ],
    );
  }
}
