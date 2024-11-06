class Movie {
  final String title;
  final String year;
  final String type;
  final String poster;

  Movie({required this.title, required this.year, required this.type, required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['Title'] ?? '',
        year: json['Year'] ?? '',
        type: json['Type'] ?? '',
        poster: json['Poster'] ?? ''
    );
  }
}