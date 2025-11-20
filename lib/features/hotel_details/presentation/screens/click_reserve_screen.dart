import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:stays_hotel_booking/features/hotel_details/presentation/provider/hotel_details_provider.dart';

class ClickReserveScreen extends ConsumerWidget {
  const ClickReserveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIn = ref.watch(checkInDateProvider);
    final checkOut = ref.watch(checkOutDateProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        backgroundColor: AppColors.bg,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.text, size: 20),
        ),
        title: const CommonText(
          text: 'Hotel Blue Sky Details',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageGallery(),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: 'Hotel Blue sky',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
                    ),
                    6.height,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.location_on, color: AppColors.red, size: 12),
                SizedBox(width: 2),
                CommonText(
                  text: 'Africa City',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTitle,
                ),
              ],
            ),
           
           
                  ],
                ),
                Column(
                  children: [
                    _Rating(),
                    10.height,

                     Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.white500,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const CommonText(
                text: 'Available',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color:AppColors.green,
              ),
            ),

                  ],
                ),
              ],
            ),
          
            SizedBox(height: 16.h),

            const CommonText(
              text: 'Booking Information',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
            SizedBox(height: 9.h),

            const _InfoRow(title: 'Booking ID', value: '#0gf521'),
            const _InfoRow(title: 'User Name', value: 'Liam Johnson'),
            const _InfoRow(title: 'User Contact', value: '+2712456378200'),
            const _InfoRow(title: 'Total Person', value: '05'),
            _InfoRow(title: 'Date', value: _dateRange(checkIn, checkOut)),
            _InfoRow(title: 'Total Time', value: _daysDiff(checkIn, checkOut)),
            const _InfoRow(title: 'Amount', value: r'$470'),

            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 136.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.bottomBg), fit: BoxFit.cover)
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.black400,
                  side:  BorderSide(color: AppColors.base50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child:  CommonText(
                  text: 'Cancel',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subTitle,
                ),
              ),
            ),
      Spacer(),
            Expanded(
              child: CommonButton(
                titleText: 'Continue',
                titleSize: 16,
                titleWeight: FontWeight.w600,
                buttonHeight: 38,
                onTap: () {
                   _showBookingSuccessBottomSheet(context);
            
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showBookingSuccessBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.overlayBox,
    isScrollControlled: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          2.h,
          20.w,
          20.h + MediaQuery.of(ctx).padding.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            45.height,
            CommonImage(
              imageSrc: AppImages.bookingSuccess,
              height: 99.h,
              width: 95.h,
              fill: BoxFit.contain,
            ),
            SizedBox(height: 20.h),
            const CommonText(
              text: AppStrings.bookingSuccessTitle,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            const CommonText(
              text: AppStrings.bookingSuccessMessage,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
            SizedBox(height: 80.h),
            CommonButton(
              titleText: AppStrings.bookingListCta,
              buttonHeight: 46,
              onTap: () {
                Navigator.of(ctx).pop();
                context.go(AppRoutes.booking);
              },
            ),

            15.height,
          ],
        ),
      );
    },
  );
}
  

  static String _dateRange(String start, String end) {
    if (start.isEmpty || end.isEmpty) return '';
    return '$start - $end';
    // Example expected: "07 Oct - 12 Oct"
  }

  static String _daysDiff(String start, String end) {
    try {
      if (start.isEmpty || end.isEmpty) return '';
      final s = DateTime.parse(start);
      final e = DateTime.parse(end);
      final d = e.difference(s).inDays;
      if (d <= 0) return '';
      return '$d Days';
    } catch (_) {
      return '';
    }
  }
}

class _Rating extends StatelessWidget {
  const _Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.star, color: Colors.amber, size: 18),
        SizedBox(width: 4),
        CommonText(
          text: '4.7',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ],
    );
  }
}

/// Reuses the same Riverpod providers as HotelDetailsScreen:
/// - hotelImagesProvider
/// - selectedImageIndexProvider
class _ImageGallery extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(hotelImagesProvider);
    final selectedIndex = ref.watch(selectedImageIndexProvider);

    return SizedBox(
      height: 236.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CommonImage(
              imageSrc: images[selectedIndex],
              height: 236,
              width: double.infinity,
              fill: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Column(
              children: List.generate(
                images.length,
                (index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => ref.read(selectedImageIndexProvider.notifier).state = index,
                    child: Container(
                      margin: EdgeInsets.only(top: 8.h),
                      height: 32.h,
                      width: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: isSelected ? AppColors.yellow : AppColors.white,
                          width: 2.w,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: CommonImage(
                          imageSrc: images[index],
                          height: 32.h,
                          width: 32.h,
                          fill: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: CommonText(
              text: title,
              textAlign: TextAlign.start,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
            ),
          ),
          const CommonText(
            text: ':',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.subTitle,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CommonText(
              text: value,
              fontSize: 16,
              textAlign: TextAlign.end,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
