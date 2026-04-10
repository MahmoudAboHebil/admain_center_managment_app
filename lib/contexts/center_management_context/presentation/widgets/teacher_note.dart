import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../generated/l10n.dart';

class TeacherNote extends StatefulWidget {
  final String? initialValue;
  const TeacherNote({super.key, this.initialValue});

  @override
  State<TeacherNote> createState() => _TeacherNoteState();
}

class _TeacherNoteState extends State<TeacherNote> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          right: BorderSide(color: AppTheme.primary, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scrollPhysics: NeverScrollableScrollPhysics(),
              decoration: InputDecoration(
                enabled: false,
                hintText: S.of(context).addNewStudent,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: AppTheme.onSurfaceVariant,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
                fillColor: Colors.transparent,
              ),
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
