import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:db_miner_quotesapp/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Wallpaper_detailspage extends StatefulWidget {
  const Wallpaper_detailspage({super.key});

  @override
  State<Wallpaper_detailspage> createState() => _Wallpaper_detailspageState();
}

class _Wallpaper_detailspageState extends State<Wallpaper_detailspage> {
  @override
  Widget build(BuildContext context) {
    ImageModel imageModel = Get.arguments as ImageModel;
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: Get.height * 0.8,
            width: Get.width * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageModel.image),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(imageModel.userImageUrl),
            ),
            title: Text(imageModel.user),
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            children: [
              Text(
                "Set Wallpaper :",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await AsyncWallpaper.setWallpaper(
                        url: imageModel.image,
                        goToHome: true,
                        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
                        toastDetails: ToastDetails.success(),
                        errorToastDetails: ToastDetails.error(),
                      );
                    } on PlatformException catch (e) {
                      Get.snackbar("$e", "Not successfully set..",
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text("Home screen"),
                ),
                const SizedBox(
                  width: 4,
                ),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await AsyncWallpaper.setWallpaper(
                        url: imageModel.image,
                        goToHome: true,
                        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
                        toastDetails: ToastDetails.success(),
                        errorToastDetails: ToastDetails.error(),
                      );
                    } on PlatformException catch (e) {
                      Get.snackbar("$e", "Not successfully set..",
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text("Lock Screen"),
                ),
                const SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await AsyncWallpaper.setWallpaper(
                        url: imageModel.image,
                        goToHome: true,
                        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
                        toastDetails: ToastDetails.success(),
                        errorToastDetails: ToastDetails.error(),
                      );
                    } on PlatformException catch (e) {
                      Get.snackbar("$e", "Not successfully set..",
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text("Both screen"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
