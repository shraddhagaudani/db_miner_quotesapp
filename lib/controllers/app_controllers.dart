import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:db_miner_quotesapp/models/app_model.dart';
import 'package:db_miner_quotesapp/utills/all_atributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/quotes_model.dart';

class QuotesController extends GetxController {
  InitialvalModel initialvalModel = InitialvalModel(
    initialval: null,
  );
}

class TrueOrFalseValController extends GetxController {
  TrueOrFalseAccessModel trueOrFalseAccessModel = TrueOrFalseAccessModel(
    trueorfalsevalforcategory: false,
    truefalsevalfordetailspage: false,
  );

  void TrueOrFalsevalueforquotes() {
    trueOrFalseAccessModel.trueorfalsevalforcategory = true;

    checkValue.write("trueorfalsevalforcategory",
        trueOrFalseAccessModel.trueorfalsevalforcategory);
    update();
  }

  Truefalsevaluefordetailspage() {
    trueOrFalseAccessModel.truefalsevalfordetailspage = true;

    checkValue.write("truefalsevalfordetailspage",
        trueOrFalseAccessModel.truefalsevalfordetailspage);
  }
}

class NavigationController extends GetxController {
  int initialval = 0;

  PageController pageController = PageController();
}

class EditingController extends GetxController {
  EditingModel editingModel = EditingModel(textsize: 16, letterspacing: 1.0);

  increaseTextSize() {


    if (editingModel.textsize <= 30) {
      editingModel.textsize = editingModel.textsize + 1.8;
    }
    update();
  }

  decreaseTextSize() {
    if (editingModel.textsize >= 12) {
      editingModel.textsize = editingModel.textsize - 1.8;
    }

    update();
  }

  letterSpacing() {
    if (editingModel.letterspacing > 0.1) {
     editingModel.letterspacing -= 0.1;
    }
    update();
  }
}
