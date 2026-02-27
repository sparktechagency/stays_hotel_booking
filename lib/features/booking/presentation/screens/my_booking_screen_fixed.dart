import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';

class MyBookingScreenFixed extends StatelessWidget {
  const MyBookingScreenFixed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.text, size: 20),
        ),
        centerTitle: true,
        title: const CommonText(
          text: AppStrings.myBooking,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: const CommonImage(
                  imageSrc: AppImages.hotelBooking,
                  height: 200,
                  width: double.infinity,
                  fill: BoxFit.cover,
                ),
              ),
              16.height,
              const CommonText(
                text: AppStrings.bookingInformation,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
              10.height,
              _infoRow('Booking ID', '#0gf521'),
              _infoRow('Total Person', '05'),
              _infoRow('Date', '07 Oct - 12 Oct'),
              _infoRow('Total Time', '2 Days'),
              _infoRow('Total Amount', r'$23 690', highlight: true),
              _infoRow('Status', 'Unpaid', warn: true),
              24.height,
              CommonButton(
                titleText: 'Pay Now',
                buttonHeight: 46,
                onTap: () => context.push(AppRoutes.bookingPayment),
              ),
              12.height,
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.home),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.subTitle),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: const CommonText(
                  text: 'Back to Home',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    bool highlight = false,
    bool warn = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
              textAlign: TextAlign.start,
            ),
          ),
          const CommonText(
            text: ':',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.subTitle,
          ),
          8.width,
          Expanded(
            child: CommonText(
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: warn
                  ? const Color(0xFFF3C200)
                  : (highlight ? AppColors.base500 : AppColors.subTitle),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
