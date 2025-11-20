import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';

class FavoriteScreens extends StatefulWidget {
  const FavoriteScreens({super.key});

  @override
  State<FavoriteScreens> createState() => _FavoriteScreensState();
}

class _FavoriteScreensState extends State<FavoriteScreens> {
  final _items = const [
    _FavItem(title: 'Mystic Palms', location: 'Palm Springs, CA', price: '\$230/night', rating: '4.7', image: AppImages.hotelBooking),
    _FavItem(title: 'Mystic Palms', location: 'Palm Springs, CA', price: '\$230/night', rating: '4.8', image: AppImages.hotelBooking2),
    _FavItem(title: 'Mystic Palms', location: 'Palm Springs, CA', price: '\$230/night', rating: '4.9', image: AppImages.hotelBooking3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.transparent,
        elevation: 0,
        backgroundColor: AppColors.bg,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const CommonText(
          text: AppStrings.favourites,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.bg,
        ),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: _items.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) => _FavoriteCard(item: _items[index]),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 2),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final _FavItem item;
  const _FavoriteCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.overlayBox
        ,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CommonImage(
                    imageSrc: item.image,
                    height: 96.h,
                    width: 90.w,
                    fill: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 6,

                  right: 6,
                  child: Container(
                    height: 14.h,
                    width: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, size: 10, color: Colors.pinkAccent),
                  ),
                ),
            
            
                Positioned(
                  bottom: 6,

                  right: 6,
                  child: Container(
                    height: 16.h,
                    width: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.bookmark_border, size: 10, color: AppColors.overlayBox),
                  ),
                ),
            
            
              ],
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
                    text: item.title,
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
                        text: item.location,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CommonText(
                    text: item.price,
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
                      text: item.rating,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text,
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

class _FavItem {
  final String title;
  final String location;
  final String price;
  final String rating;
  final String image;
  const _FavItem({
    required this.title,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
  });
}