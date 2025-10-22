import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/features/profile/domain/models/profile_menu_item_model.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final ProfileMenuItemModel menuItem;
  final bool isLastItem;

  const ProfileMenuItemWidget({
    super.key,
    required this.menuItem,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            children: [
              // Icon
              Icon(
                menuItem.icon,
                color: menuItem.isDestructive ? Colors.red : AppColors.black,
                size: 18.sp,
              ),
              SizedBox(width: 12.w),
              // Title
              CommonText(
                text: menuItem.title,
                fontSize: 14,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                color: menuItem.isDestructive ? Colors.red : AppColors.black,
              ),
              // Ar
              //row icon
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.text,
                size: 16.sp,
              ),
            ],
          ),
        ),
        if (!isLastItem)
          Divider(
            height: 1,
            thickness: 1,
          
          
            color: AppColors.white500,
          ),
      ],
    );
  }
}
