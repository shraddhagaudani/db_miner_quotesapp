import 'dart:convert';

import 'package:db_miner_quotesapp/models/quotes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LJHelper {
  LJHelper._();

  static final LJHelper ljHelper = LJHelper._();

  String? data;

  List<QuotesFirstMap_Model> quotesFirstList = [];
  List<QuotesSecondMap_Model> quotesSecondList = [];

  Future<List<QuotesFirstMap_Model>> fetchDataFromFirstModelJsonBank() async {
    data = await rootBundle.loadString("assets/json/quotes.json");

    List decodedList = jsonDecode(data!);

    for (int i = 0; i < decodedList.length; i++) {
      quotesFirstList = decodedList
          .map((e) => QuotesFirstMap_Model.fromMap(data: e))
          .toList();
    }
    return quotesFirstList;

    // for(int i = 0;i < decodedList.length ; i++){
    //   quotesSecondList = decodedList.map((e) => QuotesSecondMap_Model.fromMap(data: e)).toList();
    // };
  }

  Future<List<QuotesSecondMap_Model>> fetchDataFromSecondModelJsonBank() async {
    data = await rootBundle.loadString("assets/json/quotes.json");

    List decodedList = jsonDecode(data!);

    for (int i = 0; i < decodedList.length; i++) {
      quotesSecondList = decodedList
          .map((e) => QuotesSecondMap_Model.fromMap(data: e))
          .toList();
    }
    return quotesSecondList;
  }
}

class DBHelper {
  DBHelper._();

  Database? db;

  static final DBHelper dbHelper = DBHelper._();

  Future initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, "quotes.db");

    db = await openDatabase(path, version: 2, onCreate: (Database db, _) async {
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
  insertQuote() async {
    await initDB();

    List<QuotesFirstMap_Model> data =
        await LJHelper.ljHelper.fetchDataFromFirstModelJsonBank();

    for (int i = 0; i < data.length; i++) {
      String query = "INSERT INTO quotesFirstTable(id,category)VALUES(?,?)";

      List args = [
        data[i].id,
        data[i].categoryName,
      ];

      int res = await db!.rawInsert(query, args);
      // print(res);
      return res;
    }
  }

  //first fetch
  Future<List<QuotesFirstMap_Model>> fetchAllQuotes() async {
    await initDB();

    await insertQuote();

    String query = "SELECT *FROM quotesFirstTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<QuotesFirstMap_Model> allQuotes =
        res.map((e) => QuotesFirstMap_Model.fromMap(data: e)).toList();

    // print("+=====================================+");
    // print(allQuotes);
    // print("+=====================================+");
    return allQuotes;
  }

  //second insert:
  insertQuoteSecondMap() async {
    await initDB();

    List<QuotesSecondMap_Model> data =
        await LJHelper.ljHelper.fetchDataFromSecondModelJsonBank();

    for (int i = 0; i < data.length; i++) {
      String query =
          "INSERT INTO quotesSecondTable(id,quote,author) VALUES(?,?,?)";

      List args = [
        data[i].id,
        data[i].quote,
        data[i].authorName,
      ];

      int res = await db!.rawInsert(query, args);
      print(res);
      return res;
    }
  }

  //second fetch:
  Future<List<QuotesSecondMap_Model>> fetchAllSecondQuotes() async {
    await initDB();

    await insertQuoteSecondMap();

    String query = "SELECT *FROM quotesSecondTable";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<QuotesSecondMap_Model> allQuotes =
        res.map((e) => QuotesSecondMap_Model.fromMap(data: e)).toList();
    print(allQuotes);
    return allQuotes;
  }
}
