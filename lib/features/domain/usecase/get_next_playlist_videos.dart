import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_data_api/features/domain/usecase/get_next_videos.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecases.dart';
import '../../data/model/playlist_videos_response.dart';
import '../repository/playlist_repository.dart';

class GetNextPlaylistVideos
    extends UseCase<PlaylistVideoResponse, NextPlaylistVideos> {
  PlaylistRepository repository;
  GetNextPlaylistVideos(this.repository);

  @override
  Future<Either<Failure, PlaylistVideoResponse>> call(
      NextPlaylistVideos params) async {
    return await repository.getNextPlayListVideos(
        pageToken: params.pageToken, playlistID: params.playlistID);
  }
}

class NextPlaylistVideos extends Equatable {
  final String pageToken;
  final String playlistID;

  const NextPlaylistVideos({required this.pageToken, required this.playlistID});

  @override
  // TODO: implement props
  List<Object?> get props => [pageToken, playlistID];
}
