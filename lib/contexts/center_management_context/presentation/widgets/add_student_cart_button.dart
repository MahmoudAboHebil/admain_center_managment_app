import 'package:admain_center_managment_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/route/route_name.dart';
import '../../../../config/theme/app_theme.dart';

class AddStudentCartButton extends StatelessWidget {
  const AddStudentCartButton({super.key, required this.isDesktop});
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteName.addStudent);
      },
      child: Container(
        height: 100,

        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLow.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.outlineVariant.withOpacity(0.3),
            style: BorderStyle.solid,
          ), // In Flutter dashed border requires custom paint, using solid for now.
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Icon(
                Icons.add,
                color: AppTheme.onSurfaceVariant,
                size: 24.sp,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              S.of(context).addNewStudent,
              style: TextStyle(
                color: AppTheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
