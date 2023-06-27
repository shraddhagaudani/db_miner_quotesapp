import 'package:db_miner_quotesapp/models/app_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/quotes_model.dart';

class QuotesController extends GetxController{
  String? data;
  List<  QuotesFirstMap_Model> quotesList = [];

  InitialvalModel initialvalModel = InitialvalModel(initialval: null,);

}