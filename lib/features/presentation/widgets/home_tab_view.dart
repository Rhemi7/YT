import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import '../notifier/get_channel/get_channel_state.dart';
import '../provider/provider.dart';
import 'app_error_widget.dart';
import 'main_home_view.dart';

class HomeTabView extends ConsumerStatefulWidget {
  const HomeTabView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends ConsumerState<HomeTabView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(getChannelNotifierProvider.notifier).getFavChannel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final channelState = ref.watch(getChannelNotifierProvider);
            if (channelState is GetChannelLoading) {
              return const CircularProgressIndicator();
            } else if (channelState is GetChannelLoaded) {
              return MainHomeView(
                item: channelState.item!,
              );
            } else if (channelState is GetChannelError) {
              return AppErrorWidget(
                error: channelState.message,
                onTap: () {
                  ref
                      .watch(getChannelNotifierProvider.notifier)
                      .getFavChannel();
                },
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
