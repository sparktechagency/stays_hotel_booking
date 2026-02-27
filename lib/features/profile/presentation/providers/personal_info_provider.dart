import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/features/profile/domain/models/user_model.dart';

// Personal information state
class PersonalInfoState {
  final UserModel user;
  final bool isLoading;
  final bool isEditing;
  final String fullName;
  final String email;
  final String address;
  final String about;

  PersonalInfoState({
    required this.user,
    this.isLoading = false,
    this.isEditing = false,
    required this.fullName,
    required this.email,
    required this.address,
    required this.about,
  });

  PersonalInfoState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? isEditing,
    String? fullName,
    String? email,
    String? address,
    String? about,
  }) {
    return PersonalInfoState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isEditing: isEditing ?? this.isEditing,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      about: about ?? this.about,
    );
  }
}

// Personal information notifier
class PersonalInfoNotifier extends StateNotifier<PersonalInfoState> {
  PersonalInfoNotifier() : super(
    PersonalInfoState(
      user: UserModel(
        id: '1',
        name: 'Liam Johnson',
        email: 'liamjohnson@gmail.com',
        profileImageUrl: 'assets/images/profile_placeholder.png',
      ),
      fullName: 'Liam Johnson',
      email: 'liam@gmail.com',
      address: '297 Westheimer Rd. Santa Ana',
      about: "Hello there! I'm Liam, traveler with a passion for discovering hidden gems and authentic local experiences. Equally at home on business trips, always seeking comfortable stays and unique hotel offerings that create memorable journeys.",
    ),
  );

  void updateFullName(String name) {
    state = state.copyWith(fullName: name);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateAddress(String address) {
    state = state.copyWith(address: address);
  }

  void updateAbout(String about) {
    state = state.copyWith(about: about);
  }

  void toggleEditing() {
    state = state.copyWith(isEditing: !state.isEditing);
  }

  void saveProfile() {
    state = state.copyWith(isLoading: true);
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      final updatedUser = UserModel(
        id: state.user.id,
        name: state.fullName,
        email: state.email,
        profileImageUrl: state.user.profileImageUrl,
      );
      
      state = state.copyWith(
        user: updatedUser,
        isLoading: false,
        isEditing: false,
      );
    });
  }

  void cancelEditing() {
    state = state.copyWith(
      isEditing: false,
      fullName: state.user.name,
      email: state.user.email,
    );
  }
}

// Provider for personal information notifier
final personalInfoNotifierProvider = StateNotifierProvider<PersonalInfoNotifier, PersonalInfoState>((ref) {
  return PersonalInfoNotifier();
});
