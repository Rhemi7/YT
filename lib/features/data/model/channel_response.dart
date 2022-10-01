
// To parse this JSON data, do
//
//     final channelResponse = channelResponseFromJson(jsonString);

import 'dart:convert';

ChannelResponse channelResponseFromJson(String str) => ChannelResponse.fromJson(json.decode(str));

String channelResponseToJson(ChannelResponse data) => json.encode(data.toJson());

class ChannelResponse {
  ChannelResponse({
    required this.kind,
    required this.etag,
    required this.pageInfo,
    required this.items,
  });
  late final String kind;
  late final String etag;
  late final PageInfo pageInfo;
  late final List<Items> items;

  ChannelResponse.fromJson(Map<String, dynamic> json){
    kind = json['kind'];
    etag = json['etag'];
    pageInfo = PageInfo.fromJson(json['pageInfo']);
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kind'] = kind;
    _data['etag'] = etag;
    _data['pageInfo'] = pageInfo.toJson();
    _data['items'] = items.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PageInfo {
  PageInfo({
    required this.totalResults,
    required this.resultsPerPage,
  });
  late final int totalResults;
  late final int resultsPerPage;

  PageInfo.fromJson(Map<String, dynamic> json){
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['totalResults'] = totalResults;
    _data['resultsPerPage'] = resultsPerPage;
    return _data;
  }
}

class Items {
  Items({
    required this.kind,
    required this.etag,
    required this.id,
    required this.snippet,
    required this.contentDetails,
    required this.statistics,
    required this.brandingSettings,
  });
  late final String kind;
  late final String etag;
  late final String id;
  late final Snippet snippet;
  late final ContentDetails contentDetails;
  late final Statistics statistics;
  late final BrandingSettings brandingSettings;

  Items.fromJson(Map<String, dynamic> json){
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    snippet = Snippet.fromJson(json['snippet']);
    contentDetails = ContentDetails.fromJson(json['contentDetails']);
    statistics = Statistics.fromJson(json['statistics']);
    brandingSettings = BrandingSettings.fromJson(json['brandingSettings']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kind'] = kind;
    _data['etag'] = etag;
    _data['id'] = id;
    _data['snippet'] = snippet.toJson();
    _data['contentDetails'] = contentDetails.toJson();
    _data['statistics'] = statistics.toJson();
    _data['brandingSettings'] = brandingSettings.toJson();
    return _data;
  }
}

class Snippet {
  Snippet({
    required this.title,
    required this.description,
    required this.customUrl,
    required this.publishedAt,
    required this.thumbnails,
    required this.localized,
    required this.country,
  });
  late final String title;
  late final String description;
  late final String customUrl;
  late final String publishedAt;
  late final Thumbnails thumbnails;
  late final Localized localized;
  late final String country;

  Snippet.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    customUrl = json['customUrl'];
    publishedAt = json['publishedAt'];
    thumbnails = Thumbnails.fromJson(json['thumbnails']);
    localized = Localized.fromJson(json['localized']);
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['customUrl'] = customUrl;
    _data['publishedAt'] = publishedAt;
    _data['thumbnails'] = thumbnails.toJson();
    _data['localized'] = localized.toJson();
    _data['country'] = country;
    return _data;
  }
}

class Thumbnails {
  Thumbnails({
  required this.thumbnailsDefault,
  required this.medium,
  required this.high,
});
late final Default thumbnailsDefault;
late final Default medium;
late final Default high;

Thumbnails.fromJson(Map<String, dynamic> json){
thumbnailsDefault = Default.fromJson(json['default']);
medium = Default.fromJson(json['medium']);
high = Default.fromJson(json['high']);
}

Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['default'] = thumbnailsDefault.toJson();
  _data['medium'] = medium.toJson();
  _data['high'] = high.toJson();
  return _data;
}
}

class Default {
  Default({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;

  Default.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Medium {
  Medium({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;

  Medium.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class High {
  High({
    required this.url,
    required this.width,
    required this.height,
  });
  late final String url;
  late final int width;
  late final int height;

  High.fromJson(Map<String, dynamic> json){
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    return _data;
  }
}

class Localized {
  Localized({
    required this.title,
    required this.description,
  });
  late final String title;
  late final String description;

  Localized.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    return _data;
  }
}

class ContentDetails {
  ContentDetails({
    required this.relatedPlaylists,
  });
  late final RelatedPlaylists relatedPlaylists;

  ContentDetails.fromJson(Map<String, dynamic> json){
    relatedPlaylists = RelatedPlaylists.fromJson(json['relatedPlaylists']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['relatedPlaylists'] = relatedPlaylists.toJson();
    return _data;
  }
}

class RelatedPlaylists {
  RelatedPlaylists({
    required this.likes,
    required this.uploads,
  });
  late final String likes;
  late final String uploads;

  RelatedPlaylists.fromJson(Map<String, dynamic> json){
    likes = json['likes'];
    uploads = json['uploads'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['likes'] = likes;
    _data['uploads'] = uploads;
    return _data;
  }
}

class Statistics {
  Statistics({
    required this.viewCount,
    required this.subscriberCount,
    required this.hiddenSubscriberCount,
    required this.videoCount,
  });
  late final String viewCount;
  late final String subscriberCount;
  late final bool hiddenSubscriberCount;
  late final String videoCount;

  Statistics.fromJson(Map<String, dynamic> json){
    viewCount = json['viewCount'];
    subscriberCount = json['subscriberCount'];
    hiddenSubscriberCount = json['hiddenSubscriberCount'];
    videoCount = json['videoCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['viewCount'] = viewCount;
    _data['subscriberCount'] = subscriberCount;
    _data['hiddenSubscriberCount'] = hiddenSubscriberCount;
    _data['videoCount'] = videoCount;
    return _data;
  }
}

class BrandingSettings {
  BrandingSettings({
    required this.channel,
    required this.image,
  });
  late final Channel channel;
  late final Image image;

  BrandingSettings.fromJson(Map<String, dynamic> json){
    channel = Channel.fromJson(json['channel']);
    image = Image.fromJson(json['image']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['channel'] = channel.toJson();
    _data['image'] = image.toJson();
    return _data;
  }
}

class Channel {
  Channel({
    required this.title,
    required this.description,
    required this.keywords,
    required this.trackingAnalyticsAccountId,
    required this.unsubscribedTrailer,
    required this.country,
  });
  late final String title;
  late final String description;
  late final String keywords;
  late final String trackingAnalyticsAccountId;
  late final String unsubscribedTrailer;
  late final String country;

  Channel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    keywords = json['keywords'];
    trackingAnalyticsAccountId = json['trackingAnalyticsAccountId'];
    unsubscribedTrailer = json['unsubscribedTrailer'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['keywords'] = keywords;
    _data['trackingAnalyticsAccountId'] = trackingAnalyticsAccountId;
    _data['unsubscribedTrailer'] = unsubscribedTrailer;
    _data['country'] = country;
    return _data;
  }
}

class Image {
  Image({
    required this.bannerExternalUrl,
  });
  late final String bannerExternalUrl;

  Image.fromJson(Map<String, dynamic> json){
    bannerExternalUrl = json['bannerExternalUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bannerExternalUrl'] = bannerExternalUrl;
    return _data;
  }
}
