import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies.bloc.dart';
import 'movie-details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: AppBar(
          centerTitle: false,
          title: const Padding(
            padding: const EdgeInsets.only(top: 30), // Adjust vertical padding as needed
            child: Text(
              'Search Movie',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.red
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 40, 20, 40),
        child: Column(
          children: [
            // Row to align TextField and Clear Button horizontally
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Search Movies',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        context.read<MovieBloc>().add(SearchMovies(query));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Padding(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: Text('Please enter a movie title', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),
                // Clear Button visible only when there's text in the TextField
                if (controller.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: () {
                      controller.clear(); // Clear the TextField
                      context.read<MovieBloc>().add(SearchMovies('')); // Reset the search in Bloc
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    if (state.movies.isEmpty) {
                      return const Center(child: Text('No movies found.', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)));
                    }
                    return ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return ListTile(
                          leading: Image.network(
                            movie.poster.isNotEmpty && movie.poster != 'N/A' ? movie.poster : 'https://dummyimage.com/600x400/000/fff',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          title: Text(movie.title),
                          subtitle: Text('${movie.year} - ${movie.type}'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios, // Icon for the arrow
                            size: 20,
                            color: Colors.black, // You can change the color if needed
                          ),
                          onTap: () {
                            // Navigate to MovieDetailsScreen and pass the movie's ID
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(movieId: movie.imdbID, title: movie.title),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is MovieError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Please enter a search term.', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
