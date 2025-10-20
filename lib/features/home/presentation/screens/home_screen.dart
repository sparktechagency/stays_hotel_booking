import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/button/common_button.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            // Search Section
            _buildSearchSection(),
            
            // Featured Deals Section
            Expanded(
              child: _buildFeaturedDealsSection(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          // Left side - Logo and savings
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: AppStrings.appName,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.base500,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const CommonText(
                      text: AppStrings.totalSavings,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    SizedBox(width: 4.w),
                    const CommonText(
                      text: "\$1,234.56",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.base500,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Right side - Notification and profile
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.black,
                  size: 20,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.base500,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search destinations
          CommonTextField(
            hintText: AppStrings.searchDestinations,
            prefixIcon: const Icon(Icons.search, color: AppColors.subTitle),
            borderColor: AppColors.filledColor,
            fillColor: AppColors.filledColor,
            borderRadius: 8,
          ),
          SizedBox(height: 16.h),
          
          // Check in and Check out
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  hintText: AppStrings.checkIn,
                  prefixIcon: const Icon(Icons.calendar_today, color: AppColors.subTitle),
                  borderColor: AppColors.filledColor,
                  fillColor: AppColors.filledColor,
                  borderRadius: 8,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CommonTextField(
                  hintText: AppStrings.checkOut,
                  prefixIcon: const Icon(Icons.calendar_today, color: AppColors.subTitle),
                  borderColor: AppColors.filledColor,
                  fillColor: AppColors.filledColor,
                  borderRadius: 8,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Number of guests
          CommonTextField(
            hintText: AppStrings.numberOf,
            prefixIcon: const Icon(Icons.people, color: AppColors.subTitle),
            borderColor: AppColors.filledColor,
            fillColor: AppColors.filledColor,
            borderRadius: 8,
          ),
          SizedBox(height: 20.h),
          
          // Search button
          CommonButton(
            titleText: AppStrings.search,
            buttonHeight: 50,
            onTap: () {
              // TODO: Implement search functionality
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
          SizedBox(height: 24.h),
          
          // Featured Deals header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: AppStrings.featuredDeals,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.tune,
                  color: AppColors.black,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          // Hotel cards
          Expanded(
            child: ListView(
              children: [
                _buildHotelCard(),
                SizedBox(height: 16.h),
                _buildHotelCard(),
                SizedBox(height: 16.h),
                _buildHotelCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel image with badges
          Stack(
            children: [
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  color: AppColors.filledColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.hotel,
                    size: 60,
                    color: AppColors.subTitle,
                  ),
                ),
              ),
              
              // Discount badge
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.percent,
                        color: Colors.green,
                        size: 12,
                      ),
                      SizedBox(width: 4.w),
                      const CommonText(
                        text: AppStrings.upToOff,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Action buttons
              Positioned(
                top: 12.h,
                right: 12.w,
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
                        color: AppColors.black,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Hotel details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel name
                const CommonText(
                  text: AppStrings.hotelBlueSky,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                SizedBox(height: 8.h),
                
                // Location and rating
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.red,
                      size: 16,
                    ),
                    SizedBox(width: 4.w),
                    const CommonText(
                      text: AppStrings.africaCity,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    SizedBox(width: 16.w),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: 4.w),
                    const CommonText(
                      text: "4.7/10",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                
                // Description
                const CommonText(
                  text: AppStrings.hotelDescription,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                
                // Price and share
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CommonText(
                          text: "\$587",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subTitle,
                          underline: true,
                        ),
                        const CommonText(
                          text: AppStrings.staysPrice,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.base500,
                        ),
                      ],
                    ),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.share,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(AppStrings.home, Icons.home, true),
              _buildNavItem(AppStrings.booking, Icons.calendar_today, false),
              _buildNavItem(AppStrings.favourites, Icons.favorite_border, false),
              _buildNavItem(AppStrings.profile, Icons.person_outline, false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.base500 : AppColors.transparent,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 4.h),
        Icon(
          icon,
          color: isSelected ? AppColors.base500 : AppColors.subTitle,
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        CommonText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isSelected ? AppColors.base500 : AppColors.subTitle,
        ),
      ],
    );
  }
}