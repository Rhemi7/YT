import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_data_api/features/data/model/playlist_videos_response.dart';

import '../../../data/data_reader.dart';

void main() {
  final testPlaylistVideoModel = PlaylistVideoResponse(
      kind: "youtube#playlistItemListResponse",
      etag: "JLBFmIcpInGbggWalPwqWLJZyVM",
      nextPageToken: "EAAaBlBUOkNBVQ",
      pageInfo: PageInfo(totalResults: 15, resultsPerPage: 5),
      items:  []);

  test("Should be a subclass of Playlist Video response", () async {
    expect(testPlaylistVideoModel, isA<PlaylistVideoResponse>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
          () async {
        final jsonString = dataReader('playlist_videos_response.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final result = PlaylistVideoResponse.fromJson(jsonMap);
        expect(result, testPlaylistVideoModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = testPlaylistVideoModel.toJson();
        // assert
        final expectedMap = {
          "kind": "youtube#playlistItemListResponse",
          "etag": "JLBFmIcpInGbggWalPwqWLJZyVM",
          "nextPageToken": "EAAaBlBUOkNBVQ",
          "items": [],
          "pageInfo": {
            "totalResults": 15,
            "resultsPerPage": 5
          }
        };
        expect(result, expectedMap);
      },
    );
  });
}