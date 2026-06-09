import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../generated/l10n.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, this.buttonText, this.callBack});
  final String? buttonText;
  final Function? callBack;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("assets/error_img.jpg", width: 400.w),
            ),
            SizedBox(height: 40),
            Text(
              S.of(context).error,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                S.of(context).tryAgainLater,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            buttonText != null ? SizedBox(height: 30) : SizedBox(),
            buttonText != null
                ? SizedBox(
                    child: RectangleTextButton(
                      callback: () async {
                        if (callBack != null) {
                          await callBack!();
                        }
                      },
                      color: AppTheme.onPrimary,
                      backgroundColor: AppTheme.primary,
                      text: buttonText!,
                    ),
                  )
                : SizedBox(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class RectangleTextButton extends StatefulWidget {
  const RectangleTextButton({
    required this.text,
    this.color,
    this.fontSize = 14,
    this.enable = true,
    this.expanded = true,
    this.icon,
    this.verticalPadding = 9.0,
    this.horizontalPadding = 15.0,
    required this.backgroundColor,
    required this.callback,
    super.key,
  });
  final String text;
  final Color? color;
  final bool expanded;
  final bool enable;
  final Widget? icon;
  final double? verticalPadding;
  final double horizontalPadding;
  final double? fontSize;
  final Color backgroundColor;
  final Function callback;

  @override
  State<RectangleTextButton> createState() => _RectangleTextButtonState();
}

class _RectangleTextButtonState extends State<RectangleTextButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color? color = widget.enable
        ? widget.color
        : widget.color?.withOpacity(0.7);
    Color backgroundColor = widget.enable
        ? widget.backgroundColor
        : widget.backgroundColor.withOpacity(0.7);
    return SizedBox(
      width: widget.expanded ? screenWidth : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: widget.horizontalPadding,
            vertical: widget.verticalPadding!,
          ),
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: backgroundColor,
          overlayColor: AppTheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: isLoading ? 0.0 : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize?.sp,
                    ),
                  ),
                  SizedBox(width: 8),
                  widget.icon ?? SizedBox(),
                ],
              ),
            ),
            Opacity(
              opacity: !isLoading ? 0.0 : 1.0,
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: AppTheme.onPrimary,
                  strokeWidth: 3.sp,
                ),
              ),
            ),
          ],
        ),
        onPressed: () async {
          if (widget.enable) {
            if (!isLoading) {
              setState(() {
                isLoading = true;
              });
              await widget.callback();
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            }
          }
        },
      ),
    );
  }
}
