import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/state_enum.dart';
import '../provider/watchlist_movie_notifier.dart';
import '../widgets/movie_card_list.dart';

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
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistMovieNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            if (data.watchlistMovies.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const Text('No movies added'),
              );
            }
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
