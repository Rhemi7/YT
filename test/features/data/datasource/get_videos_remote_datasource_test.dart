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
  String order = "date";
  String pageToken = "CAUQAA";

  late MockClient client;
  late GetVideosRemoteDatasourceImpl dataSource;

  var url = Uri.parse('$baseUrl/search?channelId=$channelID&part=snippet&order=date&maxResults=10&key=$apIkey');
  var nextVideosUrl = Uri.parse('$baseUrl/search?channelId=$channelID&part=snippet&order=date&maxResults=10&key=$apIkey&pageToken=$pageToken');

  setUp(() {
    client = MockClient();
    dataSource = GetVideosRemoteDatasourceImpl (client);
  });

  group('get videos', () {
    test('returns a video response if the http call completes successfully',
            () async {
          when(client.get(url, headers: headers)).thenAnswer(
                  (_) async => http.Response(dataReader('videos_response.json'), 200));

          expect(await dataSource.getVideos(order), isA<VideosResponse>());
        });

    test('throws an exception if the http call results in an error', () {
      when(client.get(url, headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getVideos(order),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('Get Next videos', () {
    test('returns next set of video response if the http call completes successfully',
            () async {
          when(client.get(nextVideosUrl, headers: headers)).thenAnswer(
                  (_) async => http.Response(dataReader('videos_response.json'), 200));

          expect(await dataSource.getNextVideos(order: order, pageToken: pageToken), isA<VideosResponse>());
        });

    test('throws an exception if the http call results in an error', () {
      when(client.get(nextVideosUrl, headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getNextVideos(order: order, pageToken: pageToken),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

}

