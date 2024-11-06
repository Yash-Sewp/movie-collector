import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_collector_app/controllers/movies.controller.dart';
import 'package:movie_collector_app/screens/home.dart';
import 'blocs/movies.bloc.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MovieController movieController = MovieController();

    return MaterialApp(
      title: 'Movies Collector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => MovieBloc(movieController),
        child: const HomeScreen(),
      ),
    );
  }
}