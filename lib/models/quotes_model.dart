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

class DatabaseModel {
  int? id;
  String categoryName;
  String? quote;
  String? authorName;
  Uint8List? image;

  DatabaseModel({
    this.id,
    required this.categoryName,
    required this.quote,
    required this.authorName,
    this.image,
  });

  factory DatabaseModel.fromMap({required Map data}) {
    return DatabaseModel(
      id: data['quotes'][0]['id'],
      categoryName: data['category'],
      quote: data['quotes'][0]['quote'],
      authorName: data['quotes'][0]['author'],
    );
  }
}

class QuotesFirstMap_Model {
  int? id;
  String categoryName;

  QuotesFirstMap_Model({this.id, required this.categoryName});

  factory QuotesFirstMap_Model.fromMap({required Map data}) {
    return QuotesFirstMap_Model(
      id: data['id'],
      categoryName: data['category'],
    );
  }
}

class QuotesSecondMap_Model {
  int? id;
  String quote;
  String authorName;

  QuotesSecondMap_Model(
      { this.id, required this.quote, required this.authorName});

  factory QuotesSecondMap_Model.fromMap({required Map data}) {
    return QuotesSecondMap_Model(
      id: data['id'],
      quote: data['quote'],
      authorName: data['author'],
    );
  }
}

class DatabaseFirst_Model {
  int? id;
  String categoryName;

  DatabaseFirst_Model({this.id, required this.categoryName});

  factory DatabaseFirst_Model.fromMap({required Map data}) {
    return DatabaseFirst_Model(
      id: data['id'],
      categoryName: data['category'],
    );
  }
}

class DatabaseSecond_Model {
  int? id;
  String quote;
  String authorName;

  DatabaseSecond_Model(
      {required this.id, required this.quote, required this.authorName});

  factory DatabaseSecond_Model.fromMap({required Map data}) {
    return DatabaseSecond_Model(
      id: data['id'],
      quote: data['quote'],
      authorName: data['author'],
    );
  }
}
