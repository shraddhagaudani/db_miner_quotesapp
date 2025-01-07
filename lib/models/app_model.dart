import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialvalModel {
  String? initialval;

  InitialvalModel({required this.initialval});
}

class EditingModel {
  double textsize;
  double letterspacing;

  EditingModel({
    required this.textsize,
    required this.letterspacing,
  });
}


// wallpaper
class ImageModel {
  String image;
  String user;
  String userImageUrl;

  ImageModel(
      {required this.image, required this.user, required this.userImageUrl});

  factory ImageModel.fromMap({required Map data}) {
    return ImageModel(
        image: data['largeImageURL'],
        user: data['user'],
        userImageUrl: data['userImageURL']);
  }
}

class ThemeModel {
  bool isdark;

  ThemeModel({required this.isdark});
}
