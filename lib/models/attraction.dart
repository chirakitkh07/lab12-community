class Attraction {
  final int? id;
  final String name;
  final String description;
  final String history;
  final String imageUrl;
  final String location;
  final String category;
  bool isFavorite;

  Attraction({
    this.id,
    required this.name,
    required this.description,
    required this.history,
    required this.imageUrl,
    required this.location,
    required this.category,
    this.isFavorite = false,
  });

  factory Attraction.fromMap(Map<String, dynamic> map) {
    return Attraction(
      id: map['id'] as int?,
      name: map['name'] as String,
      description: map['description'] as String,
      history: map['history'] as String,
      imageUrl: map['image_url'] as String,
      location: map['location'] as String,
      category: map['category'] as String,
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
      'location': location,
      'category': category,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }
}
