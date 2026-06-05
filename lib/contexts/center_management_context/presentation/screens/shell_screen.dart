import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/route/route_name.dart';
import '../../../../config/route/route_path.dart';
import '../../../../core/enums/navbar_item.dart';
import '../../../../core/providers/nav_bar_provider.dart';
import '../widgets/bottom_nav_bar.dart';

class ShellScreen extends ConsumerStatefulWidget {
  const ShellScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      GoRouter.of(context).routerDelegate.addListener(() {
        if (mounted) {
          final navItem = getCurrentRoute();
          final navProv = ref.read(navBarProvider);
          if (navItem != navProv) {
            ref.read(navBarProvider.notifier).state = navItem;
          }
        }
      });
    });
  }

  NavbarItem getCurrentRoute() {
    final currentRoute = GoRouter.of(context).state.uri;
    try {
      RegExp regExp = RegExp(r'^/\w+\b');
      var firstRoute = regExp.firstMatch(currentRoute.toString())?.group(0);
      if (firstRoute != null) {
        if (firstRoute == RoutePath.studentsOverview) {
          return NavbarItem.StudentsOverview;
        } else if (firstRoute == RoutePath.classesOverview) {
          return NavbarItem.ClassesOverview;
        } else {
          return NavbarItem.ClassesOverview;
        }
      }
      return NavbarItem.StudentsOverview;
    } catch (e) {
      return NavbarItem.StudentsOverview;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (GoRouter.of(context).canPop()) {
          return false;
        }
        final navItem = getCurrentRoute();
        if (navItem != NavbarItem.StudentsOverview) {
          ref.read(navBarProvider.notifier).state = NavbarItem.StudentsOverview;
          context.goNamed(RouteName.studentsOverview);
          return false;
        }

        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: widget.navigationShell),
              BottomNavBar(navigationShell: widget.navigationShell),
            ],
          ),
        ),
      ),
    );
  }
}
