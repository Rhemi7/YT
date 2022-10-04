// To parse this JSON data, do
//
//     final videosResponse = videosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:youtube_data_api/features/domain/entity/video_entity.dart';

VideosResponse videosResponseFromJson(String str) =>
    VideosResponse.fromJson(json.decode(str));

String videosResponseToJson(VideosResponse data) => json.encode(data.toJson());

class VideosResponse extends VideosEntity {
  VideosResponse({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.prevPageToken,
    this.regionCode,
    this.pageInfo,
    this.items,
  });

  final String? kind;
  final String? etag;
  final String? nextPageToken;
  final String? prevPageToken;
  final String? regionCode;
  final PageInfo? pageInfo;
  final List<VideoItem>? items;

  factory VideosResponse.fromJson(Map<String, dynamic> json) => VideosResponse(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        prevPageToken: json["prevPageToken"],
        regionCode: json["regionCode"],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: List<VideoItem>.from(
            json["items"].map((x) => VideoItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "prevPageToken": prevPageToken,
        "regionCode": regionCode,
        "pageInfo": pageInfo!.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class VideoItem extends Equatable {
  VideoItem({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
  });

  final String? kind;
  final String? etag;
  final Id? id;
  final Snippet? snippet;

  factory VideoItem.fromJson(Map<String, dynamic> json) => VideoItem(
        kind: json["kind"],
        etag: json["etag"],
        id: Id.fromJson(json["id"]),
        snippet: Snippet.fromJson(json["snippet"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet!.toJson(),
      };

  @override
  List<Object?> get props => [id, etag, snippet, kind];
}

class Id extends Equatable {
  Id({
    this.kind,
    this.videoId,
  });

  final String? kind;
  final String? videoId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        kind: json["kind"],
        videoId: json["videoId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "videoId": videoId,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [kind, videoId];
}

class Snippet extends Equatable {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.liveBroadcastContent,
    this.publishTime,
  });

  final DateTime? publishedAt;
  final String? channelId;
  final String? title;
  final String? description;
  final Thumbnails? thumbnails;
  final String? channelTitle;
  final String? liveBroadcastContent;
  final DateTime? publishTime;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        liveBroadcastContent: json["liveBroadcastContent"],
        publishTime: DateTime.parse(json["publishTime"]),
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt!.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails!.toJson(),
        "channelTitle": channelTitle,
        "liveBroadcastContent": liveBroadcastContent,
        "publishTime": publishTime!.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        publishedAt,
        channelTitle,
        channelId,
        title,
        thumbnails,
        liveBroadcastContent,
        publishTime,
        description
      ];
}

class Thumbnails extends Equatable {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
  });

  final Default? thumbnailsDefault;
  final Default? medium;
  final Default? high;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault:
            json["default"] == null ? null : Default.fromJson(json["default"]),
        medium:
            json["medium"] == null ? null : Default.fromJson(json["medium"]),
        high: json["high"] == null ? null : Default.fromJson(json["high"]),
      );

  Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault!.toJson(),
        "medium": medium!.toJson(),
        "high": high!.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [medium, high, thumbnailsDefault];
}

class Default extends Equatable {
  Default({
    this.url,
    this.width,
    this.height,
  });

  final String? url;
  final int? width;
  final int? height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [url, width, height];
}

class PageInfo extends Equatable {
  PageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  final int? totalResults;
  final int? resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [totalResults, resultsPerPage];
}
