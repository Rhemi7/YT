import 'package:equatable/equatable.dart';
import 'package:youtube_data_api/features/data/model/videos_response.dart';

class VideosEntity extends Equatable {
  VideosEntity({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.regionCode,
    this.pageInfo,
    this.items,
  });

  final String? kind;
  final String? etag;
  final String? nextPageToken;
  final String? regionCode;
  final PageInfo? pageInfo;
  final List<Item>? items;

  @override
  // TODO: implement props
  List<Object?> get props => [kind, etag, nextPageToken, regionCode, pageInfo, items];
}