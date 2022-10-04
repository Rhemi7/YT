import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/get_search_remote_datasource.dart';
import 'package:youtube_data_api/features/data/datasources/search_local_data_source.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';
import 'package:youtube_data_api/features/domain/repository/search_repository.dart';
import '../../../core/network_info.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRemoteDatasource remoteDatasource;
  SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl(this.remoteDatasource, this.networkInfo, this.localDataSource);

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

  @override
  Future<Either<Failure, List<Item>>> cacheLastSearch(List<Item> searches) async  {
    try {
      await localDataSource.cacheLastSearch(searches);
      return Right(searches);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getLocalSearch() async {
    try {
      final local = await localDataSource.getCachedSearches();
      return Right(local);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

