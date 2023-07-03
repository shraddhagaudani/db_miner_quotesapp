import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/app_model.dart';
import 'package:get/get.dart';
import 'package:async_wallpaper/async_wallpaper.dart';

class Wallpaper_component extends StatefulWidget {
  const Wallpaper_component({super.key});

  @override
  State<Wallpaper_component> createState() => _Wallpaper_componentState();
}

class _Wallpaper_componentState extends State<Wallpaper_component> {
  late Future<List<ImageModel>?> getAllImages;

  @override
  void initState() {
    getAllImages = WPHelper.wpHelper.fetchAllImages(Search: "flower");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (val) {
                setState(() {
                  getAllImages = WPHelper.wpHelper.fetchAllImages(Search: val);
                });
              },
              decoration: const InputDecoration(
                hintText: "Search Wallpaper here...",
                label: Text("Search Wallpaper"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: FutureBuilder(
              future: getAllImages,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR:${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  List<ImageModel>? data = snapshot.data;

                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: Text("No available data..."),
                    );
                  } else {
                    return GridView.builder(
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/wallpaper_detailspage',
                                arguments: data[i]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data[i].image),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          // ElevatedButton(onPressed: () async{
          //   try{
          //     await AsyncWallpaper.setWallpaper(url: )
          //   }
          // }, child: const Text("Set wallpaper"))
        ],
      ),
    );
  }
}
