import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInPasswordObscureProvider = StateProvider.autoDispose<bool>((ref) => true);
final signInRememberMeProvider = StateProvider.autoDispose<bool>((ref) => false);
