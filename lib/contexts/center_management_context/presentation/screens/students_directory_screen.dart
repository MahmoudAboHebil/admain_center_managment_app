import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/student_repository.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/filter_panel.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../config/theme/typography.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/enums/division_enum.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/study_level_entity.dart';
import '../widgets/add_student_button.dart';
import '../widgets/filter_cart_button.dart';
import '../widgets/search_student_card.dart';
import '../widgets/side_menu.dart';
import '../widgets/state_cart.dart';
import '../widgets/students_grid.dart';
import '../widgets/top_appBar.dart';

class StudentsDirectoryScreen extends StatefulWidget {
  const StudentsDirectoryScreen({super.key});

  @override
  State<StudentsDirectoryScreen> createState() =>
      _StudentsDirectoryScreenState();
}

class _StudentsDirectoryScreenState extends State<StudentsDirectoryScreen> {
  bool isFilter = false;
  List<StudentEntity> filterDataList = [];
  bool isGettingFilterData = false;
  bool isPressingFilter = false;
  Future<void> getFilterData(FilterParams filterKeys) async {
    if (isGettingFilterData) return;

    setState(() {
      isGettingFilterData = true;
      filterDataList = [];
    });

    try {
      final dataResponse = await sl<StudentRepository>()
          .getAllItemsNotArchived();

      if (!mounted) return;

      dataResponse.fold(
        ifLeft: (failure) {
          ///todo: handle error
        },
        ifRight: (data) {
          if (data.isNotEmpty) {
            StudyLevelEntity? study =
                filterKeys.selectedStudyLevel.arabicName ==
                    studyLevelsWithAll.first.arabicName
                ? null
                : filterKeys.selectedStudyLevel;

            DivisionEnum? division =
                filterKeys.selectedDivision == DivisionEnum.all
                ? null
                : filterKeys.selectedDivision;

            final newData = data.where((e) {
              bool studyCon = study == null
                  ? true
                  : e.studyLevelId == study.entityId;
              bool divisionCon;
              if (division == null || e.divisionEnum == null) {
                divisionCon = true;
              } else {
                divisionCon = e.divisionEnum == division;
              }
              bool statesCon = filterKeys.selectedStudentStates == null
                  ? true
                  : e.studentStatus == filterKeys.selectedStudentStates;
              bool paymentCon;

              if (filterKeys.selectedPaymentType == null ||
                  e.paymentTypeEnum == null) {
                paymentCon = true;
              } else {
                paymentCon =
                    e.paymentTypeEnum == filterKeys.selectedPaymentType;
              }
              return studyCon && divisionCon && statesCon && paymentCon;
            }).toList();
            setState(() {
              filterDataList = newData;
            });
          }
        },
      );
      await Future.delayed(Duration(milliseconds: 400));
    } finally {
      if (mounted) {
        setState(() => isGettingFilterData = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDesktop = width > 900;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop) const SideMenu(selectedIndex: 1),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 65),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PageHeader==================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'دليل الطلاب',
                                  style: AppTypography.textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'إدارة التسجيل',
                                  style: AppTypography.textTheme.headlineLarge,
                                ),
                              ],
                            ),
                            const AddStudentButton(),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // StatsRow==================================
                        Row(
                          children: [
                            Expanded(
                              child: StreamBuilder<int>(
                                stream: sl<StudentRepository>()
                                    .watchStudentsCount()
                                    .getOrElse(() => const Stream.empty()),
                                builder: (context, snapshot) {
                                  final isLoading =
                                      snapshot.connectionState ==
                                      ConnectionState.waiting;

                                  final count = snapshot.data ?? 0;

                                  return StatCard(
                                    label: 'إجمالي الطلاب',
                                    value: isLoading ? '...' : '$count',
                                    valueColor: AppColors.tertiary,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: const StatCard(
                                label: 'الفصول النشطة',
                                value: 'XXXX',
                                valueColor: AppColors.tertiary,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: const StatCard(
                                label: 'متوسط الحضور',
                                value: 'XXXX%',
                                valueColor: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: FilterCartButton(
                                onChange: () {
                                  setState(() {
                                    isFilter = !isFilter;
                                    isPressingFilter = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        // FilterPanel==================================
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSlide(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              offset: isFilter ? Offset(0, 0) : Offset(1, 0),
                              child: isFilter
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 40),
                                        FilterPanel(
                                          onChange: (p0) async {
                                            isPressingFilter = true;
                                            await getFilterData(p0);
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // count filter data==================================
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
                            !isPressingFilter
                                ? StreamBuilder<int>(
                                    stream: sl<StudentRepository>()
                                        .watchStudentsCount()
                                        .getOrElse(() => const Stream.empty()),
                                    builder: (context, snapshot) {
                                      final isLoading =
                                          snapshot.connectionState ==
                                          ConnectionState.waiting;

                                      final count = snapshot.data ?? 0;
                                      return Text(
                                        "${isLoading ? '?' : count} ",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  )
                                : Text(
                                    " ${filterDataList.length} ",
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
                        const SizedBox(height: 20),

                        // StudentsGrid==================================
                        StudentsGrid(
                          isLoading: isGettingFilterData,
                          filterDataList: (isFilter && isPressingFilter)
                              ? filterDataList
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                StudentsScreenAppBar(isDesktop: isDesktop),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}

class StudentsScreenAppBar extends StatefulWidget {
  final bool isDesktop;
  const StudentsScreenAppBar({required this.isDesktop, super.key});

  @override
  State<StudentsScreenAppBar> createState() => _StudentsScreenAppBarState();
}

class _StudentsScreenAppBarState extends State<StudentsScreenAppBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  List<StudentEntity> filterDataList = [];
  final layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // animation states
  double _dropdownHeight = 0;
  double _dropdownOpacity = 0;

  @override
  void initState() {
    super.initState();

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _dropdownHeight = 0;
    _dropdownOpacity = 0;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 250,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 55),
          child: Material(
            color: Colors.transparent,
            elevation: 0,
            borderRadius: BorderRadius.circular(8),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: _dropdownOpacity,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: SizedBox(
                  height: _dropdownHeight,
                  child: _buildSearchDropdown(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
    // start animation
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _dropdownHeight = 250; // final height
        _dropdownOpacity = 1;
        _overlayEntry?.markNeedsBuild();
      });
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _hideOverlay() {
    setState(() {
      filterDataList = [];
      _dropdownHeight = 0;
      _dropdownOpacity = 0;
      _overlayEntry?.markNeedsBuild();
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      _removeOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          TopAppBar(
            isDesktop: widget.isDesktop,
            label: 'الطلاب',
            searchWidget: CompositedTransformTarget(
              link: layerLink,
              child: SizedBox(
                width: 250,
                child: TextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  onChanged: (text) async {
                    setState(() {
                      filterDataList = [];
                    });
                    if (text.isNotEmpty) {
                      print(text);
                      final result = await sl<StudentRepository>()
                          .getEntitiesNameStartWith(text);
                      result.fold(
                        ifLeft: (_) {},
                        ifRight: (data) {
                          setState(() {
                            filterDataList = data;
                            // refresh overlay height
                            _overlayEntry?.markNeedsBuild();
                          });
                        },
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'البحث بالاسم...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    fillColor: searchFocusNode.hasFocus
                        ? Colors.white
                        : AppColors.surfaceContainerHigh,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.surfaceContainer,
              ),
              width: 250,
              padding: EdgeInsets.only(bottom: 12),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                          top: 12,
                          left: 12,
                        ),
                        child: Text(
                          "نتائج البحث",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      ...(filterDataList.length >= 4
                              ? filterDataList.getRange(0, 4)
                              : filterDataList)
                          .map((item) {
                            StudyLevelEntity? level;
                            for (var l in studyLevels) {
                              if (l.entityId == item.studyLevelId) level = l;
                            }
                            final division = item.divisionEnum;
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                right: 12,
                                left: 12,
                              ),
                              child: SearchStudentCard(
                                name: item.name,
                                level: division == null
                                    ? level?.arabicName ?? ''
                                    : '${level?.arabicName ?? ''} • ${division.description}',
                                id: item.studentCode,
                              ),
                            );
                          })
                          .toList(),
                    ],
                  ),
                  filterDataList.length >= 4
                      ? TextButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                            ),
                          ),
                          clipBehavior: Clip.none,
                          onPressed: () {},
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                              color: AppColors.primary,
                            ),
                            child: Text(
                              'عرض جميع النتائج',
                              style: TextStyle(
                                color: AppColors.onPrimary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
                                  final students = [
                                    StudentModel(
                                      entityId: '1',
                                      centerId: 'center_1',
                                      byUser: 'admin',
                                      byDevice: 'device_1',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Ahmed Mohamed',
                                      studyLevelId:
                                          'dc4c08a7-d32a-4e9e-9c3a-2d02f6abda61',
                                      gender: Gender.male,
                                      studentCode: 'STD001',
                                      phone: '01000000001',
                                      parentPhone: '01100000001',
                                      paymentTypeEnum: PaymentTypeEnum.byMonth,
                                      divisionEnum: DivisionEnum
                                          .scientificMathematicsSection,
                                      studentStatus: StudentStatus.active,
                                    ),

                                    StudentModel(
                                      entityId: '2',
                                      centerId: 'center_1',
                                      byUser: 'admin',
                                      byDevice: 'device_1',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Sara Ali',
                                      studyLevelId:
                                          '4b05e1ba-1063-465a-8f5e-6dd46ab562fa',
                                      gender: Gender.female,
                                      studentCode: 'STD002',
                                      phone: '01000000002',
                                      parentPhone: '01100000002',
                                      paymentTypeEnum: PaymentTypeEnum.byClass,
                                      divisionEnum:
                                          DivisionEnum.literarySection,
                                      studentStatus: StudentStatus.latePayment,
                                    ),

                                    StudentModel(
                                      entityId: '3',
                                      centerId: 'center_1',
                                      byUser: 'admin',
                                      byDevice: 'device_2',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Omar Hassan',
                                      studyLevelId:
                                          '8fcdb091-afad-4be0-a516-d35365286e20',
                                      gender: Gender.male,
                                      studentCode: 'STD003',
                                      paymentTypeEnum: PaymentTypeEnum.byMonth,
                                      divisionEnum:
                                          DivisionEnum.scientificSection,
                                      studentStatus: StudentStatus.active,
                                    ),

                                    StudentModel(
                                      entityId: '4',
                                      centerId: 'center_1',
                                      byUser: 'user_2',
                                      byDevice: 'device_2',
                                      isDeleted: false,
                                      version: 2,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Mona Samy',
                                      studyLevelId:
                                          '3a1a3053-8508-4374-8409-f43abc1f2df0',
                                      gender: Gender.female,
                                      studentCode: 'STD004',
                                      phone: '01000000004',
                                      paymentTypeEnum: PaymentTypeEnum.byClass,
                                      divisionEnum: DivisionEnum.all,
                                      studentStatus: StudentStatus.inactive,
                                    ),

                                    StudentModel(
                                      entityId: '5',
                                      centerId: 'center_2',
                                      byUser: 'admin',
                                      byDevice: 'device_3',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Youssef Khaled',
                                      studyLevelId:
                                          'b756566b-fd68-46ad-9a83-1abc0f397b83',
                                      gender: Gender.male,
                                      studentCode: 'STD005',
                                      parentPhone: '01100000005',
                                      paymentTypeEnum: PaymentTypeEnum.byMonth,
                                      divisionEnum:
                                          DivisionEnum.scientificBiologySection,
                                      studentStatus: StudentStatus.active,
                                    ),

                                    StudentModel(
                                      entityId: '6',
                                      centerId: 'center_2',
                                      byUser: 'user_3',
                                      byDevice: 'device_3',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Nour Tarek',
                                      studyLevelId:
                                          '472222ab-14bb-4693-9695-97c371ec081e',
                                      gender: Gender.female,
                                      studentCode: 'STD006',
                                      paymentTypeEnum: PaymentTypeEnum.byClass,
                                      divisionEnum:
                                          DivisionEnum.literarySection,
                                      studentStatus: StudentStatus.latePayment,
                                    ),

                                    StudentModel(
                                      entityId: '7',
                                      centerId: 'center_1',
                                      byUser: 'admin',
                                      byDevice: 'device_1',
                                      isDeleted: false,
                                      version: 3,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Karim Adel',
                                      studyLevelId:
                                          '3a1a3053-8508-4374-8409-f43abc1f2df0',
                                      gender: Gender.male,
                                      studentCode: 'STD007',
                                      paymentTypeEnum: PaymentTypeEnum.byMonth,
                                      divisionEnum: DivisionEnum.all,
                                      studentStatus: StudentStatus.active,
                                    ),

                                    StudentModel(
                                      entityId: '8',
                                      centerId: 'center_3',
                                      byUser: 'user_1',
                                      byDevice: 'device_4',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Hana Magdy',
                                      studyLevelId:
                                          '472222ab-14bb-4693-9695-97c371ec081e',
                                      gender: Gender.female,
                                      studentCode: 'STD008',
                                      phone: '01000000008',
                                      paymentTypeEnum: PaymentTypeEnum.byClass,
                                      divisionEnum: DivisionEnum.alAzharSection,
                                      studentStatus: StudentStatus.inactive,
                                    ),

                                    StudentModel(
                                      entityId: '9',
                                      centerId: 'center_3',
                                      byUser: 'admin',
                                      byDevice: 'device_4',
                                      isDeleted: false,
                                      version: 2,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Mostafa Ibrahim',
                                      studyLevelId:
                                          'b756566b-fd68-46ad-9a83-1abc0f397b83',
                                      gender: Gender.male,
                                      studentCode: 'STD009',
                                      parentPhone: '01100000009',
                                      paymentTypeEnum: PaymentTypeEnum.byMonth,
                                      divisionEnum: DivisionEnum
                                          .scientificMathematicsSection,
                                      studentStatus: StudentStatus.latePayment,
                                    ),

                                    StudentModel(
                                      entityId: '10',
                                      centerId: 'center_2',
                                      byUser: 'user_2',
                                      byDevice: 'device_5',
                                      isDeleted: false,
                                      version: 1,
                                      createdAt: DateTime.now(),
                                      updatedAt: DateTime.now(),
                                      name: 'Salma Ahmed',
                                      studyLevelId:
                                          '3a1a3053-8508-4374-8409-f43abc1f2df0',
                                      gender: Gender.female,
                                      studentCode: 'STD010',
                                      paymentTypeEnum: PaymentTypeEnum.byMonth,
                                      divisionEnum:
                                          DivisionEnum.scientificBiologySection,
                                      studentStatus: StudentStatus.active,
                                    ),
                                  ];

                                  for (var item in students) {
                                    final useCase = sl<AddEntityLocalUseCase>();
                                    useCase.call(
                                      AddEntityLocalUseCaseParams(
                                        table: DBTable.students,
                                        jsonEntity: null,
                                        entity: item.toEntity(),
                                      ),
                                    );
                                  }

                                   */
