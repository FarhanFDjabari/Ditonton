import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';

import '../../../domain/entities/tv_series.dart';
import 'on_the_air_tv_series_page.dart';
import 'popular_tv_series_page.dart';
import 'top_rated_tv_series_page.dart';
import 'tv_series_detail_page.dart';

class HomeTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  @override
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvSeriesListBloc>(context, listen: false)
        .add(FetchTvSeriesList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Ditonton TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_ROUTE);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                onTap: () => Navigator.pushNamed(
                    context, OnTheAirTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                if (state is TvSeriesListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesListLoaded) {
                  return MovieList(state.onTheAir);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                if (state is TvSeriesListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesListLoaded) {
                  return MovieList(state.popular);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTvSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                  builder: (context, state) {
                if (state is TvSeriesListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvSeriesListLoaded) {
                  return MovieList(state.topRated);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  MovieList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
