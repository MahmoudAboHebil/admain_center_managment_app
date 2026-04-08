import 'dart:async';

import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_filter_screen.dart';
import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../bloc/selection_cubit/selection_cubit.dart';
import '../../bloc/selection_cubit/selection_state.dart';
import '../../widgets/state_cart.dart';
import '../../widgets/student_search_text_field.dart';
import '../../widgets/students_grid.dart';
import '../../widgets/top_appBar.dart';
import 'add_student_screen.dart';

Future<void> testInternet() async {
  final res = await http.get(Uri.parse("https://google.com"));
  print('ddddddddd ${res.statusCode}');
}

class StudentsListScreen extends StatefulWidget {
  final List<StudentEntity>? filterDataList;
  final FilterParams? params;
  const StudentsListScreen({super.key, this.filterDataList, this.params});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
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
            appBar: StudentsScreenAppBar(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StudentSearchTextField(
                            width: (530 * screenWidth) / 720,
                            searchFocusNode: searchFocusNode,
                          ),
                          Spacer(),

                          InkWell(
                            borderRadius: BorderRadius.circular(12),

                            onTap: () async {
                              context.read<SelectionCubit>().clearSelection();
                              searchFocusNode.unfocus();

                              FocusScope.of(context).unfocus();

                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(
                                    milliseconds: 300,
                                  ),
                                  reverseTransitionDuration: Duration(
                                    milliseconds: 300,
                                  ),

                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                        return StudentFilterScreen();
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer.withOpacity(
                                  0.4,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
                                  label: 'إجمالي الطلاب',
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
                              label: 'الفصول النشطة',
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
                                            size: 20,
                                          ),
                                          Text(
                                            "  تم العثور على ",
                                            style: TextStyle(
                                              color: AppColors.outline,
                                            ),
                                          ),
                                          Text(
                                            " ${filterDataList!.length} ",
                                            style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 3,
                                            ),
                                            child: Text(
                                              "طلاب",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
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
                                          'مسح الفلتر',
                                          style: GoogleFonts.inter(
                                            color: AppTheme.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
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
                                          _buildFilterChip(
                                            (widget.params?.selectedStudyLevel ==
                                                        null ||
                                                    widget
                                                            .params!
                                                            .selectedStudyLevel
                                                            .order ==
                                                        0)
                                                ? "الصف الدراسي الكل "
                                                : widget
                                                      .params!
                                                      .selectedStudyLevel
                                                      .arabicName,
                                            AppTheme.primaryContainer,
                                            AppTheme.onPrimaryContainer,
                                          ),
                                          const SizedBox(width: 8),
                                          _buildFilterChip(
                                            (widget.params?.selectedDivision ==
                                                        null ||
                                                    widget
                                                            .params
                                                            ?.selectedDivision ==
                                                        DivisionEnum.all)
                                                ? "الشعبة الكل "
                                                : widget
                                                      .params!
                                                      .selectedDivision
                                                      .description,
                                            AppTheme.secondaryContainer,
                                            AppTheme.onSecondaryContainer,
                                          ),
                                          const SizedBox(width: 8),
                                          _buildFilterChip(
                                            (widget
                                                        .params
                                                        ?.selectedPaymentType ==
                                                    null)
                                                ? "نظام الدفع الكل "
                                                : widget
                                                      .params!
                                                      .selectedPaymentType!
                                                      .description,
                                            AppTheme.secondaryContainer,
                                            AppTheme.onSecondaryContainer,
                                          ),
                                          const SizedBox(width: 8),
                                          _buildFilterChip(
                                            (widget
                                                        .params
                                                        ?.selectedStudentStates ==
                                                    null)
                                                ? "حالة الطالب الكل "
                                                : widget
                                                      .params!
                                                      .selectedStudentStates!
                                                      .description,
                                            AppTheme.secondaryContainer,
                                            AppTheme.onSecondaryContainer,
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
                      StudentsGrid(
                        isLoading: isFilterLoading,
                        filterDataList: filterDataList,
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
                                      vertical: 13,
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
                                                  title: "حدث خطأ",
                                                  message:
                                                      "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                                                        title: "تم بنجاح",
                                                        message:
                                                            "تم حذف الطالب",
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
                                                    title: "حدث خطأ",
                                                    message:
                                                        "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                                              title: "حدث خطأ",
                                              message:
                                                  "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                                            'حذف',
                                            style: TextStyle(
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
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'محدد',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
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
                                                title: "حدث خطأ",
                                                message:
                                                    "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                                    child: Text('تحديد الكل'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      cubit.clearSelection();
                                    },
                                    child: Text('الغاء'),
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
                        await testInternet();
                        context.read<SelectionCubit>().clearSelection();
                      },
                      currentIndex: 1, // "الطلاب" active
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.dashboard_outlined),
                          activeIcon: Icon(Icons.dashboard),
                          label: 'لوحة القيادة',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.group_outlined),
                          activeIcon: Icon(Icons.group),
                          label: 'الطلاب',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.class_outlined),
                          activeIcon: Icon(Icons.class_),
                          label: 'الفصول',
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
                            searchFocusNode.unfocus();

                            FocusScope.of(context).unfocus();
                            print('dddddd${searchFocusNode.hasFocus}');

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
                          child: const Icon(Icons.person_add),
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

  Widget _buildFilterChip(String label, Color bgColor, Color textColor) {
    return MaterialButton(
      onPressed: () {
        context.read<SelectionCubit>().clearSelection();
        searchFocusNode.unfocus();

        FocusScope.of(context).unfocus();

        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            reverseTransitionDuration: Duration(milliseconds: 300),

            pageBuilder: (context, animation, secondaryAnimation) {
              return StudentFilterScreen();
            },

            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
                    child: SlideTransition(position: slide, child: child),
                  );
                },
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: bgColor,
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.close, size: 16, color: textColor),
          ],
        ),
      ),
    );
  }
}

class StudentsScreenAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const StudentsScreenAppBar({super.key});

  @override
  State<StudentsScreenAppBar> createState() => _StudentsScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _StudentsScreenAppBarState extends State<StudentsScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(children: [TopAppBar(isDesktop: false, label: 'الطلاب')]),
    );
  }
}

/*
final students = [
  StudentModel(
    entityId: '15',
    centerId: 'center_1',
    byUser: 'admin',
    byDevice: 'device_1',
    isDeleted: false,
    version: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    name: 'Ahmed Mohamed',
    studyLevelId: 'dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61',
    gender: Gender.male,
    studentCode: 'STD001',
    phone: '01000000001',
    parentPhone: '01100000001',
    paymentTypeEnum: PaymentTypeEnum.byMonth,
    divisionEnum: DivisionEnum.scientificMathematicsSection,
    studentStatus: StudentStatus.active,
  ),
  StudentModel(
    entityId: '16',
    centerId: 'center_1',
    byUser: 'admin',
    byDevice: 'device_1',
    isDeleted: false,
    version: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    name: 'Ahmed Mohamed',
    studyLevelId: 'dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61',
    gender: Gender.male,
    studentCode: 'STD001',
    phone: '01000000001',
    parentPhone: '01100000001',
    paymentTypeEnum: PaymentTypeEnum.byMonth,
    divisionEnum: DivisionEnum.scientificMathematicsSection,
    studentStatus: StudentStatus.active,
  ),
  StudentModel(
    entityId: '17',
    centerId: 'center_1',
    byUser: 'admin',
    byDevice: 'device_1',
    isDeleted: false,
    version: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    name: 'Ahmed Mohamed',
    studyLevelId: 'dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61',
    gender: Gender.male,
    studentCode: 'STD001',
    phone: '01000000001',
    parentPhone: '01100000001',
    paymentTypeEnum: PaymentTypeEnum.byMonth,
    divisionEnum: DivisionEnum.scientificMathematicsSection,
    studentStatus: StudentStatus.active,
  ),
  StudentModel(
    entityId: '18',
    centerId: 'center_1',
    byUser: 'admin',
    byDevice: 'device_1',
    isDeleted: false,
    version: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    name: 'Ahmed Mohamed',
    studyLevelId: 'dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61',
    gender: Gender.male,
    studentCode: 'STD001',
    phone: '01000000001',
    parentPhone: '01100000001',
    paymentTypeEnum: PaymentTypeEnum.byMonth,
    divisionEnum: DivisionEnum.scientificMathematicsSection,
    studentStatus: StudentStatus.active,
  ),
  StudentModel(
    entityId: '19',
    centerId: 'center_1',
    byUser: 'admin',
    byDevice: 'device_1',
    isDeleted: false,
    version: 1,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    name: 'Ahmed Mohamed',
    studyLevelId: 'dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61',
    gender: Gender.male,
    studentCode: 'STD001',
    phone: '01000000001',
    parentPhone: '01100000001',
    paymentTypeEnum: PaymentTypeEnum.byMonth,
    divisionEnum: DivisionEnum.scientificMathematicsSection,
    studentStatus: StudentStatus.active,
  ),
];
for (var item in students) {
final result = await sl<AddEntityLocalUseCase>().call(
AddEntityLocalUseCaseParams(
table: DBTable.students,
jsonEntity: null,
entity: item.toEntity(),
),
);
result.fold(
ifLeft: (e) {
print(e);
},
ifRight: (d) {},
);
}

 */
