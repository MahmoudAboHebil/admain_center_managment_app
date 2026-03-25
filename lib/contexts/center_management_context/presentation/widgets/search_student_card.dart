import 'package:admain_center_managment_app/config/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchStudentCard extends StatelessWidget {
  final String name;
  final String level;
  final String id;

  const SearchStudentCard({
    super.key,
    required this.name,
    required this.level,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(name[0], style: TextStyle(color: AppColors.primary)),
            ),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F323A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  level,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF495F8B), // primary
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
