import 'package:flutter/material.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/app_controllers.dart';
import '../models/quotes_model.dart';
import '../utills/all_atributes.dart';

class Quotecategory_component extends StatefulWidget {
  const Quotecategory_component({super.key});

  @override
  State<Quotecategory_component> createState() =>
      _Quotecategory_componentState();
}

class _Quotecategory_componentState extends State<Quotecategory_component> {
  FavriouteController favriouteController = Get.put(FavriouteController());
  late Future<List<DatabaseFirst_Model>> getAllCategory;

  @override
  void initState() {
    super.initState();
    getAllCategory = DBHelper.dbHelper.fetchAllFirstQuotes();
  }

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
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (val) {
                setState(
                  () {
                    getAllCategory =
                        DBHelper.dbHelper.fetchSearchCategory(data: val);
                  },
                );
              },
              decoration: const InputDecoration(
                hintText: "Search category for quotes..",
                label: Text("Search quote category"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 12,
            child: FutureBuilder(
              future: getAllCategory,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Center(
                    child: Text(
                      "ERROR:${snapshot.error}",
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<DatabaseFirst_Model>? data = snapshot.data!;
                  // print(data[0].categoryName);
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("No data available..."),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 18,
                        childAspectRatio: 2 / 3,
                      ),
                      itemBuilder: (context, i) {
                        return Builder(builder: (context) {
                          return Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    getAllQuotes = DBHelper.dbHelper
                                        .fetchAllSecondQuotes(id: data[i].id!);
                                    Get.toNamed('/jsonquote_detailpage');
                                  },
                                  child: Container(
                                    height: 170,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 8,
                                        ),
                                      ],
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          allCategoryImages[data[i].id! - 1],
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.primaries[i],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data[i].categoryName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },);
                      },
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
