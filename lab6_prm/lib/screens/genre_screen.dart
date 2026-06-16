import 'package:flutter/material.dart';
import 'package:lab6_prm/models/movie.dart';
import 'package:lab6_prm/widgets/movie_card.dart';

// Predefined list of genres for filtering
const List<String> predefinedGenres = ['Action', 'Drama', 'Comedy', 'Sci-Fi', 'Horror'];

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // State variables
  String searchQuery = "";
  final Set<String> selectedGenres = {};
  String selectedSort = "A-Z";

  // Controller for the Search Bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filtering & Sorting computed inside build() method
    final List<Movie> visibleMovies = allMovies.where((movie) {
      // Check search match (case-insensitive)
      final bool matchesSearch =
          movie.title.toLowerCase().contains(searchQuery.toLowerCase());

      // Check genre match (if at least one selected genre matches the movie's genres)
      final bool matchesGenre = selectedGenres.isEmpty ||
          movie.genres.any((genre) => selectedGenres.contains(genre));

      return matchesSearch && matchesGenre;
    }).toList();

    // 2. Apply chosen sorting option
    if (selectedSort == "A-Z") {
      visibleMovies.sort((a, b) => a.title.compareTo(b.title));
    } else if (selectedSort == "Z-A") {
      visibleMovies.sort((a, b) => b.title.compareTo(a.title));
    } else if (selectedSort == "Year") {
      visibleMovies.sort((a, b) => b.year.compareTo(a.year)); // Newer first
    } else if (selectedSort == "Rating") {
      visibleMovies.sort((a, b) => b.rating.compareTo(a.rating)); // Highest first
    }

    final bool isFilterActive = selectedGenres.isNotEmpty || searchQuery.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // UI COMPONENTS
              // ==========================================

              // Header Block
              const Text(
                'Find a Movie',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Search and filter by your favorite genres',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x80FFFFFF), // 50% opacity
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x14FFFFFF)), // 8% opacity
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.white54),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white54),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                searchQuery = "";
                              });
                            },
                          )
                        : null,
                    hintText: 'Search by title...',
                    hintStyle: const TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Genre Chips Title Row (Includes Badge & Clear Filter Action)
              Row(
                children: [
                  const Text(
                    "Genres",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Badge showing count of selected genres
                  if (selectedGenres.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${selectedGenres.length}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                  const Spacer(),
                  // Clear Filters Trigger
                  if (isFilterActive)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedGenres.clear();
                          searchQuery = "";
                          _searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.clear_all, size: 16, color: Colors.amberAccent),
                      label: const Text(
                        "Clear filters",
                        style: TextStyle(color: Colors.amberAccent, fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Genre Selection Wrap with Custom Animated Chips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: predefinedGenres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedGenres.remove(genre);
                        } else {
                          selectedGenres.add(genre);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.indigoAccent
                            : Colors.indigoAccent.withAlpha(15), // ~6% opacity
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? Colors.indigoAccent
                              : Colors.indigoAccent.withAlpha(51), // ~20% opacity
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.indigoAccent.withAlpha(76), // ~30% opacity
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            const Icon(Icons.check, size: 14, color: Colors.white),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            genre,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Sort Section & Control Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${visibleMovies.length} movies found',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0x14FFFFFF)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedSort,
                        dropdownColor: const Color(0xFF1E293B),
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        items: <String>['A-Z', 'Z-A', 'Year', 'Rating'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text('Sort: $value'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedSort = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // ==========================================
              // RESPONSIVE MOVIE LIST OR GRID
              // ==========================================
              Expanded(
                child: visibleMovies.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 64,
                              color: const Color(0x26FFFFFF), // ~15% opacity
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No movies found",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Try resetting your search query or filters.",
                              style: TextStyle(
                                color: Color(0x59FFFFFF), // ~35% opacity
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          // Breakpoint at 800px as per requirements
                          final bool isTabletWeb = constraints.maxWidth >= 800;

                          if (isTabletWeb) {
                            // Grid view for Tablet / Web Layout (crossAxisCount: 2)
                            return GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              // Calculate dynamic aspect ratio based on card width
                              childAspectRatio: constraints.maxWidth > 1000 ? 2.4 : 1.9,
                              children: visibleMovies.map((movie) {
                                return MovieCard(movie: movie);
                              }).toList(),
                            );
                          } else {
                            // Single column vertical list for Phone Layout (< 800px)
                            return ListView.builder(
                              itemCount: visibleMovies.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: MovieCard(movie: visibleMovies[index]),
                                );
                              },
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
