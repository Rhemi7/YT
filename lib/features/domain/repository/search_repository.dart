import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../core/error/failure.dart';

abstract class SearchRepository {
  Future<Either<Failure, VideosResponse>> getSearch(String query);

  Future<Either<Failure, List<VideoItem>>> getLocalSearch();

  Future<Either<Failure, List<VideoItem>>> cacheLastSearch(
      List<VideoItem> searches);
}
