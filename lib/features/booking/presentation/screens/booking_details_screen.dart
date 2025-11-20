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
import 'package:stays_hotel_booking/features/booking/presentation/providers/booking_details_provider.dart';

class BookingDetailsScreen extends ConsumerWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  

    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bg,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.text, size: 20),
        ),
        title: const CommonText(
          text: AppStrings.hotelBlueSkyDetails,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.bg),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ImageGallery(),
              SizedBox(height: 16.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CommonText(
                        text: 'Hotel Blue sky',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.red, size: 12),
                          SizedBox(width: 4),
                          CommonText(
                            text: AppStrings.africaCity,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTitle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(children: const [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        CommonText(text: '4.7', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.text),
                      ]),
                      8.height,
                      Consumer(
                        builder: (context, ref, _) {
                          final status = ref.watch(bookingStatusProvider);
                          final isCheckIn = status == 'check_in';
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: isCheckIn ? const Color(0xFFE8F7EF) : AppColors.base50,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: CommonText(
                              text: isCheckIn ? 'Check In' : AppStrings.pending,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isCheckIn ? const Color(0xFF19A05B) : AppColors.red,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              const CommonText(
                text: AppStrings.bookingInformation,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
              SizedBox(height: 10.h),

              const _InfoRow(title: AppStrings.bookingId, value: '#0gf521'),
              const _InfoRow(title: AppStrings.totalPerson, value: '05'),
              _InfoRow(title: AppStrings.date, value: _dateRange("07 Oct", "2 Oct")),
              _InfoRow(title: AppStrings.totalTime, value: "5 Days"),
              const _InfoRow(title: AppStrings.amount, value: r'$470'),

              SizedBox(height: 12.h),

              const _PaymentOptions(),

              SizedBox(height: 24.h),

              const CommonText(
                text: AppStrings.contactInformation,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              SizedBox(height: 2.h),

              _InfoRow(title: 'User Name', value: AppStrings.liamJohnsonFull),
              _InfoRow(title: 'User Contact', value: '+2712456378200'),
              _InfoRow(title: 'Email', value: AppStrings.liamEmailShort),
              _InfoRow(title: 'Address', value: AppStrings.liamAddress),

              SizedBox(height: 140.h),
            ],
          ),
        ),
      ),
       bottomNavigationBar: Container(
        height: 126.h,
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
                  side:  BorderSide(color: AppColors.subTitle),
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
              child: Consumer(
                builder: (context, ref, _) {
                  final status = ref.watch(bookingStatusProvider);
                  final isCheckIn = status == 'check_in';
                  return CommonButton(
                    titleText: isCheckIn ? 'Check Out' : 'Check In',
                    titleSize: 16,
                    titleWeight: FontWeight.w600,
                    buttonHeight: 38,
                    onTap: () {
                      if (isCheckIn) {
                        context.push(AppRoutes.bookingPayment);
                      } else {
                        ref.read(bookingStatusProvider.notifier).state = 'check_in';
                        context.pop();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _dateRange(String start, String end) {
    if (start.isEmpty || end.isEmpty) return '';
    return '$start - $end';
  }
}

class _ImageGallery extends ConsumerWidget {
  const _ImageGallery();

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
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: CommonText(
              text: title,
              
              fontSize: 16,textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
            ),
          ),
          const CommonText(text: ':', fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.subTitle),
          SizedBox(width: 8.w),
          Expanded(
            child: CommonText(
              text: value,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.end,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOptions extends ConsumerWidget {
  const _PaymentOptions();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(paymentMethodProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _optionTile(
          context: context,
          ref: ref,
          value: 'card',
          selected: selected,
          label: AppStrings.cardPayment,
        ),
        10.height,
        _optionTile(
          context: context,
          ref: ref,
          value: 'apple',
          selected: selected,
          label: AppStrings.applePay,
        ),
      ],
    );
  }

  Widget _optionTile({
    required BuildContext context,
    required WidgetRef ref,
    required String value,
    required String selected,
    required String label,
  }) {
    final isSelected = selected == value;
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () => ref.read(paymentMethodProvider.notifier).state = value,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ?
              AppColors.overlayBox: AppColors.transparent,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: isSelected ? Colors.transparent : AppColors.subTitle),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: CommonText(
                text: label,
                fontSize: 14,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                color: AppColors.text,
              ),
            ),
            SizedBox(
              height: 24.h,
              width: 24.h,
              child: Radio<String>(
                value: value,
                groupValue: selected,
                side: BorderSide(color: AppColors.subTitle),
                onChanged: (v) => ref.read(paymentMethodProvider.notifier).state = v ?? value,
                activeColor: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}