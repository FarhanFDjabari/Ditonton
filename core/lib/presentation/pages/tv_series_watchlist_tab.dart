import 'package:core/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../presentation/widgets/tv_series_card_list.dart';

class TvSeriesWatchlistTab extends StatefulWidget {
  const TvSeriesWatchlistTab({
    Key? key,
  }) : super(key: key);

  @override
  State<TvSeriesWatchlistTab> createState() => _TvSeriesWatchlistTabState();
}

class _TvSeriesWatchlistTabState extends State<TvSeriesWatchlistTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvSeriesBloc>(context, listen: false)
            .add(FetchWatchlistTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTvSeriesLoaded) {
            if (state.tvSeries.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.tvSeries[index];
                  return TvSeriesCard(movie);
                },
                itemCount: state.tvSeries.length,
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: const Text('No tv shows added'),
              );
            }
          } else if (state is WatchlistTvSeriesError) {
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
