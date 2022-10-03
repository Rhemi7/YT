
import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';
import '../../../core/error/failure.dart';
import '../../data/model/playlist_response.dart';

abstract class PlaylistRepository {
  Future<Either<Failure, PlaylistResponse>> getPlaylist();
  Future<Either<Failure, PlaylistResponse>> getNextPlaylist(String pageToken);
  Future<Either<Failure, PlaylistVideoResponse>> getPlayListVideos(String playlistID);
}