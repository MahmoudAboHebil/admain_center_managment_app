import 'dart:async';

import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/student_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../core/helper/helper.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/repository/student_repository.dart';
import '../../widgets/state_cart.dart';
import '../../widgets/student_search_text_field.dart';
import '../../widgets/students_grid.dart';
import '../../widgets/top_appBar.dart';
import 'add_student_screen.dart';

class StudentsListScreen extends StatefulWidget {
  final List<StudentEntity>? filterDataList;
  final FilterParams? params;
  const StudentsListScreen({super.key, this.filterDataList, this.params});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  late StreamSubscription subscription;
  late List<StudentEntity>? filterDataList;
  bool isFilterLoading = false;

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
    return Scaffold(
      appBar: StudentsScreenAppBar(),
      // extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                StudentSearchTextField(),
                Spacer(),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: AppColors.surfaceContainerHigh,
                  elevation: 0,
                  focusElevation: 0,
                  highlightElevation: 0,
                  disabledElevation: 0,
                  hoverElevation: 0,
                  padding: EdgeInsets.zero,

                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return StudentFilterScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.filter_list,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'تصفيه',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
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
                        snapshot.connectionState == ConnectionState.waiting;

                    final count = snapshot.data ?? 0;
                    return Expanded(
                      child: StatCard(
                        isDesktop: false,
                        label: 'إجمالي الطلاب',
                        value: isLoading ? '...' : Helper.formatNumber(count),
                        valueColor: AppColors.tertiary,
                      ),
                    );
                  },
                ),
                SizedBox(width: 16),

                Expanded(
                  child: StatCard(
                    isDesktop: false,
                    label: 'الفصول النشطة',
                    value: Helper.formatNumber(20000),
                    valueColor: AppColors.tertiary,
                  ),
                ),
                SizedBox(width: 16),

                Expanded(
                  child: const StatCard(
                    isDesktop: false,

                    label: 'متوسط الحضور',
                    value: '89.9%',
                    valueColor: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // filter results==================================
            filterDataList != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_search_outlined,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              Text(
                                "  تم العثور على ",
                                style: TextStyle(color: AppColors.outline),
                              ),
                              Text(
                                " ${filterDataList!.length} ",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "طلاب",
                                style: TextStyle(color: AppColors.outline),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                isFilterLoading = true;
                              });
                              await Future.delayed(Duration(milliseconds: 350));
                              setState(() {
                                filterDataList = null;
                                isFilterLoading = false;
                              });
                            },
                            child: Text(
                              'مسح الكل',
                              style: GoogleFonts.inter(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Row(
                            children: [
                              _buildFilterChip(
                                (widget.params?.selectedStudyLevel == null)
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
                                (widget.params?.selectedDivision == null)
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
                                (widget.params?.selectedPaymentType == null)
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
                                (widget.params?.selectedStudentStates == null)
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
                    ],
                  )
                : SizedBox(),
            const SizedBox(height: 24),

            // List==================================
            StudentsGrid(
              isLoading: isFilterLoading,
              filterDataList: filterDataList,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStudentScreen()),
            );
          },
          backgroundColor: AppTheme.primary,
          child: const Icon(Icons.person_add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }

  Widget _buildFilterChip(String label, Color bgColor, Color textColor) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                StudentFilterScreen(initialParams: widget.params),
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: AppColors.surfaceContainerHigh,
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
      onTap: () => FocusScope.of(context).unfocus(),
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
