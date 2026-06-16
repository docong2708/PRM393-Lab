/// Movie class containing basic details of a film.
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

/// A diverse static list of sample movies.
const List<Movie> allMovies = [
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?auto=format&fit=crop&q=80&w=600',
    rating: 9.0,
  ),
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?auto=format&fit=crop&q=80&w=600',
    rating: 8.8,
  ),
  Movie(
    title: 'The Hangover',
    year: 2009,
    genres: ['Comedy'],
    posterUrl: 'https://images.unsplash.com/photo-1513790197463-e3805178d594?auto=format&fit=crop&q=80&w=600',
    rating: 7.7,
  ),
  Movie(
    title: 'The Conjuring',
    year: 2013,
    genres: ['Horror'],
    posterUrl: 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?auto=format&fit=crop&q=80&w=600',
    rating: 7.5,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&q=80&w=600',
    rating: 8.6,
  ),
  Movie(
    title: 'Parasite',
    year: 2019,
    genres: ['Drama', 'Comedy'],
    posterUrl: 'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?auto=format&fit=crop&q=80&w=600',
    rating: 8.6,
  ),
  Movie(
    title: 'A Quiet Place',
    year: 2018,
    genres: ['Horror', 'Sci-Fi'],
    posterUrl: 'https://images.unsplash.com/photo-1505635552518-3448ff116af3?auto=format&fit=crop&q=80&w=600',
    rating: 7.5,
  ),
  Movie(
    title: 'Knives Out',
    year: 2019,
    genres: ['Comedy', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1585647347483-22b66260dfff?auto=format&fit=crop&q=80&w=600',
    rating: 7.9,
  ),
];
