import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class StudentSearchTextField extends StatefulWidget {
  const StudentSearchTextField({
    required this.controller,
    required this.focusNode,
    super.key,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  @override
  State<StudentSearchTextField> createState() => _StudentSearchTextFieldState();
}

class _StudentSearchTextFieldState extends State<StudentSearchTextField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'البحث بالاسم...',
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: AppColors.onSurfaceVariant,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
          fillColor: widget.focusNode.hasFocus
              ? Colors.white
              : AppColors.surfaceContainerHigh,
          filled: true,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
