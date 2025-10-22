import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/component/text_field/common_text_field.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/features/search/domain/models/hotel_model.dart';
import 'package:stays_hotel_booking/features/search/presentation/providers/search_provider.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load initial results
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchNotifierProvider.notifier).searchHotels('hotel');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);
    
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Search Bar
            _buildSearchBar(),
            
            // Results Count
            _buildResultsCount(searchState.results.length),
            
            // Hotel List
            Expanded(
              child: _buildHotelList(searchState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.text,
              size: 20,
            ),
          ),
          SizedBox(width: 16.w),
          const Expanded(
            child: CommonText(
              text: AppStrings.searchResults,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CommonTextField(
        controller: _searchController,
        hintText: AppStrings.searchHint,
        prefixIcon: const Icon(Icons.search, color: AppColors.subTitle),
        borderColor: AppColors.filledColor,
        fillColor: AppColors.transparent,
        borderRadius: 50,
        onChanged: (value) {
          ref.read(searchNotifierProvider.notifier).updateQuery(value);
          ref.read(searchNotifierProvider.notifier).searchHotels(value);
        },
      ),
    );
  }

  Widget _buildResultsCount(int count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          CommonText(
            text: "$count places",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
          ),
        ],
      ),
    );
  }

  Widget _buildHotelList(SearchState searchState) {
    if (searchState.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.base500,
        ),
      );
    }

    if (searchState.results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.sp,
              color: AppColors.subTitle,
            ),
            SizedBox(height: 16.h),
            const CommonText(
              text: "No hotels found",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.subTitle,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: searchState.results.length,
      itemBuilder: (context, index) {
        final hotel = searchState.results[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: GestureDetector(
            onTap: () {
              // TODO: Navigate to hotel details
              context.push(AppRoutes.hotelDetails);
            },
            child: _buildHotelCard(hotel),
          ),
        );
      },
    );
  }

  Widget _buildHotelCard(HotelModel hotel) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with heart overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CommonImage(
                imageSrc: AppImages.hotelBooking,
                height: 96.h,
                width: 100.w,
                fill: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  7.height,
                  CommonText(
                    text: "Hotel Blue sky",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.red),
                      const SizedBox(width:6),
                      CommonText(
                        text:"Palm Springs, CA",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CommonText(
                    text: "\$630/night",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF19A05B),
                  ),
                ],
              ),
            ),
            // Rating
            Column(
              children: [
                10.height,
                Row(
                  
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    CommonText(
                      text: "4.9",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),

                    10.width,
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
