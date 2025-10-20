import 'package:flutter_riverpod/flutter_riverpod.dart';

final newPasswordObscureProvider = StateProvider.autoDispose<bool>((ref) => true);
final confirmPasswordObscureProvider = StateProvider.autoDispose<bool>((ref) => true);
final createNewPasswordLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);