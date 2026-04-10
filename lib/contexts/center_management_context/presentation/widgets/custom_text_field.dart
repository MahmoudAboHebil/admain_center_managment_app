import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';

class CustomTextFiled extends StatefulWidget {
  final Function(String)? onChange;
  final Function(String?)? validator;
  final String? hint;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final String? initialValue;
  final int maxLines;
  final Color fillColor;

  const CustomTextFiled({
    super.key,
    this.onChange,
    this.validator,
    this.hint,
    this.keyboardType,
    this.prefixIcon,
    this.initialValue,
    this.fillColor = AppTheme.surfaceContainerLowest,
    this.maxLines = 1,
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      validator: (value) {
        return widget.validator != null ? widget.validator!(value) : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        hintText: widget.hint,
        // Because of RTL, setting prefixIcon might be on the right.
        // We put the icon where we want based on design.
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: AppTheme.outlineVariant,
                size: 24.sp,
              )
            : null,
        filled: true,
        fillColor: widget.fillColor,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.primary, width: 2),
        ),
      ),
      style: GoogleFonts.inter(color: AppTheme.onSurface),
    );
  }
}
