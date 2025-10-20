import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordEmailProvider=StateProvider.autoDispose<String>((ref)=>"");
final forgotPasswordLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);
