import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () => Get.offNamed('/'),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: Get.height * 1,
            width: Get.width * 1,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/img_5.png"),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
