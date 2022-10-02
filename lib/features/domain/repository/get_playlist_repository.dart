
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../data/model/playlist_response.dart';

abstract class GetPlaylistRepository {
  Future<Either<Failure, PlaylistResponse>> getPlaylist();
}