import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/add_student_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../bloc/selection_cubit/selection_cubit.dart';
import '../../bloc/selection_cubit/selection_state.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/students_grid.dart';

class StudentsSearchScreen extends StatefulWidget {
  final String query;
  final List<StudentEntity> initialData;
  const StudentsSearchScreen({
    super.key,
    required this.query,
    required this.initialData,
  });

  @override
  State<StudentsSearchScreen> createState() => _StudentsSearchScreenState();
}

class _StudentsSearchScreenState extends State<StudentsSearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  late List<StudentEntity> searchData;
  bool isGettingData = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchData = widget.initialData;
    searchController.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
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
        child: Scaffold(
          appBar: CustomAppBar(label: S.of(context).studentSearch),
          // extendBodyBehindAppBar: true,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            focusNode: searchFocusNode,
                            onChanged: (text) async {
                              setState(() {
                                isGettingData = true;
                                searchData = [];
                              });
                              if (text.isNotEmpty) {
                                final result = await sl<StudentRepository>()
                                    .getEntitiesNameStartWith(text);
                                await result.fold(
                                  ifLeft: (_) {
                                    /// todo: you need handle this
                                    setState(() {
                                      isGettingData = false;
                                    });
                                  },
                                  ifRight: (data) async {
                                    await Future.delayed(
                                      Duration(milliseconds: 250),
                                    );
                                    setState(() {
                                      searchData = data;
                                      isGettingData = false;
                                    });
                                  },
                                );
                              } else {
                                setState(() {
                                  isGettingData = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: S.of(context).searchByName,
                              prefixIcon: Icon(Icons.search, size: 20.sp),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              fillColor: searchFocusNode.hasFocus
                                  ? Colors.white
                                  : AppColors.surfaceContainerHigh.withOpacity(
                                      0.3,
                                    ),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // StatsRow==================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search_outlined,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                        Text(
                          S.of(context).resultsFound,
                          style: TextStyle(
                            color: AppColors.outline,
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          " ${searchData.length} ",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            S.of(context).students,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              height: 1,
                              fontSize: 13.sp,
                              color: AppColors.outline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // List==================================
                    StudentsGrid(
                      isLoading: isGettingData,
                      filterDataList: searchData,
                    ),
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
                                            setState(() {
                                              searchData = searchData.where((
                                                element,
                                              ) {
                                                return !state.selectedIds
                                                    .contains(element.entityId);
                                              }).toList();
                                            });
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: AwesomeSnackbarContent(
                                                  inMaterialBanner: true,
                                                  title: S.of(context).success,
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
                                            title: S.of(context).wrongHappened,
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
                                            color: Colors.white,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                                      isLoading
                                          ? SizedBox(
                                              height: 16,
                                              width: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                color: AppColors.onPrimary,
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
                                    final result = await sl<StudentRepository>()
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
                                              contentType: ContentType.failure,
                                            ),
                                            backgroundColor: Colors.transparent,
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
                                    style: TextStyle(
                                      color: AppColors.outline,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cubit.clearSelection();
                                  },
                                  child: Text(
                                    S.of(context).cancel,
                                    style: TextStyle(
                                      color: AppColors.outline,
                                      fontSize: 13.sp,
                                    ),
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
                    onTap: (index) {
                      context.read<SelectionCubit>().clearSelection();
                    },
                    currentIndex: 1, // "الطلاب" active
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
                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    bottom: isSelectedMode ? 100 : 50,
                    left: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          context.read<SelectionCubit>().clearSelection();

                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 300),
                              reverseTransitionDuration: Duration(
                                milliseconds: 300,
                              ),

                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    return AddStudentScreen();
                                  },

                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    final slide = Tween<Offset>(
                                      begin: Offset(0, 1),
                                      end: Offset.zero,
                                    ).animate(animation);

                                    final fade = Tween<double>(
                                      begin: 0,
                                      end: 1,
                                    ).animate(animation);

                                    return FadeTransition(
                                      opacity: fade,
                                      child: SlideTransition(
                                        position: slide,
                                        child: child,
                                      ),
                                    );
                                  },
                            ),
                          );
                        },
                        backgroundColor: AppTheme.primary,
                        child: Icon(Icons.person_add, size: 24.sp),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
