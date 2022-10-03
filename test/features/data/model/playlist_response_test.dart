import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';

import '../../../data/data_reader.dart';

void main() {
  final testPlaylistModel = PlaylistResponse(
      kind: "youtube#playlistListResponse",
      etag: "uzCxNou-1Q58M0GBb3IQGvzET1E",
      nextPageToken: "CBkQAA",
      prevPageToken: "CDHSTE",
      pageInfo: PageInfo(totalResults: 164, resultsPerPage: 25),
      items:  []);

  test("Should be a subclass of Playlist response", () async {
    expect(testPlaylistModel, isA<PlaylistResponse>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
          () async {
        final jsonString = dataReader('playlist_response.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final result = PlaylistResponse.fromJson(jsonMap);
        expect(result, testPlaylistModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = testPlaylistModel.toJson();
        // assert
        final expectedMap = {
          "kind": "youtube#playlistListResponse",
          "etag": "uzCxNou-1Q58M0GBb3IQGvzET1E",
          "nextPageToken": "CBkQAA",
          "prevPageToken": "CDHSTE",
          "pageInfo": {
            "totalResults": 164,
            "resultsPerPage": 25
          },
          "items": []
        };
        expect(result, expectedMap);
      },
    );
  });
}