import '../repositories/tv_series_repository.dart';

class GetWatchlistTvSeriesStatus {
  final TvSeriesRepository repository;

  GetWatchlistTvSeriesStatus(this.repository);

  Future<bool> execute(id) async {
    return repository.isAddedToWatchlist(id);
  }
}
