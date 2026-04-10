import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/helper/helper.dart';

class TextPhoneWidget extends StatefulWidget {
  const TextPhoneWidget({
    super.key,
    required this.initialValue,
    required this.title,
    this.hint,
    this.keyboardType,
    this.prefixIcon,
    required this.onChange,
  });

  final String? initialValue;
  final String title;
  final String? hint;
  final Function(ParsedPhone?) onChange;

  final TextInputType? keyboardType;
  final IconData? prefixIcon;

  @override
  State<TextPhoneWidget> createState() => _TextPhoneWidgetState();
}

class _TextPhoneWidgetState extends State<TextPhoneWidget> {
  final int maxLines = 1;
  final Color fillColor = AppTheme.surfaceContainerLowest;
  late TextEditingController phoneController;
  late String countryCode;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      final parsed = Helper.parsePhone(widget.initialValue!);
      phoneController = TextEditingController(text: parsed.phone);
      countryCode = parsed.countryCode;
    } else {
      countryCode = "+20";
      phoneController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountryCodePicker(
          initialSelection: countryCode,
          onChanged: (code) async {
            setState(() {
              countryCode = code.dialCode ?? "+20";
            });
            await widget.onChange(
              ParsedPhone(
                countryCode: countryCode,
                phone: phoneController.text,
              ),
            );
          },
        ),
        Expanded(
          child: TextField(
            onChanged: (val) async {
              await widget.onChange(
                ParsedPhone(countryCode: countryCode, phone: val),
              );
            },
            keyboardType: widget.keyboardType,
            maxLines: maxLines,
            controller: phoneController,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: fillColor,
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
          ),
        ),
      ],
    );
  }
}
