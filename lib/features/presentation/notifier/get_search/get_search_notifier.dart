

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:youtube_data_api/core/usecases/usecases.dart';

import '../../../data/model/videos_response.dart';
import '../../../domain/usecase/add_to_search.dart';
import '../../../domain/usecase/get_local_searches.dart';
import '../../../domain/usecase/get_search_results.dart';
import 'get_search_state.dart';

class GetSearchNotifier extends StateNotifier<GetSearchState>{
  GetSearchResults getSearchResults;
  GetLocalSearch getLocalSearches;
  AddToSearch addToSearch;
  GetSearchNotifier({required this.getSearchResults, required this.getLocalSearches, required this.addToSearch}) : super(const GetSearchInitial());

  getSearch(String query) async {
    try {
      state = const GetSearchLoading();
      var result = await getSearchResults(query);
      result.fold((l) => null, (r) {
        state = GetSearchLoaded(r.items!);
      });
    } catch (e) {
      state = GetSearchError("An error occurred");
    }
  }

  getLocalSearch() async {
    try {
      state = const GetSearchLoading();
      var result = await getLocalSearches(NoParams());
      result.fold((l) => null, (r) {
        print("Get local result $r");
        state = GetSearchLoaded(r);
      });
    } catch (e) {
      state = GetSearchError("An error occurred");
    }
  }

  List<Item> _localItems = [];
  List<Item> get localItems => _localItems;



  addToLocalSearch(Item item) async {
    try {
      var result = await getLocalSearches(NoParams());
      result.fold((l) => null, (r) {
        print("Get local result 2 $r");
        _localItems = r;
        _localItems.add(item);
      });
      await addToSearch(_localItems).then((value) {
        value.fold((l) => null, (r) {
          print('new local search ${r.length}');
        });
      });
    } catch (e) {
      state = GetSearchError("error");
    }
  }
}