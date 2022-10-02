import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/features/domain/repository/get_latest_videos_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/network_info.dart';
import '../datasources/get_videos_remote_datasource.dart';
import '../model/videos_response.dart';

class GetLatestVideosRepoImpl implements GetLatestVideosRepository {
  GetVideosRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;

  GetLatestVideosRepoImpl(
      {required this.networkInfo, required this.remoteDatasource});

  @override
  Future<Either<Failure, VideosResponse>> getLatestVideos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLatestVideos = await remoteDatasource.getVideos();
        return Right(remoteLatestVideos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
