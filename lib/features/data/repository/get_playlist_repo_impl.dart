
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/network_info.dart';
import '../../domain/repository/get_playlist_repository.dart';
import '../datasources/get_playlist_remote_datasource.dart';
import '../model/playlist_response.dart';

class GetPlaylistRepoImpl implements GetPlaylistRepository {
  final NetworkInfo networkInfo;
  GetPlaylistRemoteDataSource  remoteDatasource;
  GetPlaylistRepoImpl({required this.networkInfo, required this.remoteDatasource});

  @override
  Future<Either<Failure, PlaylistResponse>> getPlaylist() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePlaylist = await remoteDatasource.getPlaylist();
        return Right(remotePlaylist);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}