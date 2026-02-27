import 'package:flutter_riverpod/flutter_riverpod.dart';

// Invite member state
class InviteMemberState {
  final String email;
  final String inviteLink;
  final bool isLoading;
  final bool isEmailSent;
  final String? error;

  InviteMemberState({
    this.email = '',
    this.inviteLink = 'https://stays.com/invite/a3f8b.....',
    this.isLoading = false,
    this.isEmailSent = false,
    this.error,
  });

  InviteMemberState copyWith({
    String? email,
    String? inviteLink,
    bool? isLoading,
    bool? isEmailSent,
    String? error,
  }) {
    return InviteMemberState(
      email: email ?? this.email,
      inviteLink: inviteLink ?? this.inviteLink,
      isLoading: isLoading ?? this.isLoading,
      isEmailSent: isEmailSent ?? this.isEmailSent,
      error: error ?? this.error,
    );
  }
}

// Invite member notifier
class InviteMemberNotifier extends StateNotifier<InviteMemberState> {
  InviteMemberNotifier() : super(InviteMemberState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void sendEmailInvite() {
    if (state.email.isEmpty) {
      state = state.copyWith(error: 'Please enter an email address');
      return;
    }

    if (!_isValidEmail(state.email)) {
      state = state.copyWith(error: 'Please enter a valid email address');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(
        isLoading: false,
        isEmailSent: true,
        error: null,
      );
    });
  }

  void copyInviteLink() {
    // Simulate copying to clipboard
    // In a real app, you would use Clipboard.setData()
    state = state.copyWith(error: 'Link copied to clipboard!');
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetEmailSent() {
    state = state.copyWith(isEmailSent: false);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

// Provider for invite member notifier
final inviteMemberNotifierProvider = StateNotifierProvider<InviteMemberNotifier, InviteMemberState>((ref) {
  return InviteMemberNotifier();
});
