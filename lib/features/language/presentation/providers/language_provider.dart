import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stays_hotel_booking/core/utils/constants/app_strings.dart';
import 'package:stays_hotel_booking/features/language/domain/models/language_model.dart';

// Language state
class LanguageState {
  final List<LanguageModel> languages;
  final String selectedLanguageId;
  final bool isLoading;

  LanguageState({
    this.languages = const [],
    this.selectedLanguageId = 'english',
    this.isLoading = false,
  });

  LanguageState copyWith({
    List<LanguageModel>? languages,
    String? selectedLanguageId,
    bool? isLoading,
  }) {
    return LanguageState(
      languages: languages ?? this.languages,
      selectedLanguageId: selectedLanguageId ?? this.selectedLanguageId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// Language notifier
class LanguageNotifier extends StateNotifier<LanguageState> {
  LanguageNotifier() : super(LanguageState()) {
    _loadLanguages();
  }

  void _loadLanguages() {
    state = state.copyWith(isLoading: true);
    
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 500), () {
      final languages = _getMockLanguages();
      state = state.copyWith(
        languages: languages,
        isLoading: false,
      );
    });
  }

  List<LanguageModel> _getMockLanguages() {
    return [
      LanguageModel(
        id: 'english',
        name: AppStrings.english,
        flagEmoji: '🇬🇧',
        languageCode: 'en',
        isSelected: true,
      ),
      LanguageModel(
        id: 'french',
        name: AppStrings.french,
        flagEmoji: '🇫🇷',
        languageCode: 'fr',
        isSelected: false,
      ),
      LanguageModel(
        id: 'german',
        name: AppStrings.german,
        flagEmoji: '🇩🇪',
        languageCode: 'de',
        isSelected: false,
      ),
      LanguageModel(
        id: 'arabic',
        name: AppStrings.arabic,
        flagEmoji: '🇸🇦',
        languageCode: 'ar',
        isSelected: false,
      ),
    ];
  }

  void selectLanguage(String languageId) {
    final updatedLanguages = state.languages.map((language) {
      return language.copyWith(
        isSelected: language.id == languageId,
      );
    }).toList();
    
    state = state.copyWith(
      languages: updatedLanguages,
      selectedLanguageId: languageId,
    );
  }

  void refreshLanguages() {
    _loadLanguages();
  }
}

// Provider for language notifier
final languageNotifierProvider = StateNotifierProvider<LanguageNotifier, LanguageState>((ref) {
  return LanguageNotifier();
});
