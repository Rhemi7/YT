import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/styles.dart';
import '../../../helper/number_formatter.dart';
import '../../../utils/margin.dart';
import '../../../utils/resolution.dart';
import '../../data/model/channel_response.dart';

class MainHomeView extends StatelessWidget {
  final ChannelItem item;
  const MainHomeView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Resolution.screenWidth(context),
          height: Resolution.screenHeight(context, percent: 0.12),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(item
                      .brandingSettings!.image!.bannerExternalUrl
                      .toString()),
                  fit: BoxFit.fitWidth)),
        ),
        const Center(child: YMargin(10)),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          backgroundImage: NetworkImage(
              item.snippet!.thumbnails!.thumbnailsDefault!.url.toString()),
        ),
        const YMargin(15),
        Text(
          item.snippet!.title.toString(),
          style: AppStyle.headingText
              .copyWith(fontSize: Resolution.textSize(context, 22)),
        ),
        const YMargin(15),
        Text(
          "${NumberFormatter.formatter(item.statistics!.subscriberCount.toString())} subscribers",
          style: TextStyle(
            fontSize: Resolution.textSize(context, 16),
          ),
        ),
        const YMargin(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            item.snippet!.description.toString(),
            style: TextStyle(
                fontSize: Resolution.textSize(context, 16),
                color: Colors.grey.shade400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const XMargin(15),
              Flag.fromString(
                item.snippet!.country.toString(),
                height: 15,
                width: 30,
              ),
              const XMargin(15),
              Text(item.snippet!.country.toString())
            ],
          ),
        ),
        const YMargin(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              const Icon(Icons.show_chart),
              const XMargin(15),
              Text(
                  "${NumberFormatter.formatter(item.statistics!.viewCount.toString())} Views")
            ],
          ),
        ),
      ],
    );
  }
}
