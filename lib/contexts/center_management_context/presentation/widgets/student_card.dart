import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String level;
  final String id;
  final String status;
  final String subStatus;
  final bool isStatusGreen;
  final bool isStatusRed;

  const StudentCard({
    Key? key,
    required this.name,
    required this.level,
    required this.id,
    required this.status,
    required this.subStatus,
    this.isStatusGreen = false,
    this.isStatusRed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusBgColor = const Color(0xFFF3F3FA);
    Color statusTextColor = const Color(0xFF5C5F68);

    if (isStatusGreen) {
      statusBgColor = Colors.green.shade200;
      statusTextColor = Colors.green.shade900;
    } else if (isStatusRed) {
      statusBgColor = Colors.red.shade100;
      statusTextColor = Colors.red.shade800;
    }

    return Container(
      padding: const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFAFB1BC).withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F323A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      level,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF495F8B), // primary
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      id,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF5C5F68),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF5C5F68),
                  size: 20,
                ),
                onPressed: () {},
                splashRadius: 20,
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFAFB1BC).withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFE7E8F1,
                        ), // surface-container-high
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        subStatus,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5C5F68),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF495F8B),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: const Color(0xFF495F8B).withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: const Text(
                    'تعديل',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
