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

class BookingPaymentScreen extends ConsumerWidget {
  const BookingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(bookingStatusProvider);
    final isCheckIn = status == 'check_in';

    return Scaffold(
      backgroundColor: AppColors.transparent,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteBgStart,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black, size: 20),
        ),
        title: const CommonText(
          text: AppStrings.hotelBlueSkyDetails,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.whiteBgGradient),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ImageGallery(),
              16.height,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CommonText(
                        text: 'Hotel Blue sky',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isCheckIn ? const Color(0xFFE8F7EF) : AppColors.base50,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: CommonText(
                          text: isCheckIn ? 'Check Out' : AppStrings.pending,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isCheckIn ? const Color(0xFF19A05B) : AppColors.base500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              16.height,

              const CommonText(
                text: AppStrings.bookingInformation,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              10.height,

              const _InfoRow(title: AppStrings.bookingId, value: '#0gf521'),
              const _InfoRow(title: AppStrings.totalPerson, value: '05'),
              const _InfoRow(title: AppStrings.date, value: '07 Oct - 12 Oct'),
              const _InfoRow(title: AppStrings.totalTime, value: '3 Days'),
              const _InfoRow(title: AppStrings.amount, value: r'$470'),

              12.height,

              const _SelectedPaymentView(),

              15.height,
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


           
              140.height,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 126.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.bottomBg), fit: BoxFit.cover),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.base50,
                  side: const BorderSide(color: AppColors.base50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                ),
                child: const CommonText(
                  text: AppStrings.cancel,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.base500,
                ),
              ),
            ),
            Spacer(),
            Expanded(
              child: CommonButton(
                titleText: 'Payment',
                buttonHeight: 38,
                titleSize: 16,
                titleWeight: FontWeight.w600,
                onTap: () {
                  _showCheckoutSuccessBottomSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        int selected = 0;
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
            top: 12.h,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  InkWell(
                    onTap: () =>   Navigator.of(ctx).pop(),
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: EdgeInsets.only(bottom: 40.h),
                      decoration: BoxDecoration(
                        color: AppColors.black100,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                CommonImage(
                  height: 90,
                  width: 90,
                  imageSrc: AppImages.bookingSuccess),
                  24.height,
                  const CommonText(

                    text: 'Checkout Successful!',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                    textAlign: TextAlign.center,
                  ),
                  6.height,
                  const CommonText(
                    text: 'Thanks for your visit',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subTitle,
                    textAlign: TextAlign.center,
                  ),
                  15.height,
                  const CommonText(
                    text: 'Give us rating out of 5!',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final filled = index < selected;
                      return IconButton(
                        onPressed: () => setState(() => selected = index + 1),
                        splashRadius: 15,
                        icon: Icon(
                          filled ? Icons.star : Icons.star_border,
                          size: 28,
                          color: filled ? Colors.amber : const Color(0xFFC7C7CC),
                        ),
                      );
                    }),
                  ),
                  16.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CommonButton(
                      titleText: 'Submit',
                      buttonHeight: 46,
                      onTap: () {
                        Navigator.of(ctx).pop();
                        context.go(AppRoutes.home);
                      },
                    ),
                  ),

                  40.height
                ],
              );
            },
          ),
        );
      },
    );
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
              fontSize: 16,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
            ),
          ),
          const CommonText(text: ':', fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.subTitle),
          8.width,
          Expanded(
            child: CommonText(
              text: value,
              fontSize: 14,
              maxLines: 2,
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

class _SelectedPaymentView extends ConsumerWidget {
  const _SelectedPaymentView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(paymentMethodProvider);
    final label = selected == 'apple' ? AppStrings.applePay : AppStrings.cardPayment;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Colors.transparent),
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
              value: selected,
              groupValue: selected,
              onChanged: null, // read-only
              activeColor: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}