import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/features/booking/presentation/providers/booking_details_provider.dart';

class BookingScreen extends ConsumerWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),

        child: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: AppColors.transparent,
          elevation: 0,
          backgroundColor: const Color(0xFFFDFBFB),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const CommonText(
            text:"",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.whiteBgGradient,
        ),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: 1,
          itemBuilder: (context, index) => _BookingCard(
            onTap: () => context.push(AppRoutes.bookingDetails),
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 1),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final VoidCallback? onTap;
  const _BookingCard({this.onTap});

  @override
  Widget build(BuildContext context) {
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
        child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: const CommonImage(
                    imageSrc: AppImages.hotelBooking,
                    height: 96,
                    width: 100,
                    fill: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    height: 14.h,
                    width: 14.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, size: 10, color: Colors.pinkAccent),
                  ),
                ),
              ],
            ),
            8.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  2.height,
                  const CommonText(
                    text: 'Mystic Palms',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.text,
                  ),
                  6.height,
                  Row(
                    children: const [
                      Icon(Icons.location_on, size: 14, color: AppColors.red),
                      SizedBox(width: 6),
                      CommonText(
                        text: 'Palm Springs, CA',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subTitle,
                      ),
                    ],
                  ),
        
                    const CommonText(
              text: '\$230',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF19A05B),
            ),
        
                        Row(
          children: const [
            Icon(Icons.calendar_today, size: 14, color: AppColors.subTitle),
            SizedBox(width: 6),
            CommonText(
              text: '20 aug - 24 aug',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.subTitle,
            ),
          ],
        ),
                
                ],
              ),
            ),
          
          
        
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   
             
              children: [
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    CommonText(
                      text: '4.7',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),

                50.height,
            
                      
               
            
                Consumer(
                  builder: (context, ref, _) {
                    final status = ref.watch(bookingStatusProvider);
                    final isCheckIn = status == 'check_in';
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isCheckIn ? const Color(0xFFE8F7EF) : const Color(0xFFFFEFEF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: CommonText(
                        text: isCheckIn ? 'Check In' : 'Pending',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isCheckIn ? const Color(0xFF19A05B) : const Color(0xFFFF4D4F),
                      ),
                    );
                  },
                ),
                        8.height,
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}