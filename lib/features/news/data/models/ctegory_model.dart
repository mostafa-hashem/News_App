import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  Color color;

  CategoryModel(this.id, this.name, this.image, this.color);

  static List<CategoryModel>getCategories(){
    return [
      CategoryModel("business", "Business", "assets/images/business.png", const Color(0xffCF7E48)),
      CategoryModel("entertainment", "Entertainment", "assets/images/environment.png", const Color(0xff4882CF)),
      CategoryModel("general", "General", "assets/images/general.png", const Color(0xff58c926)),
      CategoryModel("sports", "Sports", "assets/images/ball.png", const Color(0xffC91C22)),
      CategoryModel("science", "Science", "assets/images/science.png", const Color(0xffF2D352)),
      CategoryModel("health", "Health", "assets/images/health.png", const Color(0xffED1E79)),
      CategoryModel("technology", "Technology", "assets/images/technology.png", const Color(0xff003E90)),
    ];
  }
}
