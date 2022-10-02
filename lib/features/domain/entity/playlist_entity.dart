
import 'package:equatable/equatable.dart';
import 'package:youtube_data_api/features/data/model/playlist_response.dart';

class PlaylistEntity extends Equatable {
  PlaylistEntity({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.pageInfo,
    this.items,
  });

  final String? kind;
  final String? etag;
  final String? nextPageToken;
  final PageInfo? pageInfo;
  final List<Item>? items;

  @override
  // TODO: implement props
  List<Object?> get props => [kind, etag, nextPageToken, pageInfo, items];
}