import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_detail.dart';
import '../bloc/tv_series_detail/tv_series_detail_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/detail';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvSeriesDetailBloc>(context, listen: false)
          .add(FetchTvSeriesDetail(widget.id));
      Provider.of<TvSeriesDetailBloc>(context, listen: false)
          .add(LoadTvSeriesWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvSeriesDetailBloc, TvSeriesDetailState>(
        builder: (context, state) {
          if (state is TvSeriesDetailLoaded) {
            final tvShow = state.result;
            return SafeArea(
              child: DetailContent(
                tvShow,
                state.tvSeries,
                state.isAddedtoWatchlist,
              ),
            );
          } else if (state is TvSeriesDetailError) {
            return Text(state.message);
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

class DetailContent extends StatelessWidget {
  final TvSeriesDetail movie;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        BlocListener<TvSeriesDetailBloc, TvSeriesDetailState>(
          listener: (context, state) {
            if (state is TvSeriesSavedToWatchlist) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              context
                  .read<TvSeriesDetailBloc>()
                  .add(FetchTvSeriesDetail(movie.id));
            } else if (state is TvSeriesRemovedFromWatchlist) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              context
                  .read<TvSeriesDetailBloc>()
                  .add(FetchTvSeriesDetail(movie.id));
            } else if (state is TvSeriesDetailError) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                  );
                },
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.name,
                                style: kHeading5,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (!isAddedWatchlist) {
                                    Provider.of<TvSeriesDetailBloc>(context,
                                            listen: false)
                                        .add(AddTvSeriesToWatchlist(movie));
                                  } else {
                                    Provider.of<TvSeriesDetailBloc>(context,
                                            listen: false)
                                        .add(
                                            RemoveTvSeriesFromWatchlist(movie));
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              ),
                              Text(
                                _showGenres(movie.genres),
                              ),
                              Text(
                                '${movie.numberOfSeasons} season - ${movie.numberOfEpisodes} episodes',
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: movie.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${movie.voteAverage}')
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                movie.overview,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Seasons',
                                style: kHeading6,
                              ),
                              BlocBuilder<TvSeriesDetailBloc,
                                  TvSeriesDetailState>(
                                builder: (context, state) {
                                  if (state is TvSeriesDetailLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is TvSeriesDetailError) {
                                    return Text(state.message);
                                  } else if (state is TvSeriesDetailLoaded) {
                                    if (movie.seasons.isNotEmpty) {
                                      return SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final season = movie.seasons[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: Stack(
                                                  children: [
                                                    ColorFiltered(
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              kRichBlack
                                                                  .withOpacity(
                                                                      0.5),
                                                              BlendMode.darken),
                                                      child: CachedNetworkImage(
                                                        imageUrl: season
                                                                .posterPath
                                                                .isNotEmpty
                                                            ? 'https://image.tmdb.org/t/p/w500/${season.posterPath}'
                                                            : 'https://content.numetro.co.za/ui_images/no_poster.png',
                                                        placeholder:
                                                            (context, url) =>
                                                                const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 5,
                                                      left: 0,
                                                      right: 0,
                                                      child: Text(
                                                        '${season.name}\n${season.episodeCount} Episode',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: movie.seasons.length,
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        child:
                                            const Text('Season Info not found'),
                                      );
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              BlocBuilder<TvSeriesDetailBloc,
                                  TvSeriesDetailState>(
                                builder: (context, state) {
                                  if (state is TvSeriesDetailLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is TvSeriesDetailError) {
                                    return Text(state.message);
                                  } else if (state is TvSeriesDetailLoaded) {
                                    if (recommendations.isNotEmpty) {
                                      return SizedBox(
                                        height: 150,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final movie =
                                                recommendations[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                    context,
                                                    TvSeriesDetailPage
                                                        .ROUTE_NAME,
                                                    arguments: movie.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: recommendations.length,
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        child: const Text('No Recommendations'),
                                      );
                                    }
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.25,
              // maxChildSize: 1.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result = 'No Genre';
    }

    return result.substring(0, result.length - 2);
  }
}
