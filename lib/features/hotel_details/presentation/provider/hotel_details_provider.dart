import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_images.dart';

// Date providers
final checkInDateProvider = StateProvider.autoDispose<String>((ref) => '');
final checkOutDateProvider = StateProvider.autoDispose<String>((ref) => '');
final reserveLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

// Image gallery providers
final selectedImageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

final hotelImagesProvider = Provider<List<String>>((ref) {
  return [
    AppImages.hotelBooking,
    AppImages.hotelBooking2,
    AppImages.hotelBooking3, 
 
  ];
});