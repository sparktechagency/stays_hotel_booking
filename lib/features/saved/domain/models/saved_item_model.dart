class SavedItemModel {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String imageUrl;
  final bool isFavorite;
  final bool isSpecial;

  SavedItemModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.isFavorite = false,
    this.isSpecial = false,
  });

  factory SavedItemModel.fromJson(Map<String, dynamic> json) {
    return SavedItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      isSpecial: json['isSpecial'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'isSpecial': isSpecial,
    };
  }

  SavedItemModel copyWith({
    String? id,
    String? name,
    String? location,
    double? price,
    double? rating,
    String? imageUrl,
    bool? isFavorite,
    bool? isSpecial,
  }) {
    return SavedItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      isSpecial: isSpecial ?? this.isSpecial,
    );
  }
}
