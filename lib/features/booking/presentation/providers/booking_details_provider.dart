import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';

final paymentMethodProvider = StateProvider<String>((ref) => 'card');

// Booking status: 'pending' | 'check_in'
final bookingStatusProvider = StateProvider<String>((ref) => 'pending');

// Image gallery providers
final selectedImageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

final hotelImagesProvider = Provider<List<String>>((ref) {
  return [
    AppImages.hotelBooking,
    AppImages.hotelBooking2,
    AppImages.hotelBooking3,
  ];
});