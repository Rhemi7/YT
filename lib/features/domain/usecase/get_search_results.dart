import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/features/domain/repository/search_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecases.dart';
import '../../data/model/videos_response.dart';

class GetSearchResults extends UseCase<VideosResponse, String> {
  SearchRepository searchRepository;
  GetSearchResults(this.searchRepository);

  @override
  Future<Either<Failure, VideosResponse>> call(String params) async {
    return await searchRepository.getSearch(params);
  }
}