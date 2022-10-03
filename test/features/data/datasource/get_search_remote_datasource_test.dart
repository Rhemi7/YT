import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/get_search_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  late MockClient client;
  late SearchRemoteDatasourceImpl dataSource;
  String query = "Flutter";
  var url = Uri.parse("$baseUrl/search?channelId=$channelID&part=snippet&q=$query&maxResults=10&type=video&key=$apIkey");

  setUp(() {
    client = MockClient();
    dataSource = SearchRemoteDatasourceImpl(client);
  });

  group('get search', () {
    test('returns a video response of the search query if the http call completes successfully',
            () async {
          when(client.get(url, headers: headers)).thenAnswer(
                  (_) async => http.Response(dataReader('videos_response.json'), 200));

          expect(await dataSource.getSearch(query), isA<VideosResponse>());
        });

    test('throws an exception if the http call results in an error', () {
      when(client.get(url, headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getSearch(query),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

}