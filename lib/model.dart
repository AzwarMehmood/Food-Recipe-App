import 'dart:core';
import 'package:flutter/cupertino.dart';

class RecipeModel {
  late String applabel;
  late double appcalories;
  late String appImgurl;
  late String appurl;

  RecipeModel(
      {required this.applabel,
      required this.appcalories,
      required this.appImgurl,
      required this.appurl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': applabel,
      'calories': appcalories,
      'image': appImgurl,
      'url': appurl,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      applabel: (map['label'] ?? '') as String,
      appcalories: (map['calories'] ?? ''),
      appImgurl: (map['image'] ?? '') as String,
      appurl: (map['url'] ?? '') as String,
    );
  }
}
