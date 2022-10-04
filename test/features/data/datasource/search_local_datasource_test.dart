import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_data_api/constants/const.dart';
import 'package:youtube_data_api/core/error/failure.dart';
import 'package:youtube_data_api/features/data/datasources/search_local_data_source.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../data/data_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPref;
  late SearchLocalDataSourceImpl dataSource;

  setUp(() {
    mockPref = MockSharedPreferences();
    dataSource = SearchLocalDataSourceImpl(mockPref);
  });
  final tSearchModel = [
    VideoItem(
      kind: "youtube#searchResult",
      etag: "2G7gMlrg07nltmv7XllEqjMBuyM",
      id: Id(kind: "youtube#video", videoId: "FAxe9S6trMk"),
      snippet: Snippet(
          publishedAt: DateTime.tryParse("2022-09-30T21:00:12Z"),
          channelId: "UC_x5XG1OV2P6uZZ5FSM9Ttw",
          title: "Indie Games Fund for LATAM #Shorts",
          description:
              "Watch the full version here → https://goo.gle/3fj1964 Google Play's",
          thumbnails: Thumbnails(
              thumbnailsDefault: Default(
                  url: "https://i.ytimg.com/vi/FAxe9S6trMk/default.jpg",
                  width: 120,
                  height: 90),
              high: Default(
                  url: "https://i.ytimg.com/vi/FAxe9S6trMk/default.jpg",
                  width: 120,
                  height: 90),
              medium: Default(
                  url: "https://i.ytimg.com/vi/FAxe9S6trMk/default.jpg",
                  width: 120,
                  height: 90)),
          channelTitle: "Google Developers",
          liveBroadcastContent: "none",
          publishTime: DateTime.tryParse("2022-09-30T21:00:12Z")),
    ),
    VideoItem(),
    VideoItem(),
  ];

  group('GetCache', () {
    test('Return List<VideoItem> when cache is available', () async {
      when(mockPref.getString(cachedSearchString))
          .thenReturn(dataReader('video_list.json'));

      expect(await dataSource.getCachedSearches(), isA<List<VideoItem>>());
    });

  });
}
