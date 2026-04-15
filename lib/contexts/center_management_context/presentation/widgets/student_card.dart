import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/providers/language_provider.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../domain/repository/student_repository.dart';
import '../bloc/selection_cubit/selection_cubit.dart';
import '../bloc/selection_cubit/selection_state.dart';
import '../screens/mobile_app_screens/student_screens/edit_student_screen.dart';
import '../screens/mobile_app_screens/student_screens/student_profile_screen.dart';

class StudentCard extends ConsumerStatefulWidget {
  final StudentEntity student;
  final String level;
  final Color sideColor;
  final String status;
  final String subStatus;
  final bool isStatusGreen;
  final bool isStatusRed;

  const StudentCard({
    super.key,
    required this.level,
    required this.status,
    required this.subStatus,
    this.isStatusGreen = false,
    this.isStatusRed = false,
    required this.sideColor,
    required this.student,
  });

  @override
  ConsumerState<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends ConsumerState<StudentCard> {
  bool isHover = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider).value;

    Color statusBgColor = const Color(0xFFF3F3FA);
    Color statusTextColor = const Color(0xFF5C5F68);

    if (widget.isStatusGreen) {
      statusBgColor = Colors.green.shade200;
      statusTextColor = Colors.green.shade900;
    } else if (widget.isStatusRed) {
      statusBgColor = Colors.red.shade100;
      statusTextColor = Colors.red.shade800;
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() => isHover = true);
      },
      onExit: (_) {
        setState(() => isHover = false);
      },
      child: PressableButton(
        onTap: () {
          final isSelectedMode = context
              .read<SelectionCubit>()
              .state
              .isSelectionMode;
          if (!isSelectedMode) {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 300),
                reverseTransitionDuration: Duration(milliseconds: 300),

                pageBuilder: (context, animation, secondaryAnimation) {
                  return StudentProfileScreen(student: widget.student);
                },

                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      final slide = Tween<Offset>(
                        begin: Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation);

                      final fade = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: fade,
                        child: SlideTransition(position: slide, child: child),
                      );
                    },
              ),
            );
          } else {
            context.read<SelectionCubit>().toggleSelection(
              widget.student.entityId,
            );
          }
        },
        onLongPress: () {
          final cubit = context.read<SelectionCubit>().startSelection(
            widget.student.entityId,
          );
        },
        child: BlocBuilder<SelectionCubit, SelectionState>(
          builder: (context, state) {
            final cubit = context.read<SelectionCubit>();
            final isSelected = state.selectedIds.contains(
              widget.student.entityId,
            );
            final isSelectedMode = state.isSelectionMode;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: 20,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.transparent : widget.sideColor,
                    borderRadius: BorderRadius.circular(300),
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 5),
                  padding: EdgeInsetsDirectional.only(
                    top: 20,
                    start: state.isSelectionMode ? 0 : 20,
                    end: 20,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.05)
                        : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? BoxBorder.fromSTEB(
                            top: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                            end: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                            bottom: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                            start: BorderSide(
                              color: AppColors.primary,
                              width: 5,
                            ),
                          )
                        : Border.all(
                            width: isSelected ? 1.5 : 1,
                            color: isSelected
                                ? AppColors.primary
                                : (isHover
                                      ? AppColors.outlineVariant.withOpacity(
                                          0.3,
                                        )
                                      : const Color(
                                          0xFFAFB1BC,
                                        ).withOpacity(0.15)),
                          ),
                  ),
                  child: Row(
                    children: [
                      if (state.isSelectionMode)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Transform.scale(
                              scale: 1.1,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                value: isSelected,

                                onChanged: (_) {
                                  cubit.toggleSelection(
                                    widget.student.entityId,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.student.name,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2F323A),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        widget.level,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF495F8B), // primary
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.topLeft,
                                  child: CompositedTransformTarget(
                                    link: _layerLink,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Color(0xFF5C5F68),
                                        size: 20.sp,
                                      ),
                                      onPressed: !isSelectedMode
                                          ? () {
                                              _toggleMenu(language);
                                            }
                                          : null,

                                      splashRadius: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(top: 3),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: const Color(
                                      0xFFAFB1BC,
                                    ).withOpacity(0.1),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusBgColor,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          widget.status,
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: statusTextColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFE7E8F1,
                                          ), // surface-container-high
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          widget.subStatus,
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF5C5F68),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: !isSelectedMode
                                        ? () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration: Duration(
                                                  milliseconds: 300,
                                                ),
                                                reverseTransitionDuration:
                                                    Duration(milliseconds: 300),

                                                pageBuilder:
                                                    (
                                                      context,
                                                      animation,
                                                      secondaryAnimation,
                                                    ) {
                                                      return EditStudentScreen(
                                                        studentEntity:
                                                            widget.student,
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
                                                            begin: Offset(1, 0),
                                                            end: Offset.zero,
                                                          ).animate(animation);

                                                      final fade =
                                                          Tween<double>(
                                                            begin: 0.0,
                                                            end: 1.0,
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
                                          }
                                        : null,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      foregroundColor: const Color(0xFF495F8B),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color(
                                            0xFF495F8B,
                                          ).withOpacity(0.2),
                                        ),
                                      ),

                                      child: Text(
                                        S.of(context).edite,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _toggleMenu(Language? language) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay(language);
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlay(Language? lang) {
    final double xSpace = (lang == null || lang == Language.en) ? -110 : 0;
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          /// click outside to close
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
              child: Container(color: Colors.transparent),
            ),
          ),

          /// menu
          CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(xSpace, 30), // تحت الزرار
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 150.w,
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFAFB1BC).withOpacity(0.15),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10),
                        ),
                        minimumSize: WidgetStatePropertyAll(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300),
                            reverseTransitionDuration: Duration(
                              milliseconds: 300,
                            ),

                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                                  return StudentProfileScreen(
                                    student: widget.student,
                                  );
                                },

                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  final slide = Tween<Offset>(
                                    begin: Offset(1, 0),
                                    end: Offset.zero,
                                  ).animate(animation);

                                  final fade = Tween<double>(
                                    begin: 0.0,
                                    end: 1.0,
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

                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                size: 15.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              S.of(context).showPortfolio,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Edit

                    ///todo: you need implement this
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10),
                        ),
                        minimumSize: WidgetStatePropertyAll(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Icon(
                                Icons.av_timer,
                                size: 15.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              S.of(context).attendanceList,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: const Color(0xFFAFB1BC).withOpacity(0.1),
                    ),

                    TextButton(
                      style: ButtonStyle(
                        shadowColor: WidgetStatePropertyAll(AppColors.onError),
                        overlayColor: WidgetStatePropertyAll(AppColors.onError),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10),
                        ),
                        minimumSize: WidgetStatePropertyAll(Size.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final addResult = await sl<StudentRepository>()
                              .softDeleteStudent(widget.student);
                          addResult.fold(
                            ifLeft: (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AwesomeSnackbarContent(
                                    inMaterialBanner: true,
                                    title: S.of(context).wrongHappened,
                                    message: S.of(context).tryAgainLater,
                                    contentType: ContentType.failure,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );
                            },
                            ifRight: (response) {
                              if (response == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: AwesomeSnackbarContent(
                                      inMaterialBanner: true,
                                      title: S.of(context).success,
                                      message: S.of(context).studentDeleted,
                                      contentType: ContentType.success,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: AwesomeSnackbarContent(
                                      inMaterialBanner: true,
                                      title: S.of(context).wrongHappened,
                                      message: S.of(context).tryAgainLater,
                                      contentType: ContentType.failure,
                                    ),
                                    backgroundColor: Colors.transparent,
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
                                title: S.of(context).wrongHappened,
                                message: S.of(context).tryAgainLater,
                                contentType: ContentType.failure,
                              ),
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        } finally {
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        }
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                size: 15.sp,
                                color: AppColors.error,
                              ),
                            ),
                            Text(
                              S.of(context).deleteStudent,
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
