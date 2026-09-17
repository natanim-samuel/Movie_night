import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final VoidCallback onFavorite;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.onFavorite,
  });

  @override
  State<MovieDetailScreen> createState() =>
      _MovieDetailScreenState();
}

class _MovieDetailScreenState
    extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 420,
            pinned: true,
            backgroundColor: const Color(0xFF0F0F14),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    movie.isFavorite = !movie.isFavorite;
                  });

                  widget.onFavorite();
                },
                icon: Icon(
                  movie.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: movie.isFavorite
                      ? Colors.red
                      : Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: const Color(0xFF25252D),
                        child: const Icon(
                          Icons.movie,
                          size: 80,
                        ),
                      );
                    },
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                40,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      _InfoItem(
                        icon: Icons.calendar_today,
                        text: movie.year.toString(),
                      ),
                      const SizedBox(width: 20),
                      _InfoItem(
                        icon: Icons.access_time,
                        text: '${movie.duration} min',
                      ),
                      const SizedBox(width: 20),
                      _InfoItem(
                        icon: Icons.category,
                        text: movie.category,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          '${movie.rating} / 10',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'About the movie',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    movie.description,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          movie.isFavorite = !movie.isFavorite;
                        });

                        widget.onFavorite();
                      },
                      icon: Icon(
                        movie.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        movie.isFavorite
                            ? 'Remove from Favorites'
                            : 'Add to Favorites',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFFE50914),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}