import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class FilterCartButton extends StatelessWidget {
  const FilterCartButton({super.key, required this.onChange});
  final VoidCallback onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: onChange,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tune, color: AppColors.primary, size: 28),
              SizedBox(height: 8),
              Text(
                'تصفية متقدمة',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
