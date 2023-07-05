import 'package:db_miner_quotesapp/models/quotes_model.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

import '../../controllers/app_controllers.dart';
import '../../utills/all_atributes.dart';

class JsonQuote_detailpage extends StatefulWidget {
  const JsonQuote_detailpage({super.key});

  @override
  State<JsonQuote_detailpage> createState() => _JsonQuote_detailpageState();
}

class _JsonQuote_detailpageState extends State<JsonQuote_detailpage> {
  // late Future<List<QuotesModel>> getAllQuotes;//

  QuotesController qc = Get.find<QuotesController>();
  FavriouteController favriouteController = Get.find<FavriouteController>();

  // @override
  // void initState() {
  //   super.initState();
  //   // getAllQuotes = DBHelper.dbHelper.fetchAllQuotes();//
  //   // getAllQuotes = LJHelper.ljHelper.fetchDataFromSecondModelJsonBank();//
  //   getAllQuotes = DBHelper.dbHelper.fetchAllSecondQuotes();
  // }

  List<String> detailspageimage = [
    "assets/Alljsonimage/Friendship.png",
    "assets/Alljsonimage/love.png",
    "assets/Alljsonimage/motivational.png",
    "assets/Alljsonimage/success.png",
    "assets/Alljsonimage/health.png",
    "assets/Alljsonimage/laugh.png",
    "assets/Alljsonimage/happy.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Details Page"),
      ),
      body: GetBuilder<FavriouteController>(
        builder: (_) {
          return FutureBuilder(
            future: getAllQuotes,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.hasError}"),
                );
              } else if (snapshot.hasData) {
                List<DatabaseSecond_Model>? data = snapshot.data!;
                if (data.isEmpty) {
                  const Center(
                    child: Text("No data available..."),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(14),
                        child: Container(
                          height: 390,
                          width: Get.width * 1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 8,
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage(detailspageimage[data[i].id! - 1]),
                            ),
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.primaries[i % 18].shade300,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  data[i].quote,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoColors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "- ${data[i].authorName}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: CupertinoColors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    color: Colors.white.withOpacity(
                                      0.1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed('/favourite_page');
                                          print(data[i].quote);
                                          favriouteController.addFavrioute(
                                              added: data[i]);
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.heart,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Like",
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed('/edit_page',
                                              arguments: data[i]);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(text: data[i].quote),
                                          ).then(
                                            (value) => Get.snackbar(
                                              "COPY QUOTE",
                                              "Successfully Copy",
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.doc_on_clipboard,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Copy",
                                        style: TextStyle(
                                            color: CupertinoColors.white),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await Share.share(data[i].quote);
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.share,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Share",
                                        style: TextStyle(
                                            color: CupertinoColors.white,),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
