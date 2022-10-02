

import 'package:equatable/equatable.dart';

import '../../data/model/playlist_videos_response.dart';

class PlaylistVideoEntity extends Equatable {
  PlaylistVideoEntity({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.items,
    this.pageInfo,
  });

  final String? kind;
  final String? etag;
  final String? nextPageToken;
  final List<Item>? items;
  final PageInfo? pageInfo;

  @override
  // TODO: implement props
  List<Object?> get props => [kind, etag, nextPageToken, items, pageInfo];
}