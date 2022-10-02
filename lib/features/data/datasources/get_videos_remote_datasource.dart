import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../core/error/failure.dart';

abstract class GetVideosRemoteDataSource {
  Future<VideosResponse> getVideos();
}

class GetLatestVideosRemoteDatasourceImpl implements GetVideosRemoteDataSource {
  late final http.Client client;
  GetLatestVideosRemoteDatasourceImpl(this.client);

  @override
  Future<VideosResponse> getVideos() async {
    String part = 'snippet';
    var response = await client.get(
        Uri.parse('$baseUrl/search?channelId=$channelID&part=$part&order=date&maxResults=10&key=$apIkey'),
        headers: headers);
    if (response.statusCode.toString().startsWith("2")) {
      var videosResponse = videosResponseFromJson(response.body);
      return videosResponse;
    } else {
      throw ServerException();
    }
  }
}

class GetSearchVideosRemoteDatasourceImpl implements GetVideosRemoteDataSource {

  @override
  Future<VideosResponse> getVideos() {
    // TODO: implement getVideos
    throw UnimplementedError();
  }


}
