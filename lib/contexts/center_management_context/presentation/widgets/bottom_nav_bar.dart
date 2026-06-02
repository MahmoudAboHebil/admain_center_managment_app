import 'package:admain_center_managment_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/route/route_name.dart';
import '../../../../config/route/route_path.dart';
import '../../../../core/enums/navbar_item.dart';
import '../../../../generated/l10n.dart';
import 'animated_bottom_nav_tap.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.secondary, width: 1.5)),
      ),
      height: 50.spMin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedBottomNavTap(
            icon: Icons.group_outlined,
            text: S.of(context).theStudents,
            isLight: true,
            iconSize: 24.sp,
            navItem: NavbarItem.StudentsOverview,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() !=
                  RoutePath.studentsOverview) {
                context.goNamed(RouteName.studentsOverview);
                print('studentsOverview');
              }
            },
          ),
          AnimatedBottomNavTap(
            icon: Icons.class_outlined,
            text: S.of(context).classes,
            isLight: true,
            iconSize: 24.sp,
            navItem: NavbarItem.ClassesOverview,
            callBack: () {
              if (GoRouter.of(context).state.uri.toString() !=
                  RoutePath.classesOverview) {
                context.goNamed(RouteName.classesOverview);
                print('classesOverview');
              }
            },
          ),
        ],
      ),
    );
  }
}

//
// [
// BottomNavigationBarItem(
// icon: Icon(Icons.dashboard_outlined, size: 24.sp),
// activeIcon: Icon(Icons.dashboard, size: 24.sp),
// label: S.of(context).dashboard,
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.group_outlined, size: 24.sp),
// activeIcon: Icon(Icons.group, size: 24.sp),
// label: S.of(context).theStudents,
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.class_outlined, size: 24.sp),
// activeIcon: Icon(Icons.class_, size: 24.sp),
// label: S.of(context).classes,
// ),
// ],
