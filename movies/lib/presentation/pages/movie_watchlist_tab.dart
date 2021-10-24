import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class MovieWatchlistTab extends StatefulWidget {
  const MovieWatchlistTab({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieWatchlistTab> createState() => _MovieWatchlistTabState();
}

class _MovieWatchlistTabState extends State<MovieWatchlistTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMoviesBloc>(context, listen: false)
            .add(FetchWatchlistMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
        builder: (context, state) {
          if (state is WatchlistMoviesLoaded) {
            if (state.movies.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const Text('No movies added'),
              );
            }
          } else if (state is WatchlistMoviesError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
