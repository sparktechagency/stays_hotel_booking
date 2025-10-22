import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/profile/domain/models/profile_menu_item_model.dart';
import 'package:stays_hotel_booking/features/profile/domain/models/user_model.dart';

// User profile provider
final userProfileProvider = StateProvider<UserModel>((ref) {
  return UserModel(
    id: '1',
    name: 'Liam Johnson',
    email: 'liamjohnson@gmail.com',
    profileImageUrl: 'assets/images/profile_placeholder.png',
  );
});

// Personal Information menu items provider
final personalInfoMenuProvider = Provider<List<ProfileMenuItemModel>>((ref) {
  return [
    ProfileMenuItemModel(
      id: 'profile',
      title: AppStrings.myProfile,
      icon: Icons.person,
      onTap: () {
        // TODO: Navigate to profile edit
      },
    ),
    ProfileMenuItemModel(
      id: 'my_plan',
      title: AppStrings.myPlan,
      icon: Icons.account_balance_wallet,
      onTap: () {
        // TODO: Navigate to subscription plan
      },
    ),
    ProfileMenuItemModel(
      id: 'my_booking',
      title: AppStrings.myBooking,
      icon: Icons.calendar_today,
      onTap: () {
        // TODO: Navigate to booking list
      },
    ),
    ProfileMenuItemModel(
      id: 'total_saved',
      title: AppStrings.totalSaved,
      icon: Icons.bookmark,
      onTap: () {
        // TODO: Navigate to saved items
      },
    ),
    ProfileMenuItemModel(
      id: 'invite_member',
      title: AppStrings.inviteMember,
      icon: Icons.person_add,
      onTap: () {
        // TODO: Navigate to invite screen
      },
    ),
  ];
});

// Settings menu items provider
final settingsMenuProvider = Provider<List<ProfileMenuItemModel>>((ref) {
  return [
    ProfileMenuItemModel(
      id: 'change_password',
      title: AppStrings.changePassword,
      icon: Icons.lock,
      onTap: () {
        // TODO: Navigate to change password
      },
    ),
    ProfileMenuItemModel(
      id: 'language',
      title: AppStrings.language,
      icon: Icons.language,
      onTap: () {
        // TODO: Navigate to language settings
      },
    ),
    ProfileMenuItemModel(
      id: 'faq',
      title: AppStrings.faq,
      icon: Icons.help_outline,
      onTap: () {
        // TODO: Navigate to FAQ
      },
    ),
    ProfileMenuItemModel(
      id: 'about_us',
      title: AppStrings.aboutUs,
      icon: Icons.info_outline,
      onTap: () {
        // TODO: Navigate to about us
      },
    ),
    ProfileMenuItemModel(
      id: 'privacy_policy',
      title: AppStrings.privacyPolicy,
      icon: Icons.privacy_tip_outlined,
      onTap: () {
        // TODO: Navigate to privacy policy
      },
    ),
    ProfileMenuItemModel(
      id: 'terms_conditions',
      title: AppStrings.termsConditions,
      icon: Icons.description_outlined,
      onTap: () {
        // TODO: Navigate to terms and conditions
      },
    ),
    ProfileMenuItemModel(
      id: 'logout',
      title: AppStrings.logout,
      icon: Icons.logout,
      isDestructive: true,
      onTap: () {
        // TODO: Handle logout
      },
    ),
  ];
});

// Profile notifier for handling profile actions
class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState());

  void updateUserProfile(UserModel user) {
    state = state.copyWith(user: user);
  }

  void handleMenuTap(ProfileMenuItemModel menuItem) {
    menuItem.onTap();
  }

  void logout() {
    state = state.copyWith(isLoading: true);
    // TODO: Implement logout logic
    Future.delayed(const Duration(seconds: 1), () {
      state = state.copyWith(isLoading: false);
    });
  }
}

class ProfileState {
  final UserModel? user;
  final bool isLoading;

  ProfileState({
    this.user,
    this.isLoading = false,
  });

  ProfileState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Provider for profile notifier
final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
