import 'dart:async';

import 'package:admain_center_managment_app/config/route/route.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_repository.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/classes_grid.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../core/helper/helper.dart';
import '../../../../../../core/providers/language_provider.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../domain/repository/student_repository.dart';
import '../../../widgets/overview_screen_appBar.dart';

class ClassesOverviewScreen extends ConsumerStatefulWidget {
  const ClassesOverviewScreen({super.key});

  @override
  ConsumerState<ClassesOverviewScreen> createState() =>
      _StudentsListScreenState();
}

class _StudentsListScreenState extends ConsumerState<ClassesOverviewScreen> {
  late StreamSubscription subscription;
  late StreamSubscription classSubscription;

  bool isLoading = false;

  final BehaviorSubject<int> studentCountSubject = BehaviorSubject<int>();
  final BehaviorSubject<int> classCountSubject = BehaviorSubject<int>();
  @override
  void dispose() {
    subscription.cancel();
    studentCountSubject.close();
    classSubscription.cancel();
    classCountSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final stream = sl<StudentRepository>().watchStudentsCount().getOrElse(
      () => const Stream.empty(),
    );
    subscription = stream.listen((value) {
      studentCountSubject.add(value);
    });
    final classStream = sl<ClassRepository>().watchClassesCount().getOrElse(
      () => const Stream.empty(),
    );
    classSubscription = classStream.listen((value) {
      classCountSubject.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider).value;

    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: OverviewScreenAppBar(label: S.of(context).classes),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    100,
                  ), // Padding for bottom nav & FAB
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _SectionHeader(),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          StreamBuilder<int>(
                            stream: classCountSubject,
                            builder: (context, snapshot) {
                              final isLoading =
                                  snapshot.connectionState ==
                                  ConnectionState.waiting;
                              final count = snapshot.data ?? 0;
                              return Expanded(
                                child: _StatCard(
                                  title: 'عدد الفصول',
                                  value: isLoading
                                      ? '...'
                                      : Helper.formatNumber(count),
                                  iconData: Icons.school,
                                  color: AppTheme.primary,
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 16),

                          StreamBuilder<int>(
                            stream: studentCountSubject,
                            builder: (context, snapshot) {
                              final isLoading =
                                  snapshot.connectionState ==
                                  ConnectionState.waiting;
                              final count = snapshot.data ?? 0;
                              return Expanded(
                                child: _StatCard(
                                  title: S.of(context).totalStudents,
                                  value: isLoading
                                      ? '...'
                                      : Helper.formatNumber(count),
                                  iconData: Icons.groups,
                                  color: AppTheme.tertiary,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // List==================================
                      ClassesGrid(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'نظرة عامة',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'إدارة الفصول',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
                color: AppTheme.onSurface,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.pushNamed(RouteName.createClass);
              },
              borderRadius: BorderRadius.circular(14),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.add, color: AppTheme.onPrimary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return PressableButton(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          border: Border.all(color: color.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: color, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
