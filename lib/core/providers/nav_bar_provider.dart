import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/navbar_item.dart';

final navBarProvider = StateProvider<NavbarItem>(
  (ref) => NavbarItem.StudentsOverview,
);
