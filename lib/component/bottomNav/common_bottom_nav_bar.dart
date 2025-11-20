import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_icons.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';



class CommonBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const CommonBottomNavBar({required this.currentIndex, super.key});

  @override
  State<CommonBottomNavBar> createState() => _CommonBottomNavBarState();
}

class _CommonBottomNavBarState extends State<CommonBottomNavBar> {
  var bottomNavIndex = 0;
  List unselectedIcons = [
   AppIcons.homeInactive,
   AppIcons.bookingInactive,
   AppIcons.favInactive,
   AppIcons.profileInactive
  ];

  List selectedIcons = [
   AppIcons.homeActive,
   AppIcons.bookingWhiteActive,
    AppIcons.favWhiteActive,
   AppIcons.profileActive
  ];

  // List title = [
  //   "Home",
  //   "My Reservation",
  //   "Favorite",
  //   "Profile",
  // ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.all(0.sp),
        decoration: BoxDecoration(
            color: AppColors.bg
          ) , child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            
            unselectedIcons.length, (index) {
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: EdgeInsets.all(0),
             //   margin: EdgeInsetsDirectional.all(12.sp),
                child: Column(
                  children: [
                   
                    index == bottomNavIndex
                        ? CommonImage(
                          
                          fill: BoxFit.fill,
                   
                  
                     
                      imageSrc: selectedIcons[index],)
                        : CommonImage(
                     
                        
                  
                      imageSrc: unselectedIcons[index],),

              
                    
                    30.height,

              

                    



                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  void onTap(int index) async {
    if (kDebugMode) {
      print(widget.currentIndex);
    }
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        context.push(AppRoutes.home);
       
      }
    } else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        context.push(AppRoutes.booking);
       
      }
    } else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        context.push(AppRoutes.favorite);
    
      }
    } else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        context.push(AppRoutes.profile);       
      }
    }
  }
}
