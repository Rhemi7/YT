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
    // https://youtube.googleapis.com/youtube/v3/search?channelId=UC_x5XG1OV2P6uZZ5FSM9Ttw&part=snippet&order=date&key=AIzaSyAQGm4bbEjrHps6X2IdLuWNHU6e_kdfw18
    String part = 'snippet';
    var response = await client.get(
        Uri.parse('$baseUrl/search?channelId=$channelID&part=$part&order=date&maxResults=10&key=$apIkey'),
      // Uri.parse("https://youtube.googleapis.com/youtube/v3/search?channelId=UC_x5XG1OV2P6uZZ5FSM9Ttw&part=snippet&order=date&key=AIzaSyAQGm4bbEjrHps6X2IdLuWNHU6e_kdfw18"),
        headers: headers);
print(response.statusCode);
    if (response.statusCode.toString().startsWith("2")) {
      var videosResponse = videosResponseFromJson(response.body);
      print('video res $videosResponse');
      return videosResponse;
    } else {
      print("remote error");
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
