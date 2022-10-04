

import 'package:dartz/dartz.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';

import '../../data/model/videos_response.dart';
import '../repository/search_repository.dart';

class AddToSearch extends UseCase<List<Item>, List<Item>> {
  SearchRepository searchRepository;
AddToSearch(this.searchRepository);
  @override
  Future<Either<Failure, List<Item>>> call(List<Item> params) async {
    return await searchRepository.cacheLastSearch(params);
  }
}