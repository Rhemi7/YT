// To parse this JSON data, do
//
//     final playlistResponse = playlistResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:youtube_data_api/features/domain/entity/playlist_entity.dart';

PlaylistResponse playlistResponseFromJson(String str) =>
    PlaylistResponse.fromJson(json.decode(str));

String playlistResponseToJson(PlaylistResponse data) =>
    json.encode(data.toJson());

class PlaylistResponse extends PlaylistEntity {
  PlaylistResponse({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.prevPageToken,
    this.pageInfo,
    this.items,
  });

  final String? kind;
  final String? etag;
  final String? nextPageToken;
  final String? prevPageToken;
  final PageInfo? pageInfo;
  final List<PlaylistItem>? items;

  factory PlaylistResponse.fromJson(Map<String, dynamic> json) =>
      PlaylistResponse(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        prevPageToken: json["prevPageToken"],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: List<PlaylistItem>.from(
            json["items"].map((x) => PlaylistItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "prevPageToken": prevPageToken,
        "nextPageToken": nextPageToken,
        "pageInfo": pageInfo!.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class PlaylistItem {
  PlaylistItem({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
  });

  final String? kind;
  final String? etag;
  final String? id;
  final Snippet? snippet;
  final ContentDetails? contentDetails;

  factory PlaylistItem.fromJson(Map<String, dynamic> json) => PlaylistItem(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: Snippet.fromJson(json["snippet"]),
        contentDetails: ContentDetails.fromJson(json["contentDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet!.toJson(),
        "contentDetails": contentDetails!.toJson(),
      };
}

class ContentDetails {
  ContentDetails({
    this.itemCount,
  });

  final int? itemCount;

  factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
        itemCount: json["itemCount"],
      );

  Map<String, dynamic> toJson() => {
        "itemCount": itemCount,
      };
}

class Snippet {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.localized,
  });

  final DateTime? publishedAt;
  final String? channelId;
  final String? title;
  final String? description;
  final Thumbnails? thumbnails;
  final String? channelTitle;
  final Localized? localized;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        localized: Localized.fromJson(json["localized"]),
      );

  Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt!.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails!.toJson(),
        "channelTitle": channelTitle,
        "localized": localized!.toJson(),
      };
}

class Localized {
  Localized({
    this.title,
    this.description,
  });

  final String? title;
  final String? description;

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
    this.maxres,
  });

  final Default? thumbnailsDefault;
  final Default? medium;
  final Default? high;
  final Default? standard;
  final Default? maxres;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault:
            json["default"] == null ? null : Default.fromJson(json["default"]),
        medium:
            json["medium"] == null ? null : Default.fromJson(json["medium"]),
        high: json["high"] == null ? null : Default.fromJson(json["high"]),
        standard: json["standard"] == null
            ? null
            : Default.fromJson(json["standard"]),
        maxres:
            json["maxres"] == null ? null : Default.fromJson(json["maxres"]),
      );

  Map<String, dynamic> toJson() => {
        "medium": medium!.toJson(),
        "standard": standard == null ? null : standard!.toJson(),
        "maxres": maxres == null ? null : maxres!.toJson(),
        "default":
            thumbnailsDefault == null ? null : thumbnailsDefault!.toJson(),
        "high": high == null ? null : high!.toJson(),
      };
}

class Default {
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
