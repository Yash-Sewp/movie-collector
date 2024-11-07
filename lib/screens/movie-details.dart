import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies.bloc.dart';
import '../controllers/movies.controller.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String movieId;
  final String title;

  const MovieDetailsScreen(
      {Key? key, required this.movieId, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(movieId);
    return BlocProvider(
      create: (context) =>
          MovieBloc(MovieController())..add(FetchMovieDetails(movieId)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: AppBar(
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(
                  top: 30), // Adjust vertical padding as needed
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            backgroundColor: Colors.red,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: Padding(
              padding:
                  const EdgeInsets.only(top: 25.0), // Align with title padding
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsLoaded) {
              final movie = state.movie;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      movie.poster.isNotEmpty && movie.poster != 'N/A' ? movie.poster : 'https://dummyimage.com/600x400/000/fff',
                      width: double.maxFinite,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                    Text(movie.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Year: ${movie.year}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        const SizedBox(width: 40),
                        Text('Type: ${movie.type}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(movie.plot ?? 'Plot information not available',
                        style: const TextStyle(fontSize: 16)),
                    // Add more movie details here if needed
                  ],
                ),
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No details available.'));
          },
        ),
      ),
    );
  }
}
