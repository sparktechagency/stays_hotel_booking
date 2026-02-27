import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/filter/presentation/providers/filter_provider.dart';

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filterNotifierProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(context),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Star Rating Section

                  const CommonText(
            text: AppStrings.starRating,
            fontSize: 16,
            top: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
          SizedBox(height: 12.h),
                  _buildStarRatingSection(ref, state),
                  
                  SizedBox(height: 24.h),
                  
                  // Meals Section
                  const CommonText(
            text: AppStrings.meals,
            fontSize: 16,
            top: 10,
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
          SizedBox(height: 12.h),
                  _buildMealsSection(ref, state),
                  
                  SizedBox(height: 24.h),

                      const CommonText(
            text: AppStrings.distance,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.text,
          ),
          SizedBox(height: 12.h),
                  
                  // Distance Section
                  _buildDistanceSection(ref, state),
                  
                  SizedBox(height: 24.h),
                    const CommonText(
            text: AppStrings.priceFor2Nights,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
          SizedBox(height: 12.h),
                  // Price Section
                  _buildPriceSection(ref, state),
                  
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          
          // Action Buttons
          _buildActionButtons(context, ref),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          const Expanded(
            child: CommonText(
              text: AppStrings.filterSection,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.base500,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
              color: AppColors.black,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRatingSection(WidgetRef ref, FilterState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            width: 0.3,
            color: AppColors.white500),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
            offset: const Offset(0, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          
          // Star rating options in horizontal layout
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildStarRatingChip(ref, state, AppStrings.fiveStars, "5"),
              _buildStarRatingChip(ref, state, AppStrings.fourStars, "4"),
              _buildStarRatingChip(ref, state, AppStrings.threeStars, "3"),
              _buildStarRatingChip(ref, state, AppStrings.twoStars, "2"),
              _buildFilterChip(
                text: AppStrings.orWithoutStarRating,
                isSelected: state.isStarRatingWithout,
                onTap: () => ref.read(filterNotifierProvider.notifier).selectWithoutStarRating(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStarRatingChip(WidgetRef ref, FilterState state, String text, String value) {
    return _buildFilterChip(
      text: text,
      isSelected: state.selectedStarRating == value,
      onTap: () => ref.read(filterNotifierProvider.notifier).selectStarRating(value),
    );
  }

  Widget _buildMealsSection(WidgetRef ref, FilterState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.subTitle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          
          // Meals options in horizontal layout
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildFilterChip(
                text: AppStrings.noMealsIncluded,
                isSelected: state.selectedMeal == "no_meals",
                onTap: () => ref.read(filterNotifierProvider.notifier).selectMeal("no_meals"),
              ),
              _buildFilterChip(
                text: AppStrings.allInclusive,
                isSelected: state.selectedMeal == "all_inclusive",
                onTap: () => ref.read(filterNotifierProvider.notifier).selectMeal("all_inclusive"),
              ),
              _buildFilterChip(
                text: AppStrings.breakfastIncluded,
                isSelected: state.selectedMeal == "breakfast",
                onTap: () => ref.read(filterNotifierProvider.notifier).selectMeal("breakfast"),
              ),
              _buildFilterChip(
                text: AppStrings.breakfastDinnerOrLunch,
                isSelected: state.selectedMeal == "breakfast_dinner_lunch",
                onTap: () => ref.read(filterNotifierProvider.notifier).selectMeal("breakfast_dinner_lunch"),
              ),
              _buildFilterChip(
                text: AppStrings.breakfastLunchDinner,
                isSelected: state.selectedMeal == "breakfast_lunch_dinner",
                onTap: () => ref.read(filterNotifierProvider.notifier).selectMeal("breakfast_lunch_dinner"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceSection(WidgetRef ref, FilterState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.subTitle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          
          // Slider
          Slider(
            value: state.distanceValue,
            min: 0,
            max: 100,
            divisions: 20,
            activeColor: AppColors.base500,
            inactiveColor: AppColors.base500.withOpacity(0.3),
            onChanged: (value) {
              ref.read(filterNotifierProvider.notifier).updateDistance(value);
            },
          ),
          
          SizedBox(height: 8.h),
          
          // Distance text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${AppStrings.noMoreThan} ${state.distanceValue.toInt()} ${AppStrings.kmToCityCenter}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subTitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(WidgetRef ref, FilterState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.subTitle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 0),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          
          Row(
            children: [
              // From price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppStrings.from,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      hintText: "\$${state.minPrice.toInt()}",
                      keyboardType: TextInputType.number,
                      borderColor: AppColors.strokeColor,
                      hintTextColor: AppColors.subTitle,
                      fillColor: AppColors.overlayBox,

                      borderRadius: 8,
                      onChanged: (value) {
                        final price = double.tryParse(value.replaceAll('\$', '')) ?? state.minPrice;
                        ref.read(filterNotifierProvider.notifier).updateMinPrice(price);
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 16.w),
              
              // To price
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppStrings.to,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTitle,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextField(
                      hintText: "\$${state.maxPrice.toInt()}",
                      keyboardType: TextInputType.number,
                      borderColor: AppColors.strokeColor,
                      hintTextColor: AppColors.subTitle,
                      fillColor: AppColors.overlayBox,
                      borderRadius: 8,
                      onChanged: (value) {
                        final price = double.tryParse(value.replaceAll('\$', '')) ?? state.maxPrice;
                        ref.read(filterNotifierProvider.notifier).updateMaxPrice(price);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.overlayBox : AppColors.overlayBox,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? AppColors.yellow : AppColors.subTitle,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text.contains('☆')) ...[
              CommonText(
                text: text,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.subTitle : AppColors.subTitle,
              ),
            ] else if (text == AppStrings.orWithoutStarRating) ...[
              Icon(
                Icons.star_outline,
                color: isSelected ? AppColors.subTitle : AppColors.subTitle,
                size: 16,
              ),
              SizedBox(width: 8.w),
              CommonText(
                text: text,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.subTitle : AppColors.subTitle,
              ),
            ] else ...[
              CommonText(
                text: text,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppColors.subTitle : AppColors.subTitle,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          // Clear all button
      

          InkWell(
            onTap: () {
              ref.read(filterNotifierProvider.notifier).clearAllFilters();
            },
            child: Container(
              height: 50,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.black400,
              ),
              child: Center(
                child: CommonText(
                  text: AppStrings.clearAll,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.subTitle,
                ),
              ),
            ),
          ),

          Spacer(),
        
         
          
          // Show offers button
          InkWell(
            onTap: () {
              ref.read(filterNotifierProvider.notifier).clearAllFilters();
            },
            child: Container(
              height: 50,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
              child: Center(
                child: CommonText(
                  text: "Show 260 offers",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black400,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
