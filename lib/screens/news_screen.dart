import 'package:flutter/material.dart';
import 'package:news_app/models/ctegory_model.dart';
import 'package:news_app/screens/tabs_screen.dart';
import 'package:news_app/shared/network/remot/api_manager.dart';

class NewsScreen extends StatelessWidget {
  CategoryModel categoryModel;

  NewsScreen(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(categoryModel.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              const Text("Something went wrong"),
              TextButton(
                onPressed: () {},
                child: const Text("Try Again"),
              )
            ],
          );
        }

        if (snapshot.data?.status != "ok") {
          return Column(
            children: [
              Text(snapshot.data?.message??""),
              TextButton(
                onPressed: () {},
                child: const Text("Try Again"),
              )
            ],
          );
        }
        var sources = snapshot.data?.sources ?? [];
        return TabsScreen(sources);
      },
    );
  }
}