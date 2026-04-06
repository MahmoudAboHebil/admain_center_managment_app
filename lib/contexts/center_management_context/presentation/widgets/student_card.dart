import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/student_entity.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../injection_container.dart';
import '../../domain/repository/student_repository.dart';
import '../bloc/selection_cubit/selection_cubit.dart';
import '../bloc/selection_cubit/selection_state.dart';
import '../screens/mobile_app_screens/edit_student_screen.dart';
import '../screens/mobile_app_screens/student_profile_screen.dart';
import '../screens/mobile_app_screens/students_list_screen.dart';

class StudentCard extends StatefulWidget {
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
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool isHover = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
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
              MaterialPageRoute(
                builder: (context) =>
                    StudentProfileScreen(student: widget.student),
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
                Row(
                  children: [
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          right: state.isSelectionMode ? 0 : 20,
                          left: 20,
                          bottom: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.05)
                              : AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? BoxBorder.fromLTRB(
                                  top: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                  left: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                  bottom: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                  right: BorderSide(
                                    color: AppColors.primary,
                                    width: 5,
                                  ),
                                )
                              : Border.all(
                                  width: isSelected ? 1.5 : 1,
                                  color: isSelected
                                      ? AppColors.primary
                                      : (isHover
                                            ? AppColors.outlineVariant
                                                  .withOpacity(0.3)
                                            : const Color(
                                                0xFFAFB1BC,
                                              ).withOpacity(0.15)),
                                ),
                        ),
                        child: Row(
                          children: [
                            if (state.isSelectionMode)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.student.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF2F323A),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              widget.level,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(
                                                  0xFF495F8B,
                                                ), // primary
                                              ),
                                            ),
                                            // const SizedBox(height: 4),
                                            // Text(
                                            //   widget.id,
                                            //   style: const TextStyle(
                                            //     fontSize: 10,
                                            //     color: Color(0xFF5C5F68),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      CompositedTransformTarget(
                                        link: _layerLink,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Color(0xFF5C5F68),
                                            size: 20,
                                          ),
                                          onPressed: !isSelectedMode
                                              ? _toggleMenu
                                              : null,

                                          splashRadius: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.only(top: 12),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: statusBgColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                widget.status,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: statusTextColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFFE7E8F1,
                                                ), // surface-container-high
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                widget.subStatus,
                                                style: const TextStyle(
                                                  fontSize: 10,
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
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditStudentScreen(
                                                            studentEntity:
                                                                widget.student,
                                                          ),
                                                    ),
                                                  );
                                                }
                                              : null,
                                          style: TextButton.styleFrom(
                                            foregroundColor: const Color(
                                              0xFF495F8B,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: const Color(
                                                  0xFF495F8B,
                                                ).withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            'تعديل',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
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
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _toggleMenu() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlay() {
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
            offset: const Offset(0, 30), // تحت الزرار
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 150,
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
                  children: [
                    /// Edit
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentProfileScreen(student: widget.student),
                          ),
                        );
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                size: 15,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              "عرض الملف الشخصى",
                              style: TextStyle(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///todo: you need implement this
                    MaterialButton(
                      onPressed: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.av_timer,
                                size: 15,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              "سجل الحضور",
                              style: TextStyle(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      height: 1,
                      color: const Color(0xFFAFB1BC).withOpacity(0.1),
                    ),
                    SizedBox(height: 6),

                    MaterialButton(
                      hoverColor: AppColors.onError,
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StudentsListScreen(),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: AwesomeSnackbarContent(
                                      inMaterialBanner: true,
                                      title: "تم بنجاح",
                                      message: "تم حذف الطالب",
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
                                      title: "حدث خطأ",
                                      message:
                                          "تعذر إتمام العملية، يرجى المحاولة لاحقًا",
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
                          _overlayEntry?.remove();
                          _overlayEntry = null;
                        }
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                size: 15,
                                color: AppColors.error,
                              ),
                            ),
                            Text(
                              "حذف الطالب",
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 11,
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
