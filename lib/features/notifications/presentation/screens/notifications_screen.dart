import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/component/text/common_text.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/notifications/domain/models/notification_model.dart';
import 'package:stays_hotel_booking/features/notifications/presentation/providers/notification_provider.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationNotifierProvider);

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
              text: AppStrings.notifications,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(NotificationState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.base500,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: state.notifications.length,
      itemBuilder: (context, index) {
        final notification = state.notifications[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: _buildNotificationCard(notification),
        );
      },
    );
  }

  Widget _buildNotificationCard(NotificationModel notification) {
    return GestureDetector(
      onTap: () {
        ref.read(notificationNotifierProvider.notifier).markAsRead(notification.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(0.r),
          border: Border(
            
            bottom: BorderSide(
              width: 1,
              color: AppColors.black400)),
        ),
        child: Row(
          children: [
            // Notification icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.black500,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                notification.icon,
                color: AppColors.text,
                size: 20.sp,
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CommonText(
                    text: notification.title,
                    fontSize: 16,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                  SizedBox(height: 4.h),
                  
                  // Message
                  CommonText(
                    text: notification.message,
                    fontSize: 14,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subTitle,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 12.w),
            
            // Time ago
            CommonText(
              text: notification.timeAgo,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ],
        ),
      ),
    );
  }
}
