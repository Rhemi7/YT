// To parse this JSON data, do
//
//     final channelResponse = channelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:youtube_data_api/features/domain/entity/channel_entity.dart';

ChannelResponse channelResponseFromJson(String str) => ChannelResponse.fromJson(json.decode(str));

String channelResponseToJson(ChannelResponse data) => json.encode(data.toJson());

class ChannelResponse extends ChannelEntity {
  ChannelResponse({
    this.kind,
    this.etag,
    this.pageInfo,
    this.items,
  });

  final String? kind;
  final String? etag;
  final PageInfo? pageInfo;
  final List<ChannelItem>? items;

  factory ChannelResponse.fromJson(Map<String, dynamic> json) => ChannelResponse(
    kind: json["kind"],
    etag: json["etag"],
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
    items: List<ChannelItem>.from(json["items"].map((x) => ChannelItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "pageInfo": pageInfo!.toJson(),
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class ChannelItem {
  ChannelItem({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
    this.statistics,
    this.brandingSettings,
  });

  final String? kind;
  final String ?etag;
  final String? id;
  final Snippet? snippet;
  final ContentDetails? contentDetails;
  final Statistics? statistics;
  final BrandingSettings? brandingSettings;

  factory ChannelItem.fromJson(Map<String, dynamic> json) => ChannelItem(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    snippet: Snippet.fromJson(json["snippet"]),
    contentDetails: ContentDetails.fromJson(json["contentDetails"]),
    statistics: Statistics.fromJson(json["statistics"]),
    brandingSettings: BrandingSettings.fromJson(json["brandingSettings"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": snippet!.toJson(),
    "contentDetails": contentDetails!.toJson(),
    "statistics": statistics!.toJson(),
    "brandingSettings": brandingSettings!.toJson(),
  };
}

class BrandingSettings {
  BrandingSettings({
    this.channel,
    this.image,
  });

  final Channel? channel;
  final Image? image;

  factory BrandingSettings.fromJson(Map<String, dynamic> json) => BrandingSettings(
    channel: Channel.fromJson(json["channel"]),
    image: Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "channel": channel!.toJson(),
    "image": image!.toJson(),
  };
}

class Channel {
  Channel({
    this.title,
    this.description,
    this.keywords,
    this.trackingAnalyticsAccountId,
    this.unsubscribedTrailer,
    this.country,
  });

  final String? title;
  final String ?description;
  final String ?keywords;
  final String ?trackingAnalyticsAccountId;
  final String ?unsubscribedTrailer;
  final String ?country;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    title: json["title"],
    description: json["description"],
    keywords: json["keywords"],
    trackingAnalyticsAccountId: json["trackingAnalyticsAccountId"],
    unsubscribedTrailer: json["unsubscribedTrailer"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "keywords": keywords,
    "trackingAnalyticsAccountId": trackingAnalyticsAccountId,
    "unsubscribedTrailer": unsubscribedTrailer,
    "country": country,
  };
}

class Image {
  Image({
    this.bannerExternalUrl,
  });

  final String? bannerExternalUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    bannerExternalUrl: json["bannerExternalUrl"],
  );

  Map<String, dynamic> toJson() => {
    "bannerExternalUrl": bannerExternalUrl,
  };
}

class ContentDetails {
  ContentDetails({
    this.relatedPlaylists,
  });

  final RelatedPlaylists? relatedPlaylists;

  factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
    relatedPlaylists: RelatedPlaylists.fromJson(json["relatedPlaylists"]),
  );

  Map<String, dynamic> toJson() => {
    "relatedPlaylists": relatedPlaylists!.toJson(),
  };
}

class RelatedPlaylists {
  RelatedPlaylists({
    this.likes,
    this.uploads,
  });

  final String? likes;
  final String? uploads;

  factory RelatedPlaylists.fromJson(Map<String, dynamic> json) => RelatedPlaylists(
    likes: json["likes"],
    uploads: json["uploads"],
  );

  Map<String, dynamic> toJson() => {
    "likes": likes,
    "uploads": uploads,
  };
}

class Snippet {
  Snippet({
    this.title,
    this.description,
    this.customUrl,
    this.publishedAt,
    this.thumbnails,
    this.localized,
    this.country,
  });

  final String? title;
  final String? description;
  final String? customUrl;
  final DateTime? publishedAt;
  final Thumbnails? thumbnails;
  final Localized? localized;
  final String? country;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    title: json["title"],
    description: json["description"],
    customUrl: json["customUrl"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    localized: Localized.fromJson(json["localized"]),
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "customUrl": customUrl,
    "publishedAt": publishedAt!.toIso8601String(),
    "thumbnails": thumbnails!.toJson(),
    "localized": localized!.toJson(),
    "country": country,
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
  });

  final Default? thumbnailsDefault;
  final Default? medium;
  final Default? high;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    medium: Default.fromJson(json["medium"]),
    high: Default.fromJson(json["high"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault!.toJson(),
    "medium": medium!.toJson(),
    "high": high!.toJson(),
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

class Statistics {
  Statistics({
    this.viewCount,
    this.subscriberCount,
    this.hiddenSubscriberCount,
    this.videoCount,
  });

  final String? viewCount;
  final String? subscriberCount;
  final bool? hiddenSubscriberCount;
  final String? videoCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    viewCount: json["viewCount"],
    subscriberCount: json["subscriberCount"],
    hiddenSubscriberCount: json["hiddenSubscriberCount"],
    videoCount: json["videoCount"],
  );

  Map<String, dynamic> toJson() => {
    "viewCount": viewCount,
    "subscriberCount": subscriberCount,
    "hiddenSubscriberCount": hiddenSubscriberCount,
    "videoCount": videoCount,
  };
}

class PageInfo extends Equatable{
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
