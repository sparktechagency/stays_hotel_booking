import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Holds 4-digit OTP as list of strings
final otpDigitsProvider = StateProvider.autoDispose<List<String>>(
  (ref) => List.filled(4, ''),
);


class ResendCountdownNotifier extends StateNotifier<int> {
  ResendCountdownNotifier() : super(60) {
    _startTimer();
  }

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (state <= 0) {
        t.cancel();
      } else {
        state = state - 1;
      }
    });
  }

  void resend() {
    state = 60;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final resendCountdownProvider =
    StateNotifierProvider.autoDispose<ResendCountdownNotifier, int>((ref) {
  final notifier = ResendCountdownNotifier();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});