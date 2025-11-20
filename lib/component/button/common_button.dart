import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import '../loader/common_loader.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final bool isLoading;

  const CommonButton({
    this.onTap,
    required this.titleText,
    this.titleColor = AppColors.black500,
    this.buttonColor = AppColors.white,
    this.titleSize = 16,
    this.buttonRadius = 8,
    this.titleWeight = FontWeight.w500,
    this.buttonHeight = 60,
    this.borderWidth = 0,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor = AppColors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth.w,
      child: _buildGradientButton(),
    );
  }

  // Gradient CTA button with ripple
  Widget _buildGradientButton() {
    final disabled = onTap == null || isLoading;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(buttonRadius.r),
      child: Ink(
        decoration: BoxDecoration(
          // Figma: linear-gradient(180deg, #FCB0CD 0%, #F85494 0.01%, #F4005F 100%)
          gradient: AppColors.ctaLinearGradient,
          borderRadius: BorderRadius.circular(buttonRadius.r),
          border: Border.all(
            color: borderColor ?? AppColors.transparent,
            width: borderWidth.w,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(buttonRadius.r),
          onTap: disabled ? null : onTap,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: isLoading ? _buildLoader() : _buildText(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return CommonLoader(
      size: buttonHeight - 10,
    );
  }

  Widget _buildText() {
    return Text(
      titleText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
        color: titleColor,
        fontSize: titleSize.sp,
        fontWeight: titleWeight,
      ),
    );
  }
}