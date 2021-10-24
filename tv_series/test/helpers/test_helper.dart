import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

import '../../lib/data/datasources/tv_series_local_data_source.dart';
import '../../lib/data/datasources/tv_series_remote_data_source.dart';
import '../../lib/domain/repositories/tv_series_repository.dart';

@GenerateMocks([
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvSeriesLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
