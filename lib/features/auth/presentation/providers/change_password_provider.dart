import 'package:flutter_riverpod/flutter_riverpod.dart';

// Change password state
class ChangePasswordState {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isCurrentPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  ChangePasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isCurrentPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  ChangePasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isCurrentPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ChangePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isCurrentPasswordVisible: isCurrentPasswordVisible ?? this.isCurrentPasswordVisible,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

// Change password notifier
class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  ChangePasswordNotifier() : super(ChangePasswordState());

  void updateCurrentPassword(String password) {
    state = state.copyWith(currentPassword: password);
  }

  void updateNewPassword(String password) {
    state = state.copyWith(newPassword: password);
  }

  void updateConfirmPassword(String password) {
    state = state.copyWith(confirmPassword: password);
  }

  void toggleCurrentPasswordVisibility() {
    state = state.copyWith(
      isCurrentPasswordVisible: !state.isCurrentPasswordVisible,
    );
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(
      isNewPasswordVisible: !state.isNewPasswordVisible,
    );
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void changePassword() {
    if (state.currentPassword.isEmpty) {
      state = state.copyWith(error: 'Please enter your current password');
      return;
    }

    if (state.newPassword.isEmpty) {
      state = state.copyWith(error: 'Please enter a new password');
      return;
    }

    if (state.newPassword.length < 8) {
      state = state.copyWith(error: 'New password must be at least 8 characters');
      return;
    }

    if (state.confirmPassword.isEmpty) {
      state = state.copyWith(error: 'Please confirm your new password');
      return;
    }

    if (state.newPassword != state.confirmPassword) {
      state = state.copyWith(error: 'New passwords do not match');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        error: null,
      );
    });
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetForm() {
    state = ChangePasswordState();
  }
}

// Provider for change password notifier
final changePasswordNotifierProvider = StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  return ChangePasswordNotifier();
});
