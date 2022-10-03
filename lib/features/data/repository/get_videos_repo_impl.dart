import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/features/domain/repository/get_videos_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/network_info.dart';
import '../datasources/get_videos_remote_datasource.dart';
import '../model/videos_response.dart';

class GetVideosRepoImpl implements GetVideosRepository {
  GetVideosRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  GetVideosRepoImpl(
      {required this.networkInfo, required this.remoteDatasource});

  @override
  Future<Either<Failure, VideosResponse>> getVideos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteVideos = await remoteDatasource.getVideos();
        return Right(remoteVideos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, VideosResponse>> getNextVideos({String? order, String? pageToken}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNextVideos = await remoteDatasource.getNextVideos(order: order, pageToken: pageToken);
        return Right(remoteNextVideos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
