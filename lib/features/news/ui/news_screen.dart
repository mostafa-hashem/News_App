import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/cubit/cubit.dart';
import 'package:news_app/features/news/cubit/states.dart';
import 'package:news_app/features/news/data/models/ctegory_model.dart';
import 'package:news_app/screens/tabs_screen.dart';

class NewsScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const NewsScreen(this.categoryModel, {super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    NewsCubit.get(context).getSources(widget.categoryModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        if (state is NewsGetNewsLoadingState ||
            state is NewsGetSourcesLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is NewsGetSourcesSuccessState) {
          NewsCubit.get(context).getNews();
        } else if (state is NewsGetSourcesErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(state.error),
            ),
          );
        } else if (state is NewsGetNewsSuccessState) {
          Navigator.pop(context);
        } else if (state is NewsChangeSourcesState) {
          NewsCubit.get(context).getNews();
        } else if (state is NewsGetNewsErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return TabsScreen(NewsCubit.get(context).sources);
      },
    );
  }
}
