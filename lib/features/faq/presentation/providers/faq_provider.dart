import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/faq/domain/models/faq_model.dart';

// FAQ state
class FaqState {
  final List<FaqModel> faqItems;
  final bool isLoading;

  FaqState({
    this.faqItems = const [],
    this.isLoading = false,
  });

  FaqState copyWith({
    List<FaqModel>? faqItems,
    bool? isLoading,
  }) {
    return FaqState(
      faqItems: faqItems ?? this.faqItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// FAQ notifier
class FaqNotifier extends StateNotifier<FaqState> {
  FaqNotifier() : super(FaqState()) {
    _loadFaqItems();
  }

  void _loadFaqItems() {
    state = state.copyWith(isLoading: true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      final faqItems = _getMockFaqItems();
      state = state.copyWith(
        faqItems: faqItems,
        isLoading: false,
      );
    });
  }

  List<FaqModel> _getMockFaqItems() {
    return [
      FaqModel(
        id: '1',
        question: AppStrings.howToMakeReservation,
        answer: 'To make a reservation, search for your destination, select your dates, choose your room, and complete the booking process.',
        isExpanded: false,
      ),
      FaqModel(
        id: '2',
        question: AppStrings.canModifyBooking,
        answer: AppStrings.bookingModificationAnswer,
        isExpanded: true, // This one is expanded by default as shown in screenshot
      ),
      FaqModel(
        id: '3',
        question: AppStrings.whatPaymentMethods,
        answer: 'We accept all major credit cards, debit cards, PayPal, and digital wallets for your convenience.',
        isExpanded: false,
      ),
      FaqModel(
        id: '4',
        question: AppStrings.isPaymentSecure,
        answer: 'Yes, we use industry-standard SSL encryption and secure payment processing to protect your information.',
        isExpanded: false,
      ),
    ];
  }

  void toggleFaqItem(String faqId) {
    final updatedItems = state.faqItems.map((item) {
      if (item.id == faqId) {
        return item.copyWith(isExpanded: !item.isExpanded);
      }
      return item;
    }).toList();
    
    state = state.copyWith(faqItems: updatedItems);
  }

  void refreshFaqItems() {
    _loadFaqItems();
  }
}

// Provider for FAQ notifier
final faqNotifierProvider = StateNotifierProvider<FaqNotifier, FaqState>((ref) {
  return FaqNotifier();
});
