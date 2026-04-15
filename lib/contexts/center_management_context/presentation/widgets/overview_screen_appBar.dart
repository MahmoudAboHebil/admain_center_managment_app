import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/top_appBar.dart';
import 'package:flutter/material.dart';

class OverviewScreenAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const OverviewScreenAppBar({super.key, required this.label});
  final String label;

  @override
  State<OverviewScreenAppBar> createState() => _OverviewScreenAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _OverviewScreenAppBarState extends State<OverviewScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [TopAppBar(isDesktop: false, label: widget.label)],
      ),
    );
  }
}
