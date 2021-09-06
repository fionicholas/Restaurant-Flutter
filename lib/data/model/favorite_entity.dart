class FavoriteEntity {
  String? id, name, description, image, city, rating;

  FavoriteEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.city,
    required this.rating,
  });

  factory FavoriteEntity.fromDatabaseJson(Map<String, dynamic> data) =>
      FavoriteEntity(
        id: data['id'] ?? 0,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        image: data['image'] ?? '',
        city: data['city'] ?? '',
        rating: data['rating'] ?? '',
      );

  Map<String, dynamic> toDatabaseJson() {
    var map = {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "image": this.image,
      "city": this.city,
      "rating": this.rating
    };

    if (map['id'] != null) map['id'] = this.id ?? '';

    return map;
  }
}
