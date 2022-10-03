import '../../../data/model/videos_response.dart';

abstract class GetSearchState {
  const GetSearchState();
}

class GetSearchInitial extends GetSearchState{
  const GetSearchInitial();
}

class GetSearchLoading extends GetSearchState {
  const GetSearchLoading();
}

class GetSearchLoaded extends GetSearchState {
  final List<Item>? items;
  const GetSearchLoaded(this.items);
}

class GetSearchError extends GetSearchState {
  String message;
  GetSearchError(this.message);
}