import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stays_hotel_booking/component/bottomNav/common_bottom_nav_bar.dart';
import 'package:stays_hotel_booking/component/image/common_image.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/core/utils/extensions/extension.dart';
import 'package:stays_hotel_booking/app/app_router.dart';
import 'package:stays_hotel_booking/features/profile/domain/models/user_model.dart';
import 'package:stays_hotel_booking/features/profile/presentation/providers/profile_provider.dart';
import 'package:stays_hotel_booking/features/profile/presentation/widgets/profile_menu_item_widget.dart';
import 'package:stays_hotel_booking/core/widgets/logout_dialog.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProfileProvider);
    final personalInfoMenu = ref.watch(personalInfoMenuProvider);
    final settingsMenu = ref.watch(settingsMenuProvider);

    return Scaffold(
      backgroundColor: AppColors.bg
      ,
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
        child: Container(
          decoration: BoxDecoration(color: AppColors.bg),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
          
                // User Profile Header
                _buildUserProfileHeader(user),
          
                SizedBox(height: 16.h),
          
                // Personal Information Section Card
                _buildMenuCard(
                  title: AppStrings.personalInformation,
                  items: personalInfoMenu,
                ),
          
                SizedBox(height: 16.h),
          
                // Settings Section Card
                _buildMenuCard(
                  title: AppStrings.setting,
                  items: settingsMenu,
                ),
          
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CommonBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildUserProfileHeader(UserModel user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.40),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: CommonImage(
              imageSrc: AppImages.profile,
              width: 80.w,
              height: 80.h,
              fill: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: user.name,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: user.email,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subTitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required String title, required List<dynamic> items}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.overlayBox,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(0, 0),
            blurRadius: 4,
          ),
        ],
        //border: Border.all(color: AppColors.white500),

        borderRadius: BorderRadius.circular(12.r),
     ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title inside card
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 4.h),
            child: CommonText(
              text: title.toUpperCase(),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
          3.height,
               Divider(
              height: 1,
              thickness: 1,
            
            
              color: AppColors.white500,
            ),
        
           // Items
           ...List.generate(
             items.length,
             (index) => GestureDetector(
               onTap: () => _handleMenuTap(title,index,items[index]),
               child: ProfileMenuItemWidget(
                 menuItem: items[index],
                 isLastItem: index == items.length - 1,
               ),
             ),
           ),
        ],
      ),
    );
  }

  void _handleMenuTap(String title, int index,dynamic menuItem) {

    if(title == AppStrings.personalInformation){
      if (index == 0) {
      context.push(AppRoutes.personalInformation);
    } else if(index == 1) {
      context.push(AppRoutes.myPlan);
    
   
    }
    else if(index == 2) {
      context.push(AppRoutes.myBooking);
    }
    else if(index == 3) {
      context.push(AppRoutes.totalSaved);
    }
    else if(index == 4) {
      context.push(AppRoutes.inviteMember);
    }
    }
    else if(title == AppStrings.setting) {
      if (index == 0) { // Change Password
        context.push(AppRoutes.changePassword);
      }
      else if (index == 1) { // Language
        context.push(AppRoutes.language);
      }
      else if (index == 2) { // FAQ
        context.push(AppRoutes.faq);
      }
      else if (index == 3) { // About Us
        context.push(AppRoutes.aboutUs);
      }
      else if (index == 4) { // Privacy Policy
        context.push(AppRoutes.privacyPolicy);
      }
      else if (index == 5) { // Terms & Conditions
        context.push(AppRoutes.termsConditions);
      }
      else if (index == 6) { // Logout
        _showLogoutDialog(context);
      }
      // Add other settings menu items here as needed
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LogoutDialog();
      },
    ).then((confirmed) {
      if (confirmed == true) {
        // Navigate to sign-in screen
        context.go(AppRoutes.signIn);
      }
    });
  }
}