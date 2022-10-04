import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';

import 'package:youtube_data_api/features/data/model/channel_response.dart';

import '../../../core/error/failure.dart';

abstract class GetChannelRemoteDataSource {
  Future<ChannelResponse> getChannel();
}

class GetChannelRemoteDatasourceImpl implements GetChannelRemoteDataSource {
  late final http.Client client;
  GetChannelRemoteDatasourceImpl(this.client);

  @override
  Future<ChannelResponse> getChannel() async {
    String part = 'snippet,contentDetails,statistics,brandingSettings';
    var response = await client.get(
        Uri.parse('$baseUrl/channels?part=$part&id=$channelID&key=$apIkey'),
        headers: headers);

    if (response.statusCode.toString().startsWith("2")) {
      var channelResponse = channelResponseFromJson(response.body);
      return channelResponse;
    } else {

      print('quota error');
      throw ServerException();
    }
  }
}
