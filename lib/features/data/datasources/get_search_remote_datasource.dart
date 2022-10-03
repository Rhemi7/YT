
import 'package:http/http.dart' as http;
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../constants/const.dart';
import '../../../core/error/failure.dart';

abstract class SearchRemoteDatasource {

  Future<VideosResponse> getSearch(String query);
}

class SearchRemoteDatasourceImpl extends SearchRemoteDatasource {
  late final http.Client client;
  SearchRemoteDatasourceImpl(this.client);


  @override
  Future<VideosResponse> getSearch(String query) async {
      String part = 'snippet';
      var response = await client.get(
          Uri.parse('$baseUrl/search?channelId=$channelID&part=$part&q=$query&maxResults=10&type=video&key=$apIkey'),
          headers: headers);
      if (response.statusCode.toString().startsWith("2")) {
        var videosResponse = videosResponseFromJson(response.body);
        return videosResponse;
      } else {
        throw ServerException();
      }

  }


}