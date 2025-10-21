import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/features/hotel_details/presentation/provider/hotel_details_provider.dart';

class HotelDetailsScreen extends ConsumerWidget {
  const HotelDetailsScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      backgroundColor: AppColors.transparent,

      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        backgroundColor: AppColors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            
            size: 20,
            Icons.arrow_back_ios, color: AppColors.black),
        ),
        title: const CommonText(
          text: 'Hotel Blue Sky Details',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.whiteBgGradient
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Gallery Section
              _buildImageGallery(ref),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    text: AppStrings.hotelBlueSky,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4.w),
                      const CommonText(
                        text: '4.7',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.text,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: const [
                  Icon(Icons.location_on, color: AppColors.red, size: 12),
                  SizedBox(width: 2),
                  CommonText(
                    text: "Africa City",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.subTitle,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              const CommonText(
                text: 'Residence Amenities:',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 24.w,
                runSpacing: 12.h,
                children: const [
                  _Amenity(icon: Icons.ac_unit, label: 'Air condition'),
                  _Amenity(icon: Icons.group, label: '04'),
                  _Amenity(icon: Icons.king_bed_outlined, label: '05'),
                  _Amenity(icon: Icons.kitchen_outlined, label: 'Kitchen'),
                  _Amenity(icon: Icons.wifi, label: 'Wifi'),
                  _Amenity(icon: Icons.tv, label: 'TV'),
                  _Amenity(icon: Icons.waves_outlined, label: 'Hot water'),
                  _Amenity(icon: Icons.microwave_outlined, label: 'Microwave'),
                  _Amenity(icon: Icons.key, label: 'Keypad'),
                  _Amenity(icon: Icons.smoke_free, label: 'Smoke detector'),
                  _Amenity(icon: Icons.pool, label: 'Pool'),
                ],
              ),

              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      ref: ref,
                      context: context,
                      label: 'Check In',
                      dateProvider: checkInDateProvider,
                      isCheckIn: true,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildDateField(
                      ref: ref,
                      context: context,
                      label: 'Check Out',
                      dateProvider: checkOutDateProvider,
                      isCheckIn: false,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              const CommonText(
                text: 'About this Place:',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),
              SizedBox(height: 10.h),
              const CommonText(
                text:
                    'A quiet basement room with a double bed and desk. Semi-private entrance. Bathroom is shared. Enjoy the outdoor seating. Our cat roams freely. Please remove shoes in the hallway; no shoes in the room.',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.subTitle,
                maxLines: 100,
                textAlign: TextAlign.left,
              ),

               SizedBox(height: 16.h),

              const CommonText(
                text: 'Where you’ll be',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),

              10.height,

              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: const CommonImage(
                  imageSrc: AppImages.map,
                  height: 150,
                  width: double.infinity,
                  fill: BoxFit.cover,
                ),
              ),
              SizedBox(height: 150.h),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 126,
      
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.bottomBg), fit: BoxFit.cover),
        )
        ,child: Row(
          children: [
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CommonText(
                  
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                  text: "STAYS: \$470"),

                    CommonText(
                  
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                  text: "For: 2 nights, 10-12 Oct"),
              ],
            ), 

            Spacer(),

            Expanded(child: CommonButton(
              buttonHeight: 38,
              titleSize: 16,
              buttonRadius: 8,
              titleText: "Reserve", onTap: (){
                context.push(AppRoutes.clickReserve);
              },))

          ],
        ),
         ),
   
   
   
   
    );
  }

  // Date Field Widget with Riverpod
  Widget _buildDateField({
    required WidgetRef ref,
    required BuildContext context,
    required String label,
      required AutoDisposeStateProvider<String> dateProvider, 

    required bool isCheckIn,
  }) {
    final selectedDate = ref.watch(dateProvider);
    final controller = TextEditingController(text: selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.subTitle,
        ),
        SizedBox(height: 8.h),
        CommonTextField(
          controller: controller,
          hintText: 'Enter Date',
          prefixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.subTitle,
          ),
          borderColor: AppColors.filledColor,
          fillColor: AppColors.white,
          borderRadius: 8,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              initialDate: isCheckIn
                  ? DateTime.now()
                  : DateTime.now().add(const Duration(days: 1)),
            );
            if (date != null) {
              ref.read(dateProvider.notifier).state = _formatDate(date);
            }
          },
        ),
      ],
    );
  }

  // Image Gallery Widget
  Widget _buildImageGallery(WidgetRef ref) {
    final images = ref.watch(hotelImagesProvider);
    final selectedIndex = ref.watch(selectedImageIndexProvider);

    return SizedBox(
      height: 236.h,
      child: Stack(
        children: [
          // Main Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CommonImage(
              imageSrc: images[selectedIndex],
              height: 236,
              width: double.infinity,
              fill: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          // Thumbnail Images
          Positioned(
            right: 12,
            bottom: 12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) {
                  final thumbnailIndex = index ;
                  if (thumbnailIndex >= images.length) {
                    return const SizedBox();
                  }
                  final isSelected = selectedIndex == thumbnailIndex;
                  
                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedImageIndexProvider.notifier).state = thumbnailIndex;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: isSelected ? AppColors.yellow : AppColors.white,
                          width: 2.w,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: CommonImage(
                          imageSrc: images[thumbnailIndex],
                          height: 32,
                          width: 32,
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

  String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}

class _Amenity extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Amenity({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.subTitle),
        SizedBox(width: 4.w),
         CommonText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.subTitle,
        ),
      ],
    );
  }
}