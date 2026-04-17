import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_theme.dart';
import '../bloc/selection_cubit/selection_cubit.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String label;
  final Widget? leadingWidget;
  const CustomAppBar({super.key, required this.label, this.leadingWidget});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface.withOpacity(0.9),
          border: Border(
            bottom: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                if (widget.leadingWidget != null) widget.leadingWidget!,

                SizedBox(width: 12),

                IconButton(
                  onPressed: () {
                    context.read<SelectionCubit>().clearSelection();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_forward_outlined,
                    color: AppTheme.primary,
                    size: 26.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
