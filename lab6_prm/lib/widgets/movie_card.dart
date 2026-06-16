import 'package:flutter/material.dart';
import 'package:lab6_prm/models/movie.dart';

/// A premium, responsive movie item widget.
/// Adapts its content arrangement internally depending on the card's available width.
class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x0FFFFFFF)), // ~6% opacity
      ),
      clipBehavior: Clip.antiAlias,
      color: const Color(0xFF1E293B), // Slate-800
      child: LayoutBuilder(
        builder: (context, cardConstraints) {
          // Adjust layout (Horizontal vs. Vertical) based on the card's actual width
          final bool isHorizontal = cardConstraints.maxWidth > 350;

          if (isHorizontal) {
            // Horizontal Card Layout: Poster left, Details right
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 120,
                  child: _buildPoster(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleAndYear(),
                        const SizedBox(height: 8),
                        _buildGenreTags(),
                        const Spacer(),
                        _buildRatingRow(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Vertical Card Layout: Poster top, Details bottom
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _buildPoster(),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleAndYear(),
                      const SizedBox(height: 8),
                      _buildGenreTags(),
                      const SizedBox(height: 12),
                      _buildRatingRow(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  /// Builds the network poster image with a sleek loading progress and fallbacks.
  Widget _buildPoster() {
    return Image.network(
      movie.posterUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: const Color(0xFF334155), // Slate-700
          child: const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.indigoAccent,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // High quality fallback UI when image loading fails
        return Container(
          color: const Color(0xFF334155),
          child: const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white38,
              size: 32,
            ),
          ),
        );
      },
    );
  }

  /// Title and Year widget.
  Widget _buildTitleAndYear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${movie.year}',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Genre badges row.
  Widget _buildGenreTags() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: movie.genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.indigoAccent.withAlpha(30), // ~12% opacity
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            genre,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.indigoAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Numerical and Star rating icons.
  Widget _buildRatingRow() {
    // Map rating out of 10 to a 5-star scale
    final double starRating = movie.rating / 2;
    final int fullStars = starRating.floor();
    final bool hasHalfStar = (starRating - fullStars) >= 0.25;

    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < fullStars) {
              return const Icon(Icons.star, color: Colors.amber, size: 14);
            } else if (index == fullStars && hasHalfStar) {
              return const Icon(Icons.star_half, color: Colors.amber, size: 14);
            } else {
              return const Icon(Icons.star_border, color: Colors.amber, size: 14);
            }
          }),
        ),
        const SizedBox(width: 6),
        Text(
          movie.rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
