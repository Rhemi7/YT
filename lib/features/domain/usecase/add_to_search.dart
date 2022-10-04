

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';

import '../../data/model/videos_response.dart';
import '../repository/search_repository.dart';

class AddToSearch extends UseCase<List<VideoItem>, List<VideoItem>> {
  SearchRepository searchRepository;
AddToSearch(this.searchRepository);
  @override
  Future<Either<Failure, List<VideoItem>>> call(List<VideoItem> params) async {
    return await searchRepository.cacheLastSearch(params);
  }
}