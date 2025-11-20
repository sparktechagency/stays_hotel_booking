import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_icons.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/features/home/presentation/providers/home_provider.dart';
import 'package:stays_hotel_booking/features/filter/presentation/widgets/filter_bottom_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          backgroundColor: AppColors.bg,
        ),
      ),
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Container(
                    decoration: BoxDecoration(color: AppColors.black),

          // decoration: BoxDecoration(gradient: AppColors.whiteBgGradient),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSearchSection(ref),
                      _buildFeaturedDealsSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CommonBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CommonText(
            text: AppStrings.appName,
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: AppColors.base500,
          ),
             
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: AppStrings.totalSavings,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                  const CommonText(
                    text: "\$1,234.56",
                    fontSize: 14,
                    top: 3,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ],
              ),
             
             
             
          Row(
            children: [
           
              10.width,
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.notifications),
                    child: CommonImage(
                      imageSrc: AppIcons.notification,
                      width: 24.h,
                      height: 24.h,
                      fill: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(AppImages.profile),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(WidgetRef ref) {
    final checkIn = ref.watch(homeCheckInDateProvider);
    final checkOut = ref.watch(homeCheckOutDateProvider);
    final guests = ref.watch(homeGuestsProvider);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black400),
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
            CommonTextField(
              hintText: AppStrings.searchDestinations,
              prefixIcon: const Icon(Icons.search, color: AppColors.subTitle),
              borderColor: AppColors.black400,
              fillColor: AppColors.transparent,
              borderRadius: 8,
              onTap: () => context.push(AppRoutes.searchResults),
              onChanged: (value) =>
                  ref.read(homeSearchQueryProvider.notifier).state = value,
            ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  hintText: AppStrings.checkIn,
                  controller: TextEditingController(text: checkIn),
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.subTitle,
                  ),
                  borderColor: AppColors.black400,
                  fillColor: AppColors.transparent,
                  borderRadius: 8,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      ref.read(homeCheckInDateProvider.notifier).state =
                          '${date.day}/${date.month}/${date.year}';
                    }
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CommonTextField(
                  hintText: AppStrings.checkOut,
                  controller: TextEditingController(text: checkOut),
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.subTitle,
                  ),
                  borderColor: AppColors.black400,
                  fillColor: AppColors.transparent,
                  borderRadius: 8,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().add(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 366)),
                    );
                    if (date != null) {
                      ref.read(homeCheckOutDateProvider.notifier).state =
                          '${date.day}/${date.month}/${date.year}';
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CommonTextField(
            hintText: AppStrings.numberOf,
            controller: TextEditingController(text: guests),
            prefixIcon: const Icon(Icons.people, color: AppColors.subTitle),
            borderColor: AppColors.black400,
            fillColor: AppColors.transparent,
            borderRadius: 8,
            onChanged: (value) =>
                ref.read(homeGuestsProvider.notifier).state = value,
          ),
          SizedBox(height: 12.h),
          CommonButton(
            titleText: AppStrings.search,
            buttonHeight: 50,
            onTap: () {
              // Search functionality will use the values from the providers
              // ref.read(searchNotifierProvider.notifier).searchHotels(
              //   query: searchQuery,
              //   checkIn: checkIn,
              //   checkOut: checkOut,
              //   guests: guests,
              // );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedDealsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: AppStrings.featuredDeals,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
              GestureDetector(
                onTap: () => _showFilterBottomSheet(context),
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppColors.overlayBox,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(
                    Icons.tune,
                    color: AppColors.green,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

    
          SizedBox(height: 10.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3, // Example: 3 hotel cards
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: GestureDetector(
                onTap: () {
                 context.push(AppRoutes.hotelDetails);
                },
                child: _buildHotelCard(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
       // border: Border.all(color: AppColors.filledColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CommonImage(
                    imageSrc: AppImages.hotelBooking,
                    width: double.infinity,
                    height: 200.h,
                    fill: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 16.h,
                left: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CommonImage(
                        height: 13,
                        width: 13,
                        imageSrc: AppImages.parcent,
                      ),
                      SizedBox(width: 4.w),
                      const CommonText(
                        text: AppStrings.upToOff,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.highlight,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 16.h,
                right: 16.w,
                child: Row(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        color: AppColors.black,
                        size: 16,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: AppColors.black400,
                        size: 16,
                      ),
                    ),
                  ],
                  
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: AppStrings.hotelBlueSky,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.red,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            const CommonText(
                              text: AppStrings.africaCity,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.subTitle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white500,
                        borderRadius: BorderRadius.circular(23.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4.w),
                          const CommonText(
                            text: "4.7/10",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                const CommonText(
                  text: AppStrings.hotelDescription,
                  fontSize: 12,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                  maxLines: 2,
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Public: \$587",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.subTitle,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        const CommonText(
                          text: AppStrings.staysPrice,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.base500,
                        ),
                      ],
                    ),
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.white500,
                      ),
                      child: Image.asset(
                        AppImages.share,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}
