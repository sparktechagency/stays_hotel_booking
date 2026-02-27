import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Folder icon
         CommonImage(imageSrc: AppImages.notFound, width: 134.w, height: 90.h),
          
          SizedBox(height: 14.h),
          
          // Data not found text
          CommonText(
            text: AppStrings.dataNotFound,
            fontSize: 16,
            fontWeight: FontWeight.w600,

            color: Color(0xFFFC6057),
          ),
        ],
      ),
    );
  }
}
