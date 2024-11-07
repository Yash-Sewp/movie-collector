class Movie {
  final String imdbID;
  final String title;
  final String year;
  final String type;
  final String poster;
  final String plot;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String language;
  final String country;
  final String awards;
  final List<Map<String, String>> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;

  Movie({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.type,
    required this.poster,
    required this.plot,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.language,
    required this.country,
    required this.awards,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<Map<String, String>> parseRatings(dynamic ratingsJson) {
      if (ratingsJson is List) {
        return ratingsJson
            .where((rating) => rating is Map<String, dynamic>)
            .map((rating) => {
          "Source": rating['Source']?.toString() ?? '',
          "Value": rating['Value']?.toString() ?? '',
        })
            .toList();
      } else {
        return [];
      }
    }

    return Movie(
      imdbID: json['imdbID'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      type: json['Type'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      rated: json['Rated'] ?? '',
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
      genre: json['Genre'] ?? '',
      director: json['Director'] ?? '',
      writer: json['Writer'] ?? '',
      actors: json['Actors'] ?? '',
      language: json['Language'] ?? '',
      country: json['Country'] ?? '',
      awards: json['Awards'] ?? '',
      ratings: parseRatings(json['Ratings']),
      metascore: json['Metascore'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      imdbVotes: json['imdbVotes'] ?? '',
      dvd: json['DVD'] ?? '',
      boxOffice: json['BoxOffice'] ?? '',
      production: json['Production'] ?? '',
      website: json['Website'] ?? ''
    );
  }
}
