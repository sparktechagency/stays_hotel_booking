import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/saved/domain/models/saved_item_model.dart';
import 'package:stays_hotel_booking/features/saved/presentation/providers/total_saved_provider.dart';

class TotalSavedScreen extends ConsumerStatefulWidget {
  const TotalSavedScreen({super.key});

  @override
  ConsumerState<TotalSavedScreen> createState() => _TotalSavedScreenState();
}

class _TotalSavedScreenState extends ConsumerState<TotalSavedScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(totalSavedNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.bg,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Content
            Expanded(
              child: _buildContent(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.text,
              size: 20,
            ),
          ),
          SizedBox(width: 16.w),
          const Expanded(
            child: CommonText(
              text: AppStrings.totalSaved,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(TotalSavedState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.base500,
        ),
      );
    }

    if (state.savedItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 64.sp,
              color: AppColors.subTitle,
            ),
            SizedBox(height: 16.h),
            const CommonText(
              text: "No saved items",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.subTitle,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: state.savedItems.length,
      itemBuilder: (context, index) {
        final item = state.savedItems[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: _buildSavedItemCard(item),
        );
      },
    );
  }

  Widget _buildSavedItemCard(SavedItemModel item) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
            blurRadius:4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image with overlay icons
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CommonImage(
                  imageSrc: item.imageUrl,
                  width: 100.w,
                  height: 100.h,
                  fill: BoxFit.cover,
                ),
              ),
              
              // Favorite icon
              Positioned(
                top: 4.h,
                right: 4.w,
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.red,
                    size: 12,
                  ),
                ),
              ),
              
              // Star icon
              Positioned(
                bottom: 4.h,
                right: 4.w,
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 1),
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.amber,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(width: 12.w),
          
          // Property details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property name
                CommonText(
                  text: item.name,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
                SizedBox(height: 8.h),
                
                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.red,
                      size: 14,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CommonText(
                        text: item.location,
                        fontSize: 14,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                
                // Price
                CommonText(
                  text: "\$${item.price.toInt()}${AppStrings.nightPrice}",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          
          // Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
              SizedBox(height: 4.h),
              CommonText(
                text: item.rating.toString(),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
