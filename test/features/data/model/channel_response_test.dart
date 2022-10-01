import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_data_api/features/data/model/channel_response.dart';

import '../../../data/data_reader.dart';

void main() {
  final testChannelModel = ChannelResponse(
      kind: "youtube#channelListResponse",
      etag: "unNk2YuUkMPxKv50PV_Azhpx6Ao",
      pageInfo: PageInfo(totalResults: 1, resultsPerPage: 5),
      items:  []);

  test("Should be a subclass of Channel response", () async {
    expect(testChannelModel, isA<ChannelResponse>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when fromJson is called',
      () async {
        final jsonString = dataReader('channel_response.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        final result = ChannelResponse.fromJson(jsonMap);
        expect(result, testChannelModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = testChannelModel.toJson();
        // assert
        final expectedMap = {
          "kind": "youtube#channelListResponse",
          "etag": "unNk2YuUkMPxKv50PV_Azhpx6Ao",
          "pageInfo": {
            "totalResults": 1,
            "resultsPerPage": 5
          },
          "items": []
        };
        expect(result, expectedMap);
      },
    );
  });
}
