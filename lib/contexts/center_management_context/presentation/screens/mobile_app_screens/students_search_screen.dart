import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../config/theme/colors.dart';
import '../../../../../config/theme/typography.dart';
import '../../../../../injection_container.dart';
import '../../../../../sync_engine/domain/entities/student_entity.dart';
import '../../../domain/repository/student_repository.dart';
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
                            await Future.delayed(Duration(milliseconds: 250));
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
            StudentsGrid(isLoading: isGettingData, filterDataList: searchData),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_edit');
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
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.9),
          border: Border(
            bottom: BorderSide(
              color: AppColors.outlineVariant.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'بحث الطلاب',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_forward_outlined,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
