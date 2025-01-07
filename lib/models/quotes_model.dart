import 'dart:typed_data';

import 'package:flutter/material.dart';

// class QuotesModel {
//   int? id;
//   String categoryName;
//   String? quote;
//   String? authorName;
//   Uint8List? image;
//
//   // bool? favrioute;
//
//   QuotesModel({
//     this.id,
//     required this.categoryName,
//     required this.quote,
//     required this.authorName,
//     this.image,
//   });
//
//   factory QuotesModel.fromMap({required Map<String, dynamic> data}) {
//     return QuotesModel(
//       id: data['quotes'][0]['id'],
//       categoryName: data['category'],
//       quote: data['quotes'][0]['quote'],
//       authorName: data['quotes'][0]['author'],
//     );
//   }
// }

// class DatabaseModel {
//   int? id;
//   String categoryName;
//   String? quote;
//   String? authorName;
//   Uint8List? image;
//
//   DatabaseModel({
//     this.id,
//     required this.categoryName,
//     required this.quote,
//     required this.authorName,
//     this.image,
//   });
//
//   factory DatabaseModel.fromMap({required Map data}) {
//     return DatabaseModel(
//       id: data['quotes'][0]['id'],
//       categoryName: data['category'],
//       quote: data['quotes'][0]['quote'],
//       authorName: data['quotes'][0]['author'],
//     );
//   }
// }

// class QuotesFirstMap_Model {
//   int? id;
//   String categoryName;
//
//   QuotesFirstMap_Model({this.id, required this.categoryName});
//
//   factory QuotesFirstMap_Model.fromMap({required Map data}) {
//     return QuotesFirstMap_Model(
//       id: data['id'],
//       categoryName: data['category'],
//     );
//   }
// }
//
// class QuotesSecondMap_Model {
//   int? id;
//   String quote;
//   String authorName;
//
//   QuotesSecondMap_Model(
//       {this.id, required this.quote, required this.authorName});
//
//   factory QuotesSecondMap_Model.fromMap({required Map data}) {
//     return QuotesSecondMap_Model(
//       id: data['id'],
//       quote: data['quote'],
//       authorName: data['author'],
//     );
//   }
// }

class QuotesModel {
  int id;
  String category;
  List<Quote> quotes;

  QuotesModel({
    required this.id,
    required this.category,
    required this.quotes,
  });

  factory QuotesModel.fromMap({required Map<String, dynamic> data}) =>
      QuotesModel(
        id: data["id"],
        category: data["category"],
        quotes: List<Quote>.from(
          data["quotes"].map(
            (x) => Quote.fromMap(data: x),
          ),
        ),
      );
}

class Quote {
  int id;
  String quote;
  String author;
  String favourite;
  int idd;

  Quote(
      {required this.id,
      required this.quote,
      required this.author,
      required this.favourite,
      required this.idd});

  factory Quote.fromMap({required Map<String, dynamic> data}) => Quote(
      id: data["id"],
      quote: data["quote"],
      author: data["author"],
      favourite: data['favourite'],
      idd: data['idd']);
}

class DatabaseFirst_Model {
  int? id;
  String categoryName;

  DatabaseFirst_Model({
    this.id,
    required this.categoryName,
  });

  factory DatabaseFirst_Model.fromMap({required Map data}) {
    return DatabaseFirst_Model(
      id: data['id'],
      categoryName: data['category'],
    );
  }
}

class DatabaseSecond_Model {
  int id;
  String quote;
  String authorName;
  String favourite;
  int idd;

  DatabaseSecond_Model(
      {required this.id,
      required this.quote,
      required this.authorName,
      required this.favourite,
      required this.idd});

  factory DatabaseSecond_Model.fromMap({required Map data}) {
    return DatabaseSecond_Model(
        id: data['id'],
        quote: data['quote'],
        authorName: data['author'],
        favourite: data['favourite'],
        idd: data['idd']);
  }
}

// To parse this JSON data, do
//
//     final quotesModel = quotesModelFromJson(jsonString);

class TrueOrFalseAccessModel {
  bool trueorfalsevalforcategory;
  bool truefalsevalfordetailspage;

  TrueOrFalseAccessModel({
    required this.trueorfalsevalforcategory,
    required this.truefalsevalfordetailspage,
  });
}
