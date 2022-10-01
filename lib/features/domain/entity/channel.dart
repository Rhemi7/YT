import 'package:equatable/equatable.dart';
import '../../data/model/channel_response.dart';

class Channel extends Equatable {
  const Channel({
    required this.kind,
    required this.etag,
    required this.pageInfo,
    required this.items,
  });
  final String kind;
  final String etag;
  final PageInfo pageInfo;
  final List<Items> items;

  @override
  List<Object?> get props => [kind, etag, pageInfo, items];
}
