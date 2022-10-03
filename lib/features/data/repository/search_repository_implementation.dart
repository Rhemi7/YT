import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/get_search_remote_datasource.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/search_repository.dart';
import '../../../core/network_info.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(this.remoteDatasource, this.networkInfo);

  @override
  Future<Either<Failure, VideosResponse>> getSearch(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSearch = await remoteDatasource.getSearch(query);
        return Right(remoteSearch);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}

