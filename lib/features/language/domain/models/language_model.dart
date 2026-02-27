class LanguageModel {
  final String id;
  final String name;
  final String flagEmoji;
  final String languageCode;
  final bool isSelected;

  LanguageModel({
    required this.id,
    required this.name,
    required this.flagEmoji,
    required this.languageCode,
    this.isSelected = false,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      flagEmoji: json['flagEmoji'] ?? '',
      languageCode: json['languageCode'] ?? '',
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'flagEmoji': flagEmoji,
      'languageCode': languageCode,
      'isSelected': isSelected,
    };
  }

  LanguageModel copyWith({
    String? id,
    String? name,
    String? flagEmoji,
    String? languageCode,
    bool? isSelected,
  }) {
    return LanguageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      languageCode: languageCode ?? this.languageCode,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
