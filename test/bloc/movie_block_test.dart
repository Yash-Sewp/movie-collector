import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie_collector_app/blocs/movies.bloc.dart';
import 'package:movie_collector_app/controllers/movies.controller.dart';
import 'package:movie_collector_app/models/movies.model.dart';

// Mock class for MovieController
class MockMovieController extends Mock implements MovieController {}

void main() async {
  await dotenv.load();
  late MovieBloc movieBloc;
  late MockMovieController mockMovieController;

  // Movie instance for "The Batman"
  final theBatman = Movie(
    title: 'The Batman',
    year: '2022',
    rated: 'PG-13',
    released: '04 Mar 2022',
    runtime: '176 min',
    genre: 'Action, Crime, Drama',
    director: 'Matt Reeves',
    writer: 'Matt Reeves, Peter Craig, Bob Kane',
    actors: 'Robert Pattinson, Zoë Kravitz, Jeffrey Wright',
    plot: 'When a sadistic serial killer begins murdering key political figures in Gotham, The Batman is forced to investigate the city\'s hidden corruption and question his family\'s involvement.',
    language: 'English, Spanish, Latin, Italian',
    country: 'United States',
    awards: 'Nominated for 3 Oscars. 39 wins & 185 nominations total',
    poster: 'https://m.media-amazon.com/images/M/MV5BMmU5NGJlMzAtMGNmOC00YjJjLTgyMzUtNjAyYmE4Njg5YWMyXkEyXkFqcGc@._V1_SX300.jpg',
    ratings: [
      {'Source': 'Internet Movie Database', 'Value': '7.8/10'},
      {'Source': 'Rotten Tomatoes', 'Value': '85%'},
      {'Source': 'Metacritic', 'Value': '72/100'},
    ],
    metascore: '72',
    imdbRating: '7.8',
    imdbVotes: '828,211',
    imdbID: 'tt1877830',
    type: 'movie',
    dvd: 'N/A',
    boxOffice: '\$369,345,583',
    production: 'N/A',
    website: ''
  );

  setUp(() {
    mockMovieController = MockMovieController();
    movieBloc = MovieBloc(mockMovieController);
  });

  tearDown(() {
    movieBloc.close();
  });

  group('MovieBloc Tests', () {
    test('initial state is MovieInitial', () {
      expect(movieBloc.state, equals(MovieInitial()));
    });

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieLoaded] when SearchMovies is successful',
      build: () {
        when(() => mockMovieController.searchMovies(any())).thenAnswer((_) async => [theBatman]);
        return movieBloc;
      },
      act: (bloc) => bloc.add(SearchMovies('The Batman')),
      expect: () => [MovieLoading(), MovieLoaded([theBatman])],
      verify: (_) {
        verify(() => mockMovieController.searchMovies('The Batman')).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieError] when SearchMovies fails',
      build: () {
        when(() => mockMovieController.searchMovies(any())).thenThrow(Exception('Error occurred while fetching movies'));
        return movieBloc;
      },
      act: (bloc) => bloc.add(SearchMovies('The Batman')),
      expect: () => [MovieLoading(), MovieError('Failed to load movies: Exception: Error occurred while fetching movies')],
      verify: (_) {
        verify(() => mockMovieController.searchMovies('The Batman')).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieDetailsLoaded] when FetchMovieDetails is successful',
      build: () {
        when(() => mockMovieController.getMovieByIMDB(any())).thenAnswer((_) async => theBatman);
        return movieBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetails('tt1877830')),
      expect: () => [MovieLoading(), MovieDetailsLoaded(theBatman)],
      verify: (_) {
        verify(() => mockMovieController.getMovieByIMDB('tt1877830')).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [MovieLoading, MovieError] when FetchMovieDetails fails',
      build: () {
        when(() => mockMovieController.getMovieByIMDB(any())).thenThrow(Exception('Error occurred while fetching movie details'));
        return movieBloc;
      },
      act: (bloc) => bloc.add(FetchMovieDetails('tt1877830')),
      expect: () => [MovieLoading(), MovieError('Failed to load movie details: Exception: Error occurred while fetching movie details')],
      verify: (_) {
        verify(() => mockMovieController.getMovieByIMDB('tt1877830')).called(1);
      },
    );
  });
}
