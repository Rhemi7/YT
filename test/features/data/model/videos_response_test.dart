

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

import '../../../data/data_reader.dart';

void main() {
  final testVideosModel = VideosResponse(
      kind: "youtube#searchListResponse",
      etag: "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
      regionCode: "US",
      nextPageToken: "CAUQAA",
      pageInfo: PageInfo(totalResults: 5774, resultsPerPage: 5),
      items:  []);

  test("Should be a subclass of Video response", () async {
    expect(testVideosModel, isA<VideosResponse>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
          () async {
        final jsonString = dataReader('videos_response.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final result = VideosResponse.fromJson(jsonMap);
        expect(result, testVideosModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = testVideosModel.toJson();
        // assert
        final expectedMap = {
          "kind": "youtube#searchListResponse",
          "etag": "BcN2E3k2QTV5SGz-XeH8xDq7IKY",
          "nextPageToken": "CAUQAA",
          "regionCode": "US",
          "pageInfo": {
            "totalResults": 5774,
            "resultsPerPage": 5
          },
          "items": []
        };
        expect(result, expectedMap);
      },
    );
  });
}