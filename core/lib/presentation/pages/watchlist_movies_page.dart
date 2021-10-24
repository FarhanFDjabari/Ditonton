import 'package:flutter/material.dart';
import 'package:movies/presentation/pages/movie_watchlist_tab.dart';
import 'package:tv_series/presentation/pages/tv_series_watchlist_tab.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Movies',
            ),
            Tab(
              text: 'TV Shows',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MovieWatchlistTab(),
          TvSeriesWatchlistTab(),
        ],
      ),
    );
  }
}
