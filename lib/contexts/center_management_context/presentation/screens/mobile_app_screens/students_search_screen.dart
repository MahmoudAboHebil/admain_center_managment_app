import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/add_student_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
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
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(label: 'بحث الطلاب'),
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
                      SizedBox(
                        width: 300,
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
                            hintText: 'البحث بالاسم...',
                            prefixIcon: const Icon(Icons.search, size: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
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
                    ],
                  ),
                  const SizedBox(height: 16),
                  // StatsRow==================================
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
                        " ${searchData.length} ",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("طلاب", style: TextStyle(color: AppColors.outline)),
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
                                              contentType: ContentType.failure,
                                            ),
                                            backgroundColor: Colors.transparent,
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
                                                title: "تم بنجاح",
                                                message: "تم حذف الطالب",
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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                        style: TextStyle(color: Colors.white),
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
                                            title: "حدث خطأ",
                                            message:
                                                "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                  onTap: (index) {
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
    );
  }
}
