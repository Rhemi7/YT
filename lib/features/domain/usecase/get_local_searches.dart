import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';
import 'package:youtube_data_api/features/domain/repository/search_repository.dart';

import '../../data/model/videos_response.dart';

class GetLocalSearch extends UseCase<List<VideoItem>, NoParams> {
  SearchRepository searchRepository;
  GetLocalSearch(this.searchRepository);

  @override
  Future<Either<Failure, List<VideoItem>>> call(NoParams params) async {
    return await searchRepository.getLocalSearch();
  }

}