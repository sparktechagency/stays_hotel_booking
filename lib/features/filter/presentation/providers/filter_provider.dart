import 'package:flutter_riverpod/flutter_riverpod.dart';

// Filter state
class FilterState {
  final String? selectedStarRating;
  final String? selectedMeal;
  final double distanceValue;
  final double minPrice;
  final double maxPrice;
  final bool isStarRatingWithout;

  FilterState({
    this.selectedStarRating,
    this.selectedMeal,
    this.distanceValue = 30.0,
    this.minPrice = 470.0,
    this.maxPrice = 3000.0,
    this.isStarRatingWithout = false,
  });

  FilterState copyWith({
    String? selectedStarRating,
    String? selectedMeal,
    double? distanceValue,
    double? minPrice,
    double? maxPrice,
    bool? isStarRatingWithout,
  }) {
    return FilterState(
      selectedStarRating: selectedStarRating ?? this.selectedStarRating,
      selectedMeal: selectedMeal ?? this.selectedMeal,
      distanceValue: distanceValue ?? this.distanceValue,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isStarRatingWithout: isStarRatingWithout ?? this.isStarRatingWithout,
    );
  }
}

// Filter notifier
class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState());

  void selectStarRating(String? rating) {
    state = state.copyWith(
      selectedStarRating: rating,
      isStarRatingWithout: false,
    );
  }

  void selectWithoutStarRating() {
    state = state.copyWith(
      selectedStarRating: null,
      isStarRatingWithout: true,
    );
  }

  void selectMeal(String? meal) {
    state = state.copyWith(selectedMeal: meal);
  }

  void updateDistance(double value) {
    state = state.copyWith(distanceValue: value);
  }

  void updateMinPrice(double value) {
    state = state.copyWith(minPrice: value);
  }

  void updateMaxPrice(double value) {
    state = state.copyWith(maxPrice: value);
  }

  void clearAllFilters() {
    state = FilterState();
  }

  void applyFilters() {
    // Apply filters logic here
    // This would typically trigger a search with the current filter values
  }
}

// Provider for filter notifier
final filterNotifierProvider = StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  return FilterNotifier();
});
