import 'package:http/http.dart' as http;

import '../../../constants/const.dart';
import '../../../core/error/failure.dart';
import '../model/playlist_response.dart';
abstract class GetPlaylistRemoteDataSource {
  Future<PlaylistResponse> getPlaylist();
}

class GetPlaylistRemoteDatasourceImpl implements GetPlaylistRemoteDataSource {
  late final http.Client client;
  GetPlaylistRemoteDatasourceImpl(this.client);

  @override
  Future<PlaylistResponse> getPlaylist() async {
    String part = "snippet,contentDetails";
    var response = await client.get(
        Uri.parse('$baseUrl/playlists?channelId=$channelID&key=$apIkey&part=$part&maxResults=10'),
        headers: headers);

    if (response.statusCode.toString().startsWith("2")) {
      var playlistResponse = playlistResponseFromJson(response.body);
      return playlistResponse;
    } else {
      throw ServerException();
    }
  }
}
