import 'dart:async';

import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_screens/student_filter_screen.dart';
import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../config/theme/colors.dart';
import '../../../../../../core/helper/helper.dart';
import '../../../../../../core/providers/language_provider.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../../domain/entities/filter_params.dart';
import '../../../../domain/repository/student_repository.dart';
import '../../../bloc/selection_cubit/selection_cubit.dart';
import '../../../bloc/selection_cubit/selection_state.dart';
import '../../../widgets/filter_chip.dart';
import '../../../widgets/overview_screen_appBar.dart';
import '../../../widgets/state_cart.dart';
import '../../../widgets/student_search_text_field.dart';
import '../student_screens/students_overview_screen.dart';

class ClassesOverviewScreen extends ConsumerStatefulWidget {
  final List<StudentEntity>? filterDataList;
  final FilterParams? params;
  const ClassesOverviewScreen({super.key, this.filterDataList, this.params});

  @override
  ConsumerState<ClassesOverviewScreen> createState() =>
      _StudentsListScreenState();
}

class _StudentsListScreenState extends ConsumerState<ClassesOverviewScreen> {
  final FocusNode searchFocusNode = FocusNode();

  late StreamSubscription subscription;
  late List<StudentEntity>? filterDataList;
  bool isFilterLoading = false;
  bool isLoading = false;

