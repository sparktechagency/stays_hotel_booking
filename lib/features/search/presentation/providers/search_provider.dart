import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/features/search/domain/models/hotel_model.dart';

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Search results provider
final searchResultsProvider = StateProvider<List<HotelModel>>((ref) => []);

// Search loading state
final searchLoadingProvider = StateProvider<bool>((ref) => false);

// Search notifier for handling search logic
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState());

  void updateQuery(String query) {
    state = state.copyWith(query: query);
  }

  void searchHotels(String query) {
    if (query.isEmpty) {
      state = state.copyWith(
        results: [],
        loading: false,
      );
      return;
    }

    state = state.copyWith(loading: true);

    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final results = _getMockHotels(query);
      state = state.copyWith(
        results: results,
        loading: false,
      );
    });
  }

  List<HotelModel> _getMockHotels(String query) {
    final allHotels = [
      HotelModel(
        id: '1',
        name: 'Hotel Blue sky',
        location: 'Palm Springs, CA',
        price: 630,
        rating: 4.9,
        imageUrl: 'assets/images/hotel1.jpg',
        description: 'Luxurious hotel with stunning views',
      ),
      HotelModel(
        id: '2',
        name: 'Luxury Hotel',
        location: 'Palm Springs, CA',
        price: 520,
        rating: 4.8,
        imageUrl: 'assets/images/hotel2.jpg',
        description: 'Premium accommodation with pool access',
      ),
      HotelModel(
        id: '3',
        name: 'Four Seasons',
        location: 'Palm Springs, CA',
        price: 460,
        rating: 4.6,
        imageUrl: 'assets/images/hotel3.jpg',
        description: 'World-class resort experience',
      ),
      HotelModel(
        id: '4',
        name: 'Peninsula Hotels',
        location: 'Palm Springs, CA',
        price: 370,
        rating: 4.7,
        imageUrl: 'assets/images/hotel4.jpg',
        description: 'Elegant dining and lounge areas',
      ),
    ];

    if (query.toLowerCase().contains('hotel') || query.toLowerCase().contains('blue')) {
      return allHotels.where((hotel) => 
        hotel.name.toLowerCase().contains(query.toLowerCase()) ||
        hotel.location.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

    return allHotels;
  }
}

class SearchState {
  final String query;
  final List<HotelModel> results;
  final bool loading;

  SearchState({
    this.query = '',
    this.results = const [],
    this.loading = false,
  });

  SearchState copyWith({
    String? query,
    List<HotelModel>? results,
    bool? loading,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      loading: loading ?? this.loading,
    );
  }
}

// Provider for search notifier
final searchNotifierProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});
