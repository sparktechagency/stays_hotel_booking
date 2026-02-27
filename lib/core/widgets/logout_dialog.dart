import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.overlayBox,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ),
               
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Title
            const CommonText(
              text: AppStrings.logout,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
            
            SizedBox(height: 16.h),
            
            // Confirmation message
            const CommonText(
              text: AppStrings.logoutConfirmation,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
            ),
            
            SizedBox(height: 24.h),
            
            // Action buttons
            Row(
              children: [
                // No button
                Expanded(
                  
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Container(

                    height: 46.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.base500),
                    ),
                    child: Center(
                      child: CommonText(
                        text: AppStrings.no,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.base500,
                      ),
                    ),
                  ) ),),
                
                SizedBox(width: 20.w),
                
                // Yes button
                Expanded(
                  child: CommonButton(
                    titleText: AppStrings.yes,
                    buttonHeight: 46,
                    buttonColor: AppColors.base500,
                    onTap: () => Navigator.of(context).pop(true),
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
