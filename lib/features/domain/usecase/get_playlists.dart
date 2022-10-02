

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';
import 'package:youtube_data_api/features/domain/repository/playlist_repository.dart';

class GetPlaylist extends UseCase<PlaylistResponse, NoParams> {
  PlaylistRepository getPlaylist;
  GetPlaylist(this.getPlaylist);

  @override
  Future<Either<Failure, PlaylistResponse>> call(NoParams params) async {
    return await getPlaylist.getPlaylist();
  }

}