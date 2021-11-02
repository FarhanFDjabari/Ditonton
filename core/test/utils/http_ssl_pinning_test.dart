import 'package:flutter_test/flutter_test.dart';

import '../helper/test_shared.dart';

void main() {
  group('SSL Pinning test', () {
    test('Should return status code 200 when success', () async {
      final _client = await TestShared.createLEClient();
      final response = await _client.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/on_the_air?api_key=2174d146bb9c0eab47529b2e77d6b526'));
      expect(response.statusCode, 200);
      _client.close();
    });
  });
}
