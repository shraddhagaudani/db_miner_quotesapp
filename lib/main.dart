import 'package:db_miner_quotesapp/utills/apptheme_utills.dart';
import 'package:db_miner_quotesapp/views/screens/editpage.dart';
import 'package:db_miner_quotesapp/views/screens/favrioute_page.dart';
import 'package:db_miner_quotesapp/views/screens/home_page.dart';
import 'package:db_miner_quotesapp/views/screens/jsonquote_detailspage.dart';
import 'package:db_miner_quotesapp/views/screens/splash_screen.dart';
import 'package:db_miner_quotesapp/views/screens/wallpaper_detailspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main()async {
 await  GetStorage.init();

 
  runApp(
    GetMaterialApp(
      theme: AppTheme.lighttheme,
      darkTheme: AppTheme.darktheme,
      initialRoute: 'splashscreen',
      getPages: [
        GetPage(name: '/', page: () => const Home_page()),
        GetPage(name: '/splashscreen', page: () => const Splash_screen()),
        GetPage(
            name: '/jsonquote_detailpage',
            page: () => const JsonQuote_detailpage()),
        GetPage(name: '/edit_page', page:()=> const EditPage()),
        GetPage(name: '/wallpaper_detailspage', page:()=> const Wallpaper_detailspage()),

        GetPage(name: '/favourite_page', page: () => const Favrioute_page()),
      ],
      debugShowCheckedModeBanner: false,
    ),
  );
}
//XuFcx3h7L0ZC66h5r5LUTitpoMLAuVLu

//5892563476b0bf442b920ff19c5ed023

//ninjas api key:
//RKGssZDOSiBf6B2FUeK7uA==e2ciGyJRrwugxiIQ
