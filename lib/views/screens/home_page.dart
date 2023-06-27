import 'dart:convert';

import 'package:db_miner_quotesapp/controllers/quotes_controllers.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:db_miner_quotesapp/models/quotes_model.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  // String? initialval;
  // String? data;
  // List<QuotesModel> quotesList = [];

  QuotesController qc = Get.put(QuotesController());
  late Future<List<QuotesFirstMap_Model>> getAllQuotes;

  @override
  void initState() {
    super.initState();
    getAllQuotes = LJHelper.ljHelper.fetchDataFromFirstModelJsonBank();
    // DBHelper.dbHelper.fetchAllQuotes();
    //   loadJSON();
      DBHelper.dbHelper.fetchAllQuotes();
    }

  //   Future<void> loadJSON() async {
  //     data = await rootBundle.loadString("assets/json/quotes.json");
  // }

  List<String> allCategoryImages = [
    "assets/categoryimage/friendship.png",
    "assets/categoryimage/love.png",
    "assets/categoryimage/motivational.png",
    "assets/categoryimage/success.png",
    "assets/categoryimage/health.png",
    "assets/categoryimage/laugh.png",
    "assets/categoryimage/happy.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        title: const Text("Quotes app"),
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
                initialValue: qc.initialvalModel.initialval,
                onSelected: (val) {
                  // setState(() {
                  //   initialval = val.toString();
                  // });
                  qc.initialvalModel.initialval = val.toString();
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Text("Favourite"),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(CupertinoIcons.heart),
                          ),
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
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        // child: ElevatedButton(onPressed: ()async{

        //   QuotesSecondMap_Model quotesSecondMap_Model = QuotesSecondMap_Model(quote: DBHelper.dbHelper., authorName: authorName)
        //   int  res =   DBHelper.dbHelper.insertQuoteSecondMap();
        //
        //   if(res >= 1){
        //     Get.snackbar("SUCCESS", 'SUCESS $res',backgroundColor: Colors.green);
        //   }else{
        //     Get.snackbar("FAILURE", "Fail");
        //   }
        // }, child: Icon(CupertinoIcons.plus)),
        child: FutureBuilder(
          future: getAllQuotes,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Center(
                child: Text(
                  "ERROR:${snapshot.error}",
                ),
              );
            } else if (snapshot.hasData) {
              List<QuotesFirstMap_Model>? data = snapshot.data!;

              if (data.isEmpty) {
                return const Center(
                  child: Text("No data available..."),
                );
              } else {

                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 18,
                      childAspectRatio: 2 / 3),
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.toNamed('/jsonquote_detailpage');
                          },
                          child: Container(
                            height: 200,
                            width: 220,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 8)
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  allCategoryImages[i],
                                ),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          data[i].categoryName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                      ],
                    );
                  },
                );
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
