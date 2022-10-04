import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';

import '../../../../core/error/failure.dart';
import '../../../data/model/videos_response.dart';
import '../../../domain/usecase/add_to_search.dart';
import '../../../domain/usecase/get_local_searches.dart';
import '../../../domain/usecase/get_search_results.dart';
import 'get_search_state.dart';

class GetSearchNotifier extends StateNotifier<GetSearchState> {
  GetSearchResults getSearchResults;
  GetLocalSearch getLocalSearches;
  AddToSearch addToSearch;
  GetSearchNotifier(
      {required this.getSearchResults,
      required this.getLocalSearches,
      required this.addToSearch})
      : super(const GetSearchInitial());

  getSearch(String query) async {
    state = const GetSearchLoading();
    var result = await getSearchResults(query);
    result.fold((failure) {
      state = GetSearchError(mapFailureToMessage(failure));
    }, (r) {
      state = GetSearchLoaded(r.items!);
    });
  }

  getLocalSearch() async {
    state = const GetSearchLoading();
    var result = await getLocalSearches(NoParams());
    result.fold((failure) {
      state = GetSearchError(mapFailureToMessage(failure));
    }, (r) {
      state = GetSearchLoaded(r);
    });
  }

  List<VideoItem> _localItems = [];
  List<VideoItem> get localItems => _localItems;

  addToLocalSearch(VideoItem item) async {
    var result = await getLocalSearches(NoParams());
    result.fold((failure) {
      state = GetSearchError(mapFailureToMessage(failure));
    }, (r) {
      _localItems = r;
      _localItems.add(item);
    });
    await addToSearch(_localItems).then((value) {
      value.fold((l) => null, (r) {});
    });
  }
}
