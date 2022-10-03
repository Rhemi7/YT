import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/get_videos_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  late MockClient client;
  late GetVideosRemoteDatasourceImpl dataSource;

  var url = Uri.parse('$baseUrl/search?channelId=$channelID&part=snippet&order=date&maxResults=10&key=$apIkey');
  setUp(() {
    client = MockClient();
    dataSource = GetVideosRemoteDatasourceImpl (client);
  });

  group('get channel', () {
    test('returns a video response if the http call completes successfully',
            () async {
          when(client.get(url, headers: headers)).thenAnswer(
                  (_) async => http.Response(dataReader('videos_response.json'), 200));

          expect(await dataSource.getVideos(), isA<VideosResponse>());
        });

    test('throws an exception if the http call results in an error', () {
      when(client.get(url, headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getVideos(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

}

