

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/usecase/get_search_results.dart';
import 'get_search_state.dart';

class GetSearchNotifier extends StateNotifier<GetSearchState>{
  GetSearchResults getSearchResults;
  GetSearchNotifier({required this.getSearchResults}) : super(const GetSearchInitial());

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
}