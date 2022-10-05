import 'package:flutter/material.dart';
import 'package:youtube_data_api/features/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 5.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
      }
    });
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/yt.png",
          height: controller.value * 100,
        ),
      ),
    );
  }
}
