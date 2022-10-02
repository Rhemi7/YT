

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';

class GetPlaylistVideos extends UseCase<PlaylistVideoResponse, String> {
  PlaylistRepository repository;
  GetPlaylistVideos(this.repository);

  @override
  Future<Either<Failure, PlaylistVideoResponse>> call(String params) async {
    return await repository.getPlayListVideos(params);
  }
}