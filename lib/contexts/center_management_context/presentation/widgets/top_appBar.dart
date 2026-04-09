import 'package:admain_center_managment_app/core/enums/languages.dart';
import 'package:admain_center_managment_app/core/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/colors.dart';

class TopAppBar extends ConsumerWidget {
  const TopAppBar({
    super.key,
    required this.isDesktop,
    required this.label,
    this.searchWidget,
  });
  final bool isDesktop;
  final String label;
  final Widget? searchWidget;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.9),
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant.withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surfaceContainerLow,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.onSurfaceVariant,
                    size: 24.sp,
                  ),
                  onPressed: () async {
                    final languageProv = ref.read(languageProvider.notifier);
                    final language = ref.read(languageProvider).value;
                    final newValue = (language == Language.ar)
                        ? Language.en
                        : Language.ar;
                    await languageProv.toggleLanguage(newValue);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
