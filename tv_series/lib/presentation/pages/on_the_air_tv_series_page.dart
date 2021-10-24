import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/on_the_air_tv_series/on_the_air_tv_series_bloc.dart';
import '../widgets/tv_series_card_list.dart';

class OnTheAirTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv/on-the-air';

  @override
  _OnTheAirTvSeriesPageState createState() => _OnTheAirTvSeriesPageState();
}

class _OnTheAirTvSeriesPageState extends State<OnTheAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvSeriesBloc>(context, listen: false)
            .add(FetchOnTheAirTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
          builder: (context, state) {
            if (state is OnTheAirTvSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.tvSeries[index];
                  return TvSeriesCard(movie);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state is OnTheAirTvSeriesError) {
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
      ),
    );
  }
}