  final BehaviorSubject<int> studentCountSubject = BehaviorSubject<int>();
  @override
  void dispose() {
    subscription.cancel();
    studentCountSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    filterDataList = widget.filterDataList;

    final stream = sl<StudentRepository>().watchStudentsCount().getOrElse(
      () => const Stream.empty(),
    );

    subscription = stream.listen((value) {
      studentCountSubject.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider).value;

    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final isMode = context.read<SelectionCubit>().state.isSelectionMode;

        if (isMode) {
          context.read<SelectionCubit>().clearSelection();
          return false;
        }
        if (searchFocusNode.hasFocus) {
          searchFocusNode.unfocus();
          return false;
        }

        return true;
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            searchFocusNode.unfocus();

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
                      Row(
                        children: [
                          StudentSearchTextField(
                            width: (820 * screenWidth) / 1080,
                            searchFocusNode: searchFocusNode,
                          ),
                          Spacer(),

                          InkWell(
                            borderRadius: BorderRadius.circular(12.r),

                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer.withOpacity(
                                  0.4,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0.w),
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                  size: 26.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // StatsRow==================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StreamBuilder<int>(
                            stream: studentCountSubject,
                            builder: (context, snapshot) {
                              final isLoading =
                                  snapshot.connectionState ==
                                  ConnectionState.waiting;

                              final count = snapshot.data ?? 0;
                              return Expanded(
                                child: StatCard(
                                  lineColor: AppColors.primary,
                                  isDesktop: false,
                                  label: S.of(context).totalStudents,
                                  value: isLoading
                                      ? '...'
                                      : Helper.formatNumber(count),
                                  valueColor: AppColors.primary,
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 16),

                          Expanded(
                            child: StatCard(
                              lineColor: AppColors.tertiary,
                              isDesktop: false,
                              label: S.of(context).totalClasses,
                              value: Helper.formatNumber(20000),
                              valueColor: AppColors.tertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // filter results==================================
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 450),
                        transitionBuilder: (child, animation) {
                          final offsetAnimation = Tween<Offset>(
                            begin: Offset(-1, 0),
                            end: Offset(0, 0),
                          ).animate(animation);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        child: filterDataList != null
                            ? Column(
                                key: ValueKey(1),
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person_search_outlined,
                                            color: AppColors.primary,
                                            size: 20.sp,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            S.of(context).resultsFound,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: AppColors.outline,
                                            ),
                                          ),
                                          SizedBox(width: 2),

                                          Text(
                                            " ${filterDataList!.length} ",
                                            style: TextStyle(
                                              fontSize: 13.sp,

                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 3,
                                            ),
                                            child: Text(
                                              S.of(context).students,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 13.sp,

                                                height: 1,
                                                color: AppColors.outline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            filterDataList = null;
                                          });
                                        },
                                        child: Text(
                                          S.of(context).clearFilters,
                                          style: GoogleFonts.inter(
                                            color: AppTheme.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      clipBehavior: Clip.none,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: Row(
                                        children: [
                                          CustomFilterChip(
                                            label:
                                                (widget
                                                            .params
                                                            ?.selectedStudyLevel ==
                                                        null ||
                                                    widget
                                                            .params!
                                                            .selectedStudyLevel
                                                            .order ==
                                                        0)
                                                ? S.of(context).allClasses
                                                : (language == Language.ar
                                                      ? widget
                                                            .params!
                                                            .selectedStudyLevel
                                                            .arabicName
                                                      : widget
                                                            .params!
                                                            .selectedStudyLevel
                                                            .englishName),
                                            bgColor: AppTheme.primaryContainer,
                                            textColor:
                                                AppTheme.onPrimaryContainer,
                                            onTap: () {
                                              context
                                                  .read<SelectionCubit>()
                                                  .clearSelection();
                                              searchFocusNode.unfocus();

                                              FocusScope.of(context).unfocus();

                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration: Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  reverseTransitionDuration:
                                                      Duration(
                                                        milliseconds: 300,
                                                      ),

                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) {
                                                        return StudentFilterScreen(
                                                          initialParams:
                                                              widget.params,
                                                        );
                                                      },

                                                  transitionsBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child,
                                                      ) {
                                                        final slide =
                                                            Tween<Offset>(
                                                              begin: Offset(
                                                                0,
                                                                1,
                                                              ),
                                                              end: Offset.zero,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        final fade =
                                                            Tween<double>(
                                                              begin: 0,
                                                              end: 1,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        return FadeTransition(
                                                          opacity: fade,
                                                          child:
                                                              SlideTransition(
                                                                position: slide,
                                                                child: child,
                                                              ),
                                                        );
                                                      },
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          CustomFilterChip(
                                            label:
                                                (widget
                                                            .params
                                                            ?.selectedDivision ==
                                                        null ||
                                                    widget
                                                            .params
                                                            ?.selectedDivision ==
                                                        DivisionEnum.all)
                                                ? S.of(context).allSections
                                                : (language == Language.ar
                                                      ? widget
                                                            .params!
                                                            .selectedDivision
                                                            .arabic
                                                      : widget
                                                            .params!
                                                            .selectedDivision
                                                            .english),
                                            bgColor:
                                                AppTheme.secondaryContainer,
                                            textColor:
                                                AppTheme.onSecondaryContainer,
                                            onTap: () {
                                              context
                                                  .read<SelectionCubit>()
                                                  .clearSelection();
                                              searchFocusNode.unfocus();

                                              FocusScope.of(context).unfocus();

                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration: Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  reverseTransitionDuration:
                                                      Duration(
                                                        milliseconds: 300,
                                                      ),

                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) {
                                                        return StudentFilterScreen(
                                                          initialParams:
                                                              widget.params,
                                                        );
                                                      },

                                                  transitionsBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child,
                                                      ) {
                                                        final slide =
                                                            Tween<Offset>(
                                                              begin: Offset(
                                                                0,
                                                                1,
                                                              ),
                                                              end: Offset.zero,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        final fade =
                                                            Tween<double>(
                                                              begin: 0,
                                                              end: 1,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        return FadeTransition(
                                                          opacity: fade,
                                                          child:
                                                              SlideTransition(
                                                                position: slide,
                                                                child: child,
                                                              ),
                                                        );
                                                      },
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          CustomFilterChip(
                                            label:
                                                (widget
                                                        .params
                                                        ?.selectedPaymentType ==
                                                    null)
                                                ? S.of(context).allPaymentTypes
                                                : (language == Language.ar
                                                      ? widget
                                                            .params!
                                                            .selectedPaymentType!
                                                            .arabic
                                                      : widget
                                                            .params!
                                                            .selectedPaymentType!
                                                            .english),
                                            bgColor:
                                                AppTheme.secondaryContainer,
                                            textColor:
                                                AppTheme.onSecondaryContainer,
                                            onTap: () {
                                              context
                                                  .read<SelectionCubit>()
                                                  .clearSelection();
                                              searchFocusNode.unfocus();

                                              FocusScope.of(context).unfocus();

                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration: Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  reverseTransitionDuration:
                                                      Duration(
                                                        milliseconds: 300,
                                                      ),

                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) {
                                                        return StudentFilterScreen(
                                                          initialParams:
                                                              widget.params,
                                                        );
                                                      },

                                                  transitionsBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child,
                                                      ) {
                                                        final slide =
                                                            Tween<Offset>(
                                                              begin: Offset(
                                                                0,
                                                                1,
                                                              ),
                                                              end: Offset.zero,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        final fade =
                                                            Tween<double>(
                                                              begin: 0,
                                                              end: 1,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        return FadeTransition(
                                                          opacity: fade,
                                                          child:
                                                              SlideTransition(
                                                                position: slide,
                                                                child: child,
                                                              ),
                                                        );
                                                      },
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          CustomFilterChip(
                                            label:
                                                (widget
                                                        .params
                                                        ?.selectedStudentStates ==
                                                    null)
                                                ? S.of(context).allStudentStatus
                                                : (language == Language.ar
                                                      ? widget
                                                            .params!
                                                            .selectedStudentStates!
                                                            .arabic
                                                      : widget
                                                            .params!
                                                            .selectedStudentStates!
                                                            .english),
                                            bgColor:
                                                AppTheme.secondaryContainer,
                                            textColor:
                                                AppTheme.onSecondaryContainer,
                                            onTap: () {
                                              context
                                                  .read<SelectionCubit>()
                                                  .clearSelection();
                                              searchFocusNode.unfocus();

                                              FocusScope.of(context).unfocus();

                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration: Duration(
                                                    milliseconds: 300,
                                                  ),
                                                  reverseTransitionDuration:
                                                      Duration(
                                                        milliseconds: 300,
                                                      ),

                                                  pageBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                      ) {
                                                        return StudentFilterScreen(
                                                          initialParams:
                                                              widget.params,
                                                        );
                                                      },

                                                  transitionsBuilder:
                                                      (
                                                        context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child,
                                                      ) {
                                                        final slide =
                                                            Tween<Offset>(
                                                              begin: Offset(
                                                                0,
                                                                1,
                                                              ),
                                                              end: Offset.zero,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        final fade =
                                                            Tween<double>(
                                                              begin: 0,
                                                              end: 1,
                                                            ).animate(
                                                              animation,
                                                            );

                                                        return FadeTransition(
                                                          opacity: fade,
                                                          child:
                                                              SlideTransition(
                                                                position: slide,
                                                                child: child,
                                                              ),
                                                        );
                                                      },
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                ],
                              )
                            : SizedBox(
                                key: ValueKey(2), // مهم جدًا
                              ),
                      ),

                      // List==================================
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<SelectionCubit, SelectionState>(
                      builder: (context, state) {
                        final cubit = context.read<SelectionCubit>();
                        final isSelectedMode = state.isSelectionMode;
                        final totalNumber = state.selectedIds.length;
                        if (isSelectedMode) {
                          return Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  MaterialButton(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 3,
                                    ),
                                    color: AppColors.error.withOpacity(1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () async {
                                      if (isLoading) return;
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        final addResult =
                                            await sl<StudentRepository>()
                                                .softDeleteStudents(
                                                  state.selectedIds,
                                                );

                                        addResult.fold(
                                          ifLeft: (e) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: AwesomeSnackbarContent(
                                                  inMaterialBanner: true,
                                                  title: S
                                                      .of(context)
                                                      .wrongHappened,
                                                  message: S
                                                      .of(context)
                                                      .tryAgainLater,
                                                  contentType:
                                                      ContentType.failure,
                                                ),
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0,
                                              ),
                                            );
                                          },
                                          ifRight: (response) {
                                            if (response == null) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content:
                                                      AwesomeSnackbarContent(
                                                        inMaterialBanner: true,
                                                        title: S
                                                            .of(context)
                                                            .success,
                                                        message: S
                                                            .of(context)
                                                            .studentDeleted,
                                                        contentType:
                                                            ContentType.success,
                                                      ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content:
                                                      AwesomeSnackbarContent(
                                                        inMaterialBanner: true,
                                                        title: S
                                                            .of(context)
                                                            .wrongHappened,
                                                        message: S
                                                            .of(context)
                                                            .tryAgainLater,
                                                        contentType:
                                                            ContentType.failure,
                                                      ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: AwesomeSnackbarContent(
                                              inMaterialBanner: true,
                                              title: S
                                                  .of(context)
                                                  .wrongHappened,
                                              message: S
                                                  .of(context)
                                                  .tryAgainLater,
                                              contentType: ContentType.failure,
                                            ),
                                            backgroundColor: Colors.transparent,
                                            elevation: 0,
                                          ),
                                        );
                                      } finally {
                                        cubit.clearSelection();
                                        if (mounted) {
                                          setState(() => isLoading = false);
                                        }
                                      }
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Opacity(
                                          opacity: isLoading ? 0 : 1,
                                          child: Text(
                                            S.of(context).delete,
                                            style: TextStyle(
                                              fontSize: 13.sp,

                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        isLoading
                                            ? SizedBox(
                                                height: 16,
                                                width: 16,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2.5,
                                                      color:
                                                          AppColors.onPrimary,
                                                    ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    ' $totalNumber ',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).selected,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () async {
                                      final result =
                                          await sl<StudentRepository>()
                                              .getAllItemsNotArchived();
                                      result.fold(
                                        ifLeft: (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: AwesomeSnackbarContent(
                                                inMaterialBanner: true,
                                                title: S
                                                    .of(context)
                                                    .wrongHappened,
                                                message: S
                                                    .of(context)
                                                    .tryAgainLater,
                                                contentType:
                                                    ContentType.failure,
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ),
                                          );
                                        },
                                        ifRight: (d) {
                                          final newSet = d
                                              .map((e) => e.entityId)
                                              .toSet();
                                          cubit.selectAll(newSet.toList());
                                        },
                                      );
                                    },
                                    child: Text(
                                      S.of(context).selectAll,
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      cubit.clearSelection();
                                    },
                                    child: Text(
                                      S.of(context).cancel,
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    BottomNavigationBar(
                      onTap: (index) async {
                        context.read<SelectionCubit>().clearSelection();
                        if (index == 0) {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassesOverviewScreen(),
                            ),
                          );*/
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentsOverviewScreen(),
                            ),
                          );
                        } else if (index == 2) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ClassesOverviewScreen(),
                          //   ),
                          // );
                        }
                      },
                      currentIndex: 2,
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.dashboard_outlined, size: 24.sp),
                          activeIcon: Icon(Icons.dashboard, size: 24.sp),
                          label: S.of(context).dashboard,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.group_outlined, size: 24.sp),
                          activeIcon: Icon(Icons.group, size: 24.sp),
                          label: S.of(context).theStudents,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.class_outlined, size: 24.sp),
                          activeIcon: Icon(Icons.class_, size: 24.sp),
                          label: S.of(context).classes,
                        ),
                      ],
                    ),
                  ],
                ),

                BlocBuilder<SelectionCubit, SelectionState>(
                  builder: (context, state) {
                    final cubit = context.read<SelectionCubit>();
                    final isSelectedMode = state.isSelectionMode;
                    return AnimatedPositionedDirectional(
                      duration: Duration(milliseconds: 300),
                      bottom: isSelectedMode ? 100 : 50,
                      end: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: AppTheme.primary,
                          child: Icon(Icons.add_card, size: 24.sp),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
