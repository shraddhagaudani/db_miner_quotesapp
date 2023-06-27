import 'package:db_miner_quotesapp/models/quotes_model.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../controllers/quotes_controllers.dart';

class JsonQuote_detailpage extends StatefulWidget {
  const JsonQuote_detailpage({super.key});

  @override
  State<JsonQuote_detailpage> createState() => _JsonQuote_detailpageState();
}

class _JsonQuote_detailpageState extends State<JsonQuote_detailpage> {
  // late Future<List<QuotesModel>> getAllQuotes;

  late Future<List<QuotesSecondMap_Model>> getAllQuotes;

  QuotesController qc = Get.find<QuotesController>();

  @override
  void initState() {
    super.initState();
    // getAllQuotes = DBHelper.dbHelper.fetchAllQuotes();
    getAllQuotes = LJHelper.ljHelper.fetchDataFromSecondModelJsonBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getAllQuotes,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.hasError}"),
              );
            } else if (snapshot.hasData) {
              List<QuotesSecondMap_Model>? data = snapshot.data!;
              if (data.isEmpty) {
                const Center(
                  child: Text("No data available..."),
                );
              } else {
                return Column(
                  children: [
                    ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          print(data[i].authorName);
                          return Container(alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.primaries[i].shade300,
                            ),
                            child: Text("${data[i].id}"),
                          );
                        },),
                  ],
                );
              }
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
