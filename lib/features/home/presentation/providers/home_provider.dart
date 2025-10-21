import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final homeCheckInDateProvider = StateProvider.autoDispose<String>((ref) => '');
final homeCheckOutDateProvider = StateProvider.autoDispose<String>((ref) => '');
final homeGuestsProvider = StateProvider.autoDispose<String>((ref) => '');