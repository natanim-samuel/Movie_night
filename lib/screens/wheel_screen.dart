import 'dart:math';
import 'package:flutter/material.dart';
import '../data/movie_data.dart';
import '../models/movie.dart';
import 'movie_detail_screen.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen> {
  Movie? selectedMovie;
  bool isSpinning = false;

  Future<void> spinWheel() async {
    if (isSpinning) return;

    setState(() {
      isSpinning = true;
      selectedMovie = null;
    });

    await Future.delayed(const Duration(milliseconds: 1800));

    final random = Random();
    final movie = movies[random.nextInt(movies.length)];

    setState(() {
      selectedMovie = movie;
      isSpinning = false;
    });
  }

  void toggleFavorite(Movie movie) {
    setState(() {
      movie.isFavorite = !movie.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 25),

            const Text(
              'Can’t Decide? 🎡',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Let Movie Night choose for you.',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 16,
              ),
            ),

            const Spacer(),

            AnimatedRotation(
              turns: isSpinning ? 5 : 0,
              duration: const Duration(milliseconds: 1800),
              curve: Curves.easeOut,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE50914),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1C1C24),
                      border: Border.all(
                        color: Colors.white24,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isSpinning
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Icon(
                        Icons.movie_creation_outlined,
                        size: 75,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            if (selectedMovie != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailScreen(
                        movie: selectedMovie!,
                        onFavorite: () {
                          toggleFavorite(selectedMovie!);
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C24),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          selectedMovie!.imageUrl,
                          width: 70,
                          height: 95,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              width: 70,
                              height: 95,
                              color: Colors.grey.shade800,
                              child: const Icon(Icons.movie),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tonight you should watch:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              selectedMovie!.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  selectedMovie!.rating.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: spinWheel,
                icon: const Icon(Icons.casino),
                label: Text(
                  isSpinning ? 'Choosing...' : 'SPIN THE WHEEL',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50914),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}