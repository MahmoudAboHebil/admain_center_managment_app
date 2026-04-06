import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/theme/app_theme.dart';

class CodeBadge {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  CodeBadge(this.text, this.backgroundColor, this.textColor);
}

class Student {
  final String id;
  final String name;
  final String displayId;
  final String grade;
  final String branch;
  final bool isActive;
  final String paymentType;
  final Color leftBorderColor;

  Student({
    required this.id,
    required this.name,
    required this.displayId,
    required this.grade,
    required this.branch,
    required this.isActive,
    required this.paymentType,
    required this.leftBorderColor,
  });
}

class SelectStudentScreen extends StatefulWidget {
  const SelectStudentScreen({super.key});

  @override
  State<SelectStudentScreen> createState() => _SelectStudentScreenState();
}

class _SelectStudentScreenState extends State<SelectStudentScreen> {
  final Set<String> _selectedIds = {};

  final List<Student> _students = [
    Student(
      id: '1',
      name: 'أحمد محمد علي',
      displayId: 'STU-2024-001',
      grade: 'الصف الثالث الثانوي',
      branch: 'علمي علوم',
      isActive: true,
      paymentType: 'مدفوع',
      leftBorderColor: AppTheme.primary,
    ),
    Student(
      id: '2',
      name: 'سارة إبراهيم حسن',
      displayId: 'STU-2024-042',
      grade: 'الصف الثالث الثانوي',
      branch: 'علمي رياضة',
      isActive: true,
      paymentType: 'مدفوع',
      leftBorderColor: Colors.blueGrey, // Secondary
    ),
    Student(
      id: '3',
      name: 'محمود خالد عمر',
      displayId: 'STU-2024-105',
      grade: 'الصف الثاني الثانوي',
      branch: 'أدبي',
      isActive: false,
      paymentType: 'متأخر',
      leftBorderColor: AppTheme.primary,
    ),
    Student(
      id: '4',
      name: 'فاطمة الزهراء علي',
      displayId: 'STU-2024-312',
      grade: 'الصف الأول الثانوي',
      branch: 'عام',
      isActive: true,
      paymentType: 'مدفوع',
      leftBorderColor: Colors.blueGrey,
    ),
    Student(
      id: '5',
      name: 'ياسين عبدالله رامي',
      displayId: 'STU-2024-009',
      grade: 'الصف الثالث الثانوي',
      branch: 'علمي علوم',
      isActive: true,
      paymentType: 'مدفوع',
      leftBorderColor: AppTheme.primary,
    ),
  ];

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedIds.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Main Body Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: 120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearchSection(),
                  const SizedBox(height: 24),
                  _buildSummaryStats(),
                  const SizedBox(height: 24),
                  _buildFilterSection(),
                  const SizedBox(height: 24),
                  _buildStudentListHeader(),
                  const SizedBox(height: 12),
                  ..._students
                      .map((student) => _buildStudentCard(student))
                      .toList(),
                ],
              ),
            ),
          ),

          // Animated Selection Action Bar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            bottom: _selectedIds.isNotEmpty ? 16 : -100,
            left: 20,
            right: 20,
            child: _buildSelectionActionBar(),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add_edit');
          },
          backgroundColor: AppTheme.primary,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.person_add, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .startFloat, // Matches RTL left positioning
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.surface.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        'Scholar Pro',
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppTheme.primary,
          letterSpacing: -0.5,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppTheme.primary),
          onPressed: () {},
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryContainer.withOpacity(0.5),
            border: Border.all(
              color: AppTheme.surfaceContainerLowest,
              width: 2,
            ),
            image: const DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBVc_1N_CxgUlEGdXXEfclWLwPhl6snly0i8hAfb58K7rJ1sItXaFJOSYaWX_9qS3ad6hGqE3sLg-IYyHGTtKcbvnUKGSoPOM3PvB3jZHFNyq3GKWRHVXzdV8K3A_7cDnJuowIDt5GJefmKA3NthnB88Fbvf_RlFpWBrXV2B3z9CQK3Ejd7cfUj7vxZs77ES7c5J5is6lXUmHbhfyKZXtpeMvKEIOcVs0NEePMMFwJP2ooNbAe0eShvHX3PY_IPn2rDxf2XQ14Y_5_8',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'البحث عن طالب...',
          hintStyle: GoogleFonts.inter(
            color: AppTheme.onSurfaceVariant,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primary, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent, // Because container handles it
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryStats() {
    return Row(
      children: [
        _buildBentoCard('إجمالي الطلاب', '1,284', AppTheme.primary),
        const SizedBox(width: 12),
        _buildBentoCard('الفصول النشطة', '42', AppTheme.tertiary),
        const SizedBox(width: 12),
        _buildBentoCard('نسبة الحضور', '94%', AppTheme.error),
      ],
    );
  }

  Widget _buildBentoCard(String title, String value, Color valueColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildFilterDropdown('الصف الدراسي', [
                'كل الصفوف',
                'الصف الأول الثانوي',
                'الصف الثاني الثانوي',
                'الصف الثالث الثانوي',
              ]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildFilterDropdown('الشعبة', [
                'كل الشعب',
                'علمي علوم',
                'علمي رياضة',
                'أدبي',
              ]),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildStatusChip('نشط', isSelected: true),
              const SizedBox(width: 8),
              _buildStatusChip('غائب'),
              const SizedBox(width: 8),
              _buildStatusChip('متأخر'),
              const SizedBox(width: 8),
              _buildStatusChip('مدفوع', isCustomColor: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0, bottom: 6.0),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: items.first,
              icon: const Icon(
                Icons.expand_more,
                color: AppTheme.onSurfaceVariant,
                size: 20,
              ),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.onSurface,
              ),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(
    String label, {
    bool isSelected = false,
    bool isCustomColor = false,
  }) {
    Color bgColor;
    Color textColor;

    if (isSelected) {
      bgColor = AppTheme.primary;
      textColor = AppTheme.onPrimary;
    } else if (isCustomColor) {
      bgColor = AppTheme.secondaryContainer;
      textColor = AppTheme.onSecondaryContainer;
    } else {
      bgColor = AppTheme.surfaceContainerHigh;
      textColor = AppTheme.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildStudentListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'قائمة الطلاب',
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        Text(
          'عرض 1-12 من 1,284',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentCard(Student student) {
    final bool isSelected = _selectedIds.contains(student.id);

    return GestureDetector(
      onTap: () => _toggleSelection(student.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.surfaceContainerLow
              : AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primary
                : AppTheme.outlineVariant.withOpacity(0.1),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left color indicator
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: student.leftBorderColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              // Checkbox Area
              InkWell(
                onTap: () => _toggleSelection(student.id),
                child: Container(
                  width: 56,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: AppTheme.outlineVariant.withOpacity(0.1),
                      ),
                    ),
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primary
                              : AppTheme.outlineVariant,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              // Content Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        student.name,
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _buildBadge(
                            student.grade,
                            AppTheme.primaryContainer.withOpacity(0.3),
                            const Color(0xFF324973),
                          ),
                          const SizedBox(width: 8),
                          _buildBadge(
                            student.branch,
                            student.branch == 'علمي علوم' ||
                                    student.branch == 'علمي رياضة'
                                ? AppTheme.tertiaryContainer
                                : AppTheme.surfaceContainerHigh,
                            student.branch == 'علمي علوم' ||
                                    student.branch == 'علمي رياضة'
                                ? const Color(0xFF54436B)
                                : AppTheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        student.displayId,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: AppTheme.onSurfaceVariant,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Options Menu
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: AppTheme.onSurfaceVariant,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSelectionActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, -5),
          ),
        ],
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  '${_selectedIds.length} محدد',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle deletion logic
                  _clearSelection();
                },
                icon: const Icon(Icons.delete, size: 16),
                label: const Text('حذف المحدد'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  minimumSize: const Size(0, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 1,
                  textStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: _clearSelection,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.onSurfaceVariant,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'إلغاء',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.onSurface.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.school, label: 'Classes', isActive: false),
          _buildNavItem(icon: Icons.group, label: 'Students', isActive: true),
          _buildNavItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.secondaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
