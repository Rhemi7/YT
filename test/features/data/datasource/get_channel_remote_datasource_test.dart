import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/get_channel_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';

import '../../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  
  late MockClient client;
  late GetChannelRemoteDatasourceImpl dataSource;

  var url = Uri.parse("$baseUrl/channels?part=snippet,contentDetails,statistics,brandingSettings&id=$channelID&key=$apIkey");
setUp(() {
  client = MockClient();
  dataSource = GetChannelRemoteDatasourceImpl(client);
});

  group('get channel', () {
    test('returns a channel response if the http call completes successfully',
            () async {
          when(client.get(url, headers: headers)).thenAnswer(
                  (_) async => http.Response(dataReader('channel_response.json'), 200));

          expect(await dataSource.getChannel(), isA<ChannelResponse>());
        });

    test('throws an exception if the http call results in an error', () {
      when(client.get(url, headers: headers))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(() => dataSource.getChannel(),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

}

