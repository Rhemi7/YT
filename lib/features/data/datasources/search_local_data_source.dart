import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_data_api/constants/const.dart';

import '../../../core/error/failure.dart';
import '../model/videos_response.dart';

abstract class SearchLocalDataSource {
  Future<List<VideoItem>> getCachedSearches();

  Future<void> cacheLastSearch(List<VideoItem> searches);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  SearchLocalDataSourceImpl(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<List<VideoItem>> getCachedSearches() {
    try {
      final jsonString = sharedPreferences.getString(cachedSearchString);
      if (jsonString != null) {
        final parsed = json.decode(jsonString);
        return Future.value(
            parsed.map<VideoItem>((json) => VideoItem.fromJson(json)).toList());
      } else {
        return Future.value([]);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheLastSearch(List<VideoItem> searches) {
    return sharedPreferences.setString(
      cachedSearchString,
      json.encode(List<dynamic>.from(searches.map((x) => x.toJson()))),
    );
  }
}
