import 'package:equatable/equatable.dart';
import '../../data/model/channel_response.dart';

class ChannelEntity extends Equatable {
   const ChannelEntity({
     this.kind,
     this.etag,
     this.pageInfo,
     this.items,
  });
  final String? kind;
  final String? etag;
  final PageInfo? pageInfo;
  final List<ChannelItem>? items;

  @override
  List<Object?> get props => [kind, etag, pageInfo, items];
}
