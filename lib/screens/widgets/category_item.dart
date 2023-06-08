import 'package:flutter/material.dart';
import 'package:news_app/models/ctegory_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryModel categoryModel;
  int index;

  CategoryItem(this.categoryModel, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: categoryModel.color,
          borderRadius: BorderRadius.only(
              topRight: const Radius.circular(30),
              topLeft: const Radius.circular(30),
              bottomRight: index.isOdd ? const Radius.circular(30) : Radius.zero,
              bottomLeft: index.isEven ? const Radius.circular(30) : Radius.zero)),
      child: Column(
        children: [
          Image.asset(
            categoryModel.image,
            height: 120,
          ),
          Expanded(
            child: Center(
              child: Text(
                categoryModel.name,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}