import 'package:admain_center_managment_app/config/route/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_route.dart';

final appRouteProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePath.studentsOverview,
    navigatorKey: parentNavigationKey,
    routes: appRoute,
  );
});
