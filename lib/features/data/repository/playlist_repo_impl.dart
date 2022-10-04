import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';

import '../../../core/error/failure.dart';
import '../../../core/network_info.dart';
import '../../domain/repository/playlist_repository.dart';
import '../datasources/playlist_remote_datasource.dart';
import '../model/playlist_response.dart';

class PlaylistRepoImpl implements PlaylistRepository {
  final NetworkInfo networkInfo;
  PlaylistRemoteDataSource remoteDatasource;
  PlaylistRepoImpl({required this.networkInfo, required this.remoteDatasource});

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

  @override
  Future<Either<Failure, PlaylistVideoResponse>> getPlayListVideos(
      String playlistID) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePlaylistVideos =
            await remoteDatasource.getPlayListVideos(playlistID);
        return Right(remotePlaylistVideos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PlaylistResponse>> getNextPlaylist(
      String pageToken) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNextPlaylist =
            await remoteDatasource.getNextPlaylist(pageToken);
        return Right(remoteNextPlaylist);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PlaylistVideoResponse>> getNextPlayListVideos(
      {required String playlistID, required String pageToken}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNextPlaylistVideos =
            await remoteDatasource.getNextPlayListVideos(
                pageToken: pageToken, playlistID: playlistID);
        return Right(remoteNextPlaylistVideos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
