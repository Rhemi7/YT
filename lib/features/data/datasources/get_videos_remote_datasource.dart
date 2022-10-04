import 'package:http/http.dart' as http;
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../core/error/failure.dart';

abstract class GetVideosRemoteDataSource {
  Future<VideosResponse> getVideos(String order);
  Future<VideosResponse> getNextVideos({String? order, String? pageToken});
}

class GetVideosRemoteDatasourceImpl implements GetVideosRemoteDataSource {
  late final http.Client client;
  GetVideosRemoteDatasourceImpl(this.client);

  @override
  Future<VideosResponse> getVideos(String order) async {
    String part = 'snippet';
    var response = await client.get(
        Uri.parse('$baseUrl/search?channelId=$channelID&part=$part&order=$order&maxResults=10&key=$apIkey'),
        headers: headers);
    if (response.statusCode.toString().startsWith("2")) {
      var videosResponse = videosResponseFromJson(response.body);
      return videosResponse;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VideosResponse> getNextVideos({String? order, String? pageToken}) async {
    String part = 'snippet';
    var response = await client.get(
        Uri.parse('$baseUrl/search?channelId=$channelID&part=$part&order=$order&maxResults=10&key=$apIkey&pageToken=$pageToken'),
        headers: headers);
    if (response.statusCode.toString().startsWith("2")) {
      var videosResponse = videosResponseFromJson(response.body);
      return videosResponse;
    } else {
      throw ServerException();
    }
  }
}

