import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/models/ctegory_model.dart';
import 'package:news_app/screens/home/cubit/cubit.dart';
import 'package:news_app/screens/home/cubit/states.dart';
import 'package:news_app/screens/home/repository/dto/local.dart';
import 'package:news_app/screens/home/repository/dto/remote.dart';
import 'package:news_app/screens/tabs_screen.dart';

class NewsScreen extends StatefulWidget {
  CategoryModel categoryModel;

  NewsScreen(this.categoryModel, {super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late StreamSubscription subscription;
  var isDeviceConnected = true;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(isDeviceConnected ? RemoteRepo() : LocalRepo())
            ..getSources(widget.categoryModel.id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeGetNewsLoadingState ||
              state is HomeGetSourcesLoadingState) {
            showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                      title: Center(child: CircularProgressIndicator()),
                    ));
          } else if (state is HomeGetSourcesSuccessState) {
            HomeCubit.get(context).getNewsData();
          } else if (state is HomeGetSourcesErrorState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(state.error),
                    ));
          } else if (state is HomeGetNewsSuccessState) {
            Navigator.pop(context);
          } else if (state is HomeChangeSourcesState) {
            HomeCubit.get(context).getNewsData();
          } else if (state is HomeGetNewsErrorState) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(state.error),
                    ));
          }
        },
        builder: (context, state) {
          return TabsScreen(HomeCubit.get(context).sources);
        },
      ),
    );
    // return FutureBuilder(
    //   future: ApiManager.getSources(categoryModel.id),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.hasError) {
    //       return Column(
    //         children: [
    //           const Text("Something went wrong"),
    //           TextButton(
    //             onPressed: () {},
    //             child: const Text("Try Again"),
    //           )
    //         ],
    //       );
    //     }
    //     if (snapshot.data?.status != "ok") {
    //       return Column(
    //         children: [
    //           Text(snapshot.data?.message??""),
    //           TextButton(
    //             onPressed: () {},
    //             child: const Text("Try Again"),
    //           )
    //         ],
    //       );
    //     }
    //     var sources = snapshot.data?.sources ?? [];
    //     return TabsScreen(sources);
    //   },
    // );
  }
}
