import 'package:http/http.dart' as http;
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';

import '../../../constants/const.dart';
import '../../../core/error/failure.dart';
import '../model/playlist_response.dart';

abstract class PlaylistRemoteDataSource {
  Future<PlaylistResponse> getPlaylist();

  Future<PlaylistResponse> getNextPlaylist(String pageToken);

  Future<PlaylistVideoResponse> getPlayListVideos(String playlistId);

  Future<PlaylistVideoResponse> getNextPlayListVideos(
      {required String playlistID, required String pageToken});
}

class PlaylistRemoteDatasourceImpl implements PlaylistRemoteDataSource {
  late final http.Client client;
  PlaylistRemoteDatasourceImpl(this.client);

  @override
  Future<PlaylistResponse> getPlaylist() async {
    String part = "snippet,contentDetails";
    var response = await client.get(
        Uri.parse(
            '$baseUrl/playlists?channelId=$channelID&key=$apIkey&part=$part&maxResults=10'),
        headers: headers);

    if (response.statusCode.toString().startsWith("2")) {
      var playlistResponse = playlistResponseFromJson(response.body);
      return playlistResponse;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PlaylistResponse> getNextPlaylist(String pageToken) async {
    String part = "snippet,contentDetails";
    var response = await client.get(
        Uri.parse(
            '$baseUrl/playlists?channelId=$channelID&key=$apIkey&part=$part&maxResults=10&pageToken=$pageToken'),
        headers: headers);

    if (response.statusCode.toString().startsWith("2")) {
      var playlistResponse = playlistResponseFromJson(response.body);
      return playlistResponse;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PlaylistVideoResponse> getPlayListVideos(String playlistID) async {
    String part = "snippet";
    var response = await client.get(
        Uri.parse(
            '$baseUrl/playlistItems?playlistId=$playlistID&key=$apIkey&part=$part'),
        headers: headers);

    if (response.statusCode.toString().startsWith("2")) {
      var playlistVideoResponse = playlistVideoResponseFromJson(response.body);
      return playlistVideoResponse;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PlaylistVideoResponse> getNextPlayListVideos(
      {required String playlistID, required String pageToken}) async {
    String part = "snippet";
    var response = await client.get(
        Uri.parse(
            '$baseUrl/playlistItems?pageToken=$pageToken&playlistId=$playlistID&key=$apIkey&part=$part'),
        headers: headers);
    if (response.statusCode.toString().startsWith("2")) {
      var playlistVideoResponse = playlistVideoResponseFromJson(response.body);
      return playlistVideoResponse;
    } else {
      throw ServerException();
    }
  }
}
