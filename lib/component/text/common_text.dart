import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';


class CommonText extends StatelessWidget {
  const CommonText(
      {super.key,
      this.maxLines = 1,
      this.textAlign = TextAlign.center,
      this.left = 0,
      this.right = 0,
      this.top = 0,
      this.bottom = 0,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w500,
      this.color = AppColors.black,
      required this.text,
      this.style,
      this.overflow = TextOverflow.ellipsis,
      this.underline = false});

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow overflow;
  final TextStyle? style;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ??
        GoogleFonts.poppins(
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
        );

    final effectiveStyle = baseStyle.copyWith(
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: color,
    );

    return Padding(
      padding: EdgeInsets.only(
          left: left.w, right: right.w, top: top.h, bottom: bottom.h),
      child: Text(
        textAlign: textAlign,
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: effectiveStyle,
      ),
    );
  }
}
