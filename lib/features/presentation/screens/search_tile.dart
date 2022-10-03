import 'package:flutter/material.dart';

import '../../../utils/margin.dart';
import '../../data/model/videos_response.dart';

class SearchTile extends StatelessWidget {
  final Item res;
  const SearchTile({
    Key? key,
    required this.res,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.search),
          ),
          const XMargin(20),
          Expanded(
              child: Text(
            res.snippet!.title.toString(),
            style: const TextStyle(fontSize: 16),
          )),
          const XMargin(20),
          const Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}
