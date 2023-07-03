import 'dart:convert';

import 'package:db_miner_quotesapp/components/edit_components.dart';
import 'package:db_miner_quotesapp/components/favrioute_components.dart';
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
                Get.isDarkMode
                    ? Get.changeTheme(ThemeData.light(useMaterial3: true))
                    : Get.changeTheme(ThemeData.dark(useMaterial3: true));
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
            Favrioute_components(),
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
            NavigationDestination(
                icon: Icon(CupertinoIcons.heart), label: "Favourite"),
            NavigationDestination(
                icon: Icon(CupertinoIcons.settings), label: "Setting"),
          ],
        ),
      );
    },);
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 0,
    //     title: const Text("Quotes app"),
    //     actions: [
    //       IconButton(
    //         onPressed: () {
    //           Get.isDarkMode
    //               ? Get.changeTheme(ThemeData.light(useMaterial3: true))
    //               : Get.changeTheme(ThemeData.dark(useMaterial3: true));
    //         },
    //         icon: const Icon(Icons.sunny),
    //       ),
    //       GetBuilder<QuotesController>(
    //         builder: (_) {
    //           return PopupMenuButton(
    //             initialValue: quotesController.initialvalModel.initialval,
    //             onSelected: (val) {
    //               quotesController.initialvalModel.initialval = val.toString();
    //             },
    //             itemBuilder: (context) {
    //               return [
    //                 PopupMenuItem(
    //                   child: Row(
    //                     children: [
    //                       IconButton(
    //                         onPressed: () {
    //                           Get.back();
    //
    //                           Get.toNamed('/favourite_page');
    //                         },
    //                         icon: const Icon(CupertinoIcons.heart),
    //                       ),
    //                       const Text("Favourite"),
    //                     ],
    //                   ),
    //                 ),
    //               ];
    //             },
    //           );
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Container(
    //     padding: const EdgeInsets.all(20),
    //     alignment: Alignment.center,
    //     child: Column(
    //       children: [
    //         Expanded(
    //           flex: 2,
    //           child: TextField(
    //             onChanged: (val) {
    //               setState(
    //                 () {
    //                   getAllCategory =
    //                       DBHelper.dbHelper.fetchSearchCategory(data: val);
    //                 },
    //               );
    //             },
    //             decoration: const InputDecoration(
    //               hintText: "Search category for quotes..",
    //               label: Text("Search quote category"),
    //               border: OutlineInputBorder(),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         Expanded(
    //           flex: 12,
    //           child: FutureBuilder(
    //             future: getAllCategory,
    //             builder: (context, snapshot) {
    //               if (snapshot.hasError) {
    //                 Center(
    //                   child: Text(
    //                     "ERROR:${snapshot.error}",
    //                   ),
    //                 );
    //               } else if (snapshot.hasData) {
    //                 List<DatabaseFirst_Model>? data = snapshot.data!;
    //                 print(data[0].categoryName);
    //                 if (data.isEmpty) {
    //                   return const Center(
    //                     child: Text("No data available..."),
    //                   );
    //                 } else {
    //                   return GridView.builder(
    //                     shrinkWrap: true,
    //                     itemCount: data.length,
    //                     gridDelegate:
    //                         const SliverGridDelegateWithFixedCrossAxisCount(
    //                       crossAxisCount: 2,
    //                       mainAxisSpacing: 10,
    //                       crossAxisSpacing: 18,
    //                       childAspectRatio: 2 / 3,
    //                     ),
    //                     itemBuilder: (context, i) {
    //                       return Builder(builder: (context) {
    //                         return Column(
    //                           children: [
    //                             GestureDetector(
    //                               onTap: () {
    //                                 getAllQuotes = DBHelper.dbHelper
    //                                     .fetchAllSecondQuotes(id: data[i].id!);
    //                                 Get.toNamed('/jsonquote_detailpage');
    //                               },
    //                               child: Container(
    //                                 height: 160,
    //                                 width: 220,
    //                                 decoration: BoxDecoration(
    //                                   boxShadow: const [
    //                                     BoxShadow(
    //                                       color: Colors.black,
    //                                       blurRadius: 8,
    //                                     ),
    //                                   ],
    //                                   image: DecorationImage(
    //                                     fit: BoxFit.cover,
    //                                     image: AssetImage(
    //                                       allCategoryImages[data[i].id! - 1],
    //                                     ),
    //                                   ),
    //                                   borderRadius: BorderRadius.circular(20),
    //                                   color: Colors.primaries[i],
    //                                 ),
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               height: 10,
    //                             ),
    //                             Text(
    //                               data[i].categoryName,
    //                               style: const TextStyle(
    //                                 fontSize: 18,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           ],
    //                         );
    //                       });
    //                     },
    //                   );
    //                 }
    //               }
    //               return const CircularProgressIndicator();
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
