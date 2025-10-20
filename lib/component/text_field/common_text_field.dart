import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.mexLength,
    this.validator,
    this.prefixText,
    this.paddingHorizontal = 16,
    this.paddingVertical = 14,
    this.borderRadius = 4,
    this.inputFormatters,
    this.fillColor = AppColors.transparent,
    this.hintTextColor = AppColors.textFiledColor,
    this.labelTextColor = AppColors.textFiledColor,
    this.textColor = AppColors.black,
    this.borderColor = AppColors.base500,
    this.onSubmitted,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.obscure,
    this.onToggleObscure,
  });

  final String? hintText;
  final String? labelText;
  final String? prefixText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color borderColor;

  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;
  final int? mexLength;

  final bool isPassword;
  final bool? obscure;

  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onToggleObscure;

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final bool effectiveObscure = isPassword ? (obscure ?? true) : false;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: effectiveObscure,
      textInputAction: textInputAction,
      maxLength: mexLength,
      cursorColor: AppColors.primaryColor,
      inputFormatters: inputFormatters,
      style: TextStyle(fontSize: 14, color: textColor),
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal.w,
          vertical: paddingVertical.h,
        ),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        disabledBorder: _buildBorder(),
        errorBorder: _buildBorder(),
        hintText: hintText,
        labelText: labelText,
        hintStyle: GoogleFonts.roboto(fontSize: 14, color: hintTextColor),
        labelStyle: GoogleFonts.roboto(fontSize: 14, color: labelTextColor),
        prefix: CommonText(text: prefixText ?? "", fontWeight: FontWeight.w400),
        suffixIcon: isPassword
            ? (onToggleObscure == null
                ? null
                : Padding(
                    padding: EdgeInsetsDirectional.only(end: 10.w),
                    child: IconButton(
                      onPressed: onToggleObscure,
                      icon: Icon(
                        effectiveObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                        color: textColor,
                      ),
                      splashRadius: 20,
                    ),
                  ))
            : suffixIcon,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: BorderSide(color: borderColor),
    );
  }
}