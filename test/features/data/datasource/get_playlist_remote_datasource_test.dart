import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/playlist_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';

import '../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  late MockClient client;
  late PlaylistRemoteDatasourceImpl dataSource;

  var url = Uri.parse('$baseUrl/playlists?channelId=$channelID&key=$apIkey&part=snippet,contentDetails&maxResults=10');
  setUp(() {
    client = MockClient();
    dataSource = PlaylistRemoteDatasourceImpl (client);
  });

  group('Get Playlist', () {
    test('returns a playlist response if the http call completes successfully',
            () async {
          when(client.get(url, headers: headers)).thenAnswer(
                  (_) async => http.Response(dataReader('playlist_response.json'), 200));

          expect(await dataSource.getPlaylist(), isA<PlaylistResponse>());
        });

    test('throws an exception if the http call results in an error', () {
      when(client.get(url, headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getPlaylist(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

}