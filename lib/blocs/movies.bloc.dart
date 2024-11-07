import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_collector_app/controllers/movies.controller.dart';
import '../models/movies.model.dart';

/// Define the events for the MovieBloc
abstract class MovieEvent {}

class SearchMovies extends MovieEvent {
  final String query;
  SearchMovies(this.query);
}

class FetchMovieDetails extends MovieEvent {
  final String movieId;
  FetchMovieDetails(this.movieId);
}

/// Define the states for the MovieBloc
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  MovieLoaded(this.movies);
}

class MovieDetailsLoaded extends MovieState {
  final Movie movie;
  MovieDetailsLoaded(this.movie);
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}

/// Bloc for managing movie search and detail-fetching functionality
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieController controller;

  MovieBloc(this.controller) : super(MovieInitial()) {
    on<SearchMovies>(_onSearchMovies);
    on<FetchMovieDetails>(_onFetchMovieDetails);
  }

  Future<void> _onSearchMovies(SearchMovies event, Emitter<MovieState> emit) async {
    emit(MovieLoading()); // Emit loading state before the API call
    try {
      final movies = await controller.searchMovies(event.query);
      emit(MovieLoaded(movies));
    } catch (error, stackTrace) {
      print("Error occurred: $error");
      print("Stack trace: $stackTrace");
      emit(MovieError('Failed to load movies: ${error.toString()}'));
    }
  }

  Future<void> _onFetchMovieDetails(FetchMovieDetails event, Emitter<MovieState> emit) async {
    emit(MovieLoading()); // Emit loading state before the API call
    try {
      final movie = await controller.getMovieByIMDB(event.movieId);
      emit(MovieDetailsLoaded(movie));
    } catch (error, stackTrace) {
      print("Error occurred: $error");
      print("Stack trace: $stackTrace");
      emit(MovieError('Failed to load movie details: ${error.toString()}'));
    }
  }
}
