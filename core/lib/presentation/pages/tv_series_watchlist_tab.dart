import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/provider/watchlist_tv_series_notifier.dart';
import '../../presentation/widgets/tv_series_card_list.dart';
import '../../utils/state_enum.dart';

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
        Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
            .fetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistTvSeriesNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            if (data.watchlistTvSeries.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistTvSeries[index];
                  return TvSeriesCard(movie);
                },
                itemCount: data.watchlistTvSeries.length,
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: Text('No tv shows added'),
              );
            }
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
