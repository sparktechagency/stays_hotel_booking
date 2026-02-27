import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_colors.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/notifications/domain/models/notification_model.dart';

// Notification state
class NotificationState {
  final List<NotificationModel> notifications;
  final bool isLoading;

  NotificationState({
    this.notifications = const [],
    this.isLoading = false,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Notification notifier
class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier() : super(NotificationState()) {
    _loadNotifications();
  }

  void _loadNotifications() {
    state = state.copyWith(isLoading: true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      final notifications = _getMockNotifications();
      state = state.copyWith(
        notifications: notifications,
        isLoading: false,
      );
    });
  }

  List<NotificationModel> _getMockNotifications() {
    return [
      NotificationModel(
        id: '1',
        title: AppStrings.bookingConfirmation,
        message: AppStrings.bookingConfirmationMessage,
        timeAgo: AppStrings.twoHoursAgo,
        icon: Icons.check,
        iconColor: AppColors.white,
        iconBackgroundColor: Colors.green,
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: AppStrings.dateAlert,
        message: AppStrings.dateAlertMessage,
        timeAgo: AppStrings.fourHoursAgo,
        icon: Icons.percent,
        iconColor: AppColors.white,
        iconBackgroundColor: Colors.blue,
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        title: AppStrings.newMessage,
        message: AppStrings.newMessageText,
        timeAgo: AppStrings.fourHoursAgo,
        icon: Icons.message,
        iconColor: AppColors.white,
        iconBackgroundColor: Colors.orange,
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        title: AppStrings.travelInspiration,
        message: AppStrings.travelInspirationMessage,
        timeAgo: AppStrings.tenHoursAgo,
        icon: Icons.explore,
        iconColor: AppColors.white,
        iconBackgroundColor: Colors.purple,
        isRead: false,
      ),
    ];
  }

  void markAsRead(String notificationId) {
    final updatedNotifications = state.notifications.map((notification) {
      if (notification.id == notificationId) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
    
    state = state.copyWith(notifications: updatedNotifications);
  }

  void markAllAsRead() {
    final updatedNotifications = state.notifications.map((notification) {
      return notification.copyWith(isRead: true);
    }).toList();
    
    state = state.copyWith(notifications: updatedNotifications);
  }

  void refreshNotifications() {
    _loadNotifications();
  }
}

// Provider for notification notifier
final notificationNotifierProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier();
});
