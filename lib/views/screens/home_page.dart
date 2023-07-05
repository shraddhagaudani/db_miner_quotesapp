import 'dart:convert';
import 'package:db_miner_quotesapp/components/quotescategory_components.dart';
import 'package:db_miner_quotesapp/components/wallpaper_components.dart';
import 'package:db_miner_quotesapp/controllers/app_controllers.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:db_miner_quotesapp/models/quotes_model.dart';
import '../../utills/all_atributes.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  QuotesController quotesController = Get.put(QuotesController());
  NavigationController navigationController = Get.put(NavigationController());
  FavriouteController  favriouteController = Get.put(FavriouteController());
  ThemeController themeController = Get.put(ThemeController());

  // late Future<List<DatabaseFirst_Model>> getAllCategory;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getAllCategory = DBHelper.dbHelper.fetchAllFirstQuotes();
  // }
  //
  // // String? imageurl = "assets/categoryimage/friendship.png";
  // List<String> allCategoryImages = [
  //   "assets/categoryimage/friendship.png",
  //   "assets/categoryimage/love.png",
  //   "assets/categoryimage/motivational.png",
  //   "assets/categoryimage/success.png",
  //   "assets/categoryimage/health.png",
  //   "assets/categoryimage/laugh.png",
  //   "assets/categoryimage/happy.png",
  // ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Quote App"),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                themeController.ChangeTheme();
                // Get.isDarkMode
                //     ? Get.changeTheme(ThemeData.light(useMaterial3: true))
                //     : Get.changeTheme(ThemeData.dark(useMaterial3: true));
              },
              icon: const Icon(Icons.sunny),
            ),
            GetBuilder<QuotesController>(
              builder: (_) {
                return PopupMenuButton(
                  initialValue: quotesController.initialvalModel.initialval,
                  onSelected: (val) {
                    quotesController.initialvalModel.initialval =
                        val.toString();
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();

                                Get.toNamed('/favourite_page');
                              },
                              icon: const Icon(CupertinoIcons.heart),
                            ),
                            const Text("Favourite"),
                          ],
                        ),
                      ),
                    ];
                  },
                );
              },
            ),
          ],
        ),
        body: PageView(
          controller: navigationController.pageController,
          scrollDirection: Axis.horizontal,
          pageSnapping: true,
          onPageChanged: (val) {
            setState(
              () {
                navigationController.initialval = val;
              },
            );
          },
          children: const [
            Quotecategory_component(),
            // Quotedetail_components(),
            // Edit_components(),
            Wallpaper_component(),
            // Favrioute_components(),
            // Setting_components(),

          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationController.initialval,
          onDestinationSelected: (val) {
            setState(
              () {
                navigationController.initialval = val;
                navigationController.pageController.animateToPage(

                  navigationController.initialval,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                );
              },
            );
          },
          destinations: const [
            NavigationDestination(
                icon: Icon(CupertinoIcons.home), label: "Home"),
            // NavigationDestination(icon: Icon(Icons.edit), label: "edit"),
            NavigationDestination(icon: Icon(CupertinoIcons.photo), label: "Set Wallpaper"),
            // NavigationDestination(
            //     icon: Icon(CupertinoIcons.heart), label: "Favourite"),
            // NavigationDestination(
            //     icon: Icon(CupertinoIcons.settings), label: "Setting"),
          ],
        ),
      );
    },);

  }
}
