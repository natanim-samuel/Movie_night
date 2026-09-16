class Movie {
  final int id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int year;
  final int duration;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.year,
    required this.duration,
    this.isFavorite = false,
  });
}