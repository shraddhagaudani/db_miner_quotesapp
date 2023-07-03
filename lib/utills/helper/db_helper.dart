import 'dart:convert';
import 'package:db_miner_quotesapp/controllers/app_controllers.dart';
import 'package:db_miner_quotesapp/models/app_model.dart';
import 'package:db_miner_quotesapp/models/quotes_model.dart';
import 'package:db_miner_quotesapp/utills/all_atributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class LJHelper {
  LJHelper._();

  static final LJHelper ljHelper = LJHelper._();

  String? data;

  Future<List<QuotesModel>> fetchDataFromFirstModelJsonBank() async {
    data = await rootBundle.loadString("assets/json/quotes.json");

    List decodedList = jsonDecode(data!);

    List<QuotesModel> quotesFirstList = decodedList
        .map(
          (e) => QuotesModel.fromMap(data: e),
        )
        .toList();

    return quotesFirstList;

    // for(int i = 0;i < decodedList.length ; i++){
    //   quotesSecondList = decodedList.map((e) => QuotesSecondMap_Model.fromMap(data: e)).toList();
    // };
  }
}

class DBHelper {
  DBHelper._();

  Database? db;

  static final DBHelper dbHelper = DBHelper._();

  Future initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, "quotes.db");

    db = await openDatabase(path, version: 1, onCreate: (Database db, _) async {
      String firstquery =
          "CREATE TABLE IF NOT EXISTS quotesFirstTable(id INTEGER,category TEXT)";

      await db.execute(firstquery);

      String secondquery =
          "CREATE TABLE IF NOT EXISTS quotesSecondTable(id INTEGER,quote TEXT,author TEXT)";

      await db.execute(secondquery);
      // print(query);
    });
  }

//first insert
  insertQuoteFirstMap() async {
    await initDB();

    List<QuotesModel> data =
        await LJHelper.ljHelper.fetchDataFromFirstModelJsonBank();

    for (int i = 0; i < data.length; i++) {
      String query = "INSERT INTO quotesFirstTable(id,category)VALUES(?,?)";

      List args = [
        data[i].id,
        data[i].category,
      ];

      await db!.rawInsert(query, args);
      // print(res);
    }
  }

  //second insert:
  insertQuoteSecondMap() async {
    await initDB();

    List<QuotesModel> data =
        await LJHelper.ljHelper.fetchDataFromFirstModelJsonBank();

    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[i].quotes.length; j++) {
        String query =
            "INSERT INTO quotesSecondTable(id,quote,author) VALUES(?,?,?)";

        List args = [
          data[i].quotes[j].id,
          data[i].quotes[j].quote,
          data[i].quotes[j].author,
        ];
        int res = await db!.rawInsert(query, args);
        // print("======");
        // print(res);
        // print("======");
      }
    }
  }

  //first fetch:
  Future<List<DatabaseFirst_Model>> fetchAllFirstQuotes() async {
    await initDB();

    TrueOrFalseValController trueOrFalseValController =
        TrueOrFalseValController();
    if (checkValue.read("trueorfalsevalforcategory") != true) {
      await insertQuoteFirstMap();
      print("One Time Run");
      print(
        checkValue.read("trueorfalsevalforcategory"),
      );
    } else {
      print("No Repete");
      print(
        checkValue.read("trueorfalsevalforcategory"),
      );
    }

    trueOrFalseValController.TrueOrFalsevalueforquotes();

    String query = "SELECT * FROM quotesFirstTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<DatabaseFirst_Model> allQuotes =
        res.map((e) => DatabaseFirst_Model.fromMap(data: e)).toList();

    print("+=====================================+");
    print(allQuotes);
    print("+=====================================+");
    return allQuotes;
  }

  //second fetch:
  Future<List<DatabaseSecond_Model>> fetchAllSecondQuotes(
      {required int id}) async {
    await initDB();

    TrueOrFalseValController trueOrFalseValController =
        TrueOrFalseValController();
    if (checkValue.read("truefalsevalfordetailspage") != true) {
      await insertQuoteSecondMap();
      print("One Time Run....");
      print(checkValue.read("truefalsevalfordetailspage"));
    } else {
      print("No Repete...");
      print(checkValue.read("truefalsevalfordetailspage"));
    }

    trueOrFalseValController.Truefalsevaluefordetailspage();

    String query = "SELECT *FROM quotesSecondTable WHERE id = ?";
    List args = [id];

    List<Map<String, dynamic>> res = await db!.rawQuery(query, args);
    // print(res);
    List<DatabaseSecond_Model> allQuotes =
        res.map((e) => DatabaseSecond_Model.fromMap(data: e)).toList();
    print(res);
    print("==============");
    print(allQuotes);
    print("==============");
    return allQuotes;
  }

  Future<List<DatabaseFirst_Model>> fetchSearchCategory(
      {required String data}) async {
    await initDB();

    String query =
        "SELECT * FROM quotesFirstTable WHERE category LIKE '%$data%';";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);
    print("++++++++++++++++++++");
    print(query);
    print("++++++++++++++++++++");

    List<DatabaseFirst_Model> searchQuote =
        res.map((e) => DatabaseFirst_Model.fromMap(data: e)).toList();
    print("==================");
    print(searchQuote);
    print("==================");
    return searchQuote;
  }
}

class WPHelper {
  WPHelper._();

  static WPHelper wpHelper = WPHelper._();

  Future<List<ImageModel>?> fetchAllImages({required String Search}) async {
    print("start");
    String apiKey = "38028649-54c4f8104743c24c8adaf5671";
    String baseUrl =
        "https://pixabay.com/api/?key=$apiKey&q=$Search&image_type=photo&pretty=true";

    http.Response res = await http.get(Uri.parse(baseUrl));
    print(res);
    if (res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      List allData = decodedData['hits'];

      List<ImageModel> allImages =
          allData.map((e) => ImageModel.fromMap(data: e)).toList();
      print("end");
      return allImages;
    }
  }
}
