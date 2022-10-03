import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecases.dart';
import '../../data/model/playlist_response.dart';
import '../repository/playlist_repository.dart';

class GetNextPlaylist extends UseCase<PlaylistResponse, String> {
  PlaylistRepository playlistRepository;
  GetNextPlaylist(this.playlistRepository);

  @override
  Future<Either<Failure, PlaylistResponse>> call(String params) async {
    return await playlistRepository.getNextPlaylist(params);
  }
}
