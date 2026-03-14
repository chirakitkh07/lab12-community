class OtopProduct {
  final int? id;
  final String name;
  final String description;
  final String history;
  final String imageUrl;
  final String district;
  final String price;
  bool isFavorite;

  OtopProduct({
    this.id,
    required this.name,
    required this.description,
    required this.history,
    required this.imageUrl,
    required this.district,
    required this.price,
    this.isFavorite = false,
  });

  factory OtopProduct.fromMap(Map<String, dynamic> map) {
    return OtopProduct(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String,
      history: map['history'] as String,
      imageUrl: map['image_url'] as String,
      district: map['district'] as String,
      price: map['price'] as String,
      isFavorite: (map['is_favorite'] as int?) == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'history': history,
      'image_url': imageUrl,
      'district': district,
      'price': price,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }
}
