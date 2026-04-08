import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/students_search_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/search_student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../../../sync_engine/domain/entities/student_entity.dart';
import '../../domain/entities/study_level_entity.dart';
import '../../domain/repository/student_repository.dart';
import '../bloc/selection_cubit/selection_cubit.dart';

class StudentSearchTextField extends StatefulWidget {
  final double width;
  final FocusNode searchFocusNode;

  const StudentSearchTextField({
    super.key,
    required this.width,
    required this.searchFocusNode,
  });

  @override
  State<StudentSearchTextField> createState() => _StudentSearchTextFieldState();
}

class _StudentSearchTextFieldState extends State<StudentSearchTextField>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late final FocusNode searchFocusNode;
  List<StudentEntity> filterDataList = [];
  final layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // animation states
  double _dropdownHeight = 0;
  double _dropdownOpacity = 0;

  @override
  void initState() {
    print('ddddddddddddddaaaaaaaaaaa');
    super.initState();
    searchFocusNode = widget.searchFocusNode;
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        _showOverlay();
      } else {
        searchController = TextEditingController();
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
        width: widget.width,
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
    _overlayEntry?.markNeedsBuild();

    setState(() {
      // filterDataList = [];
      _dropdownHeight = 0;
      _dropdownOpacity = 0;
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      _removeOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: SizedBox(
        width: widget.width,
        child: TextField(
          controller: searchController,
          focusNode: searchFocusNode,
          autofocus: false,
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
                    // filterDataList = [...data, ...data, ...data, ...data];

                    filterDataList = data;
                    // refresh overlay height
                  });
                  _overlayEntry?.markNeedsBuild();
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
                : AppColors.surfaceContainerHigh.withOpacity(0.3),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
          ),
        ),
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
        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.surfaceContainer,
              ),
              width: widget.width,
              padding: EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: (filterDataList.length >= 4) ? 33 : 0,
                    ),
                    child: Column(
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
                                  studentEntity: item,
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
                  ),
                ],
              ),
            ),
            Visibility(
              visible: (filterDataList.length >= 4),
              child: MaterialButton(
                elevation: 0,
                focusElevation: 0,
                highlightElevation: 0,
                disabledElevation: 0,
                hoverElevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                clipBehavior: Clip.none,
                onPressed: () {
                  if ((filterDataList.length >= 4)) {
                    context.read<SelectionCubit>().clearSelection();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 300),
                        reverseTransitionDuration: Duration(milliseconds: 300),

                        pageBuilder: (context, animation, secondaryAnimation) {
                          return StudentsSearchScreen(
                            query: searchController.text,
                            initialData: filterDataList,
                          );
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
                                child: SlideTransition(
                                  position: slide,
                                  child: child,
                                ),
                              );
                            },
                      ),
                    );
                  }
                },
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
                    style: TextStyle(color: AppColors.onPrimary, fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
