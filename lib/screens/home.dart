import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/movies.bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TextController to manage TextField state
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Search Movie',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.red,
          iconTheme: const IconThemeData(color: Colors.white),
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
                        // Display a Snackbar if the query is empty
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
                            width: 100,  // Set a fixed width
                            height: 150,  // You can also set a fixed height if needed
                            fit: BoxFit.cover,  // Ensures the image covers the space without distorting it
                          ),
                          title: Text(movie.title),
                          subtitle: Text('${movie.year} - ${movie.type}'),
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
