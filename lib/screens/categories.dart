import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/models/ctegory_model.dart';
import 'package:news_app/screens/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  Function onCategorySelect;

  CategoriesScreen(this.onCategorySelect);

  var categories = CategoryModel.getCategories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 0.02.sh,),
          Center(
            child: Text(
              "Pick your category of interest",
              style: Theme.of(context).textTheme.bodyMedium
            ),
          ),
          SizedBox(height: 0.05.sh,),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      onCategorySelect(categories[index]);
                    },
                    child: CategoryItem(categories[index], index));
              },
              itemCount: categories.length,
            ),
          )
        ],
      ),
    );
  }
}