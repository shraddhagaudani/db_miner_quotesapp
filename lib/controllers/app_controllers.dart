import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:db_miner_quotesapp/models/app_model.dart';
import 'package:db_miner_quotesapp/utills/all_atributes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/quotes_model.dart';
import 'package:db_miner_quotesapp/utills/helper/db_helper.dart';

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
    if (editingModel.textsize <= 29) {
      editingModel.textsize = editingModel.textsize + 1;
    }
    update();
  }

  decreaseTextSize() {
    if (editingModel.textsize >= 11) {
      editingModel.textsize = editingModel.textsize - 1;
    }

    update();
  }

}

class FavriouteController extends GetxController {
  List<DatabaseSecond_Model> favriouteList = [];

  addFavrioute({required DatabaseSecond_Model added}) async {
    favriouteList.add(added);

    update();
  }
}

class ThemeController extends GetxController {
  ThemeModel themeModel = ThemeModel(isdark: false);

  ChangeTheme() {
    themeModel.isdark = !themeModel.isdark;

    (Get.isDarkMode)
        ? Get.changeTheme(
            ThemeData(brightness: Brightness.light, useMaterial3: true),
          )
        : Get.changeTheme(
            ThemeData(brightness: Brightness.dark, useMaterial3: true),
          );
    update();
  }
}
