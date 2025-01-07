import 'package:db_miner_quotesapp/models/quotes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:db_miner_quotesapp/controllers/app_controllers.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../utills/all_atributes.dart';

class Favrioute_page extends StatefulWidget {
  const Favrioute_page({super.key});

  @override
  State<Favrioute_page> createState() => _Favrioute_pageState();
}

class _Favrioute_pageState extends State<Favrioute_page> {
  late Future<List<DatabaseSecond_Model>> getAllFavoriute;

  @override
  void initState() {
    getAllFavoriute = DBHelper.dbHelper.fetchFavriouteQuotes();
    super.initState();
  }

  FavriouteController favriouteController = Get.put(FavriouteController());

  @override
  Widget build(BuildContext context) {
    DatabaseSecond_Model? data = Get.arguments as DatabaseSecond_Model?;

    // var data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favourite",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.heart_fill,
                    color: CupertinoColors.destructiveRed,size: 28,
                  )),
            )
          ],
        ),
        // body: Column(
        //   children: [
        //     Text(data!.quote),
        //   ],
        // ),
        body: GetBuilder<FavriouteController>(
          builder: (_) {
            return ListView.builder(
              itemCount: favriouteController.favriouteList.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 420,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.primaries[i%18].withOpacity(0.3),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${favriouteController.favriouteList[i].quote}",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Spacer(),
                                Text(
                                  "- ${favriouteController.favriouteList[i].authorName}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
        // body: FutureBuilder(
        //   future: getAllFavoriute,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(
        //         child: Text("ERROR:${snapshot.error}"),
        //       );
        //     } else if (snapshot.hasData) {
        //       List<DatabaseSecond_Model>? data = snapshot.data;
        //
        //       if (data!.isEmpty) {
        //         return const Center(
        //           child: Text("No available data..."),
        //         );
        //       } else {
        //         return ListView.builder(
        //           itemCount: data.length,
        //           itemBuilder: (context, i) {
        //
        //             Text(data[i].quote);
        //           },
        //         );
        //       }
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}
