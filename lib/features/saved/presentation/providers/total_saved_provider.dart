import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/features/saved/domain/models/saved_item_model.dart';

// Total saved state
class TotalSavedState {
  final List<SavedItemModel> savedItems;
  final bool isLoading;
  final String? error;

  TotalSavedState({
    this.savedItems = const [],
    this.isLoading = false,
    this.error,
  });

  TotalSavedState copyWith({
    List<SavedItemModel>? savedItems,
    bool? isLoading,
    String? error,
  }) {
    return TotalSavedState(
      savedItems: savedItems ?? this.savedItems,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Total saved notifier
class TotalSavedNotifier extends StateNotifier<TotalSavedState> {
  TotalSavedNotifier() : super(TotalSavedState()) {
    _loadSavedItems();
  }

  void _loadSavedItems() {
    state = state.copyWith(isLoading: true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      final savedItems = _getMockSavedItems();
      state = state.copyWith(
        savedItems: savedItems,
        isLoading: false,
      );
    });
  }

  List<SavedItemModel> _getMockSavedItems() {
    return [
      SavedItemModel(
        id: '1',
        name: 'Mystic Palms',
        location: 'Palm Springs, CA',
        price: 230,
        rating: 4.7,
        imageUrl: 'assets/images/hotel_two.jpeg',
        isFavorite: true,
        isSpecial: true,
      ),
      SavedItemModel(
        id: '2',
        name: 'Mystic Palms',
        location: 'Palm Springs, CA',
        price: 230,
        rating: 4.8,
        imageUrl: 'assets/images/hotel_three.jpeg',
        isFavorite: true,
        isSpecial: true,
      ),
   ];
  }

  void toggleFavorite(String itemId) {
    final updatedItems = state.savedItems.map((item) {
      if (item.id == itemId) {
        return item.copyWith(isFavorite: !item.isFavorite);
      }
      return item;
    }).toList();
    
    state = state.copyWith(savedItems: updatedItems);
  }

  void removeSavedItem(String itemId) {
    final updatedItems = state.savedItems.where((item) => item.id != itemId).toList();
    state = state.copyWith(savedItems: updatedItems);
  }

  void refreshSavedItems() {
    _loadSavedItems();
  }
}

// Provider for total saved notifier
final totalSavedNotifierProvider = StateNotifierProvider<TotalSavedNotifier, TotalSavedState>((ref) {
  return TotalSavedNotifier();
});
