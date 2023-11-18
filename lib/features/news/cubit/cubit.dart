import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/cubit/states.dart';
import 'package:news_app/features/news/data/models/NewsResponse.dart';
import 'package:news_app/features/news/data/models/SourcesResponse.dart';
import 'package:news_app/features/news/data/services/api_services.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitState());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);
  ApiServices apiServices = ApiServices();

  int selectedIndex = 0;
  List<Sources> sources = [];
  List<Articles> news = [];

  void changeSource(int index) {
    selectedIndex = index;
    emit(NewsChangeSourcesState());
  }

  Future<void> getSources(String id) async {
    emit(NewsGetSourcesLoadingState());
    try {
      final sourcesResponse = await apiServices.getSources(id);
      sources = sourcesResponse.sources ??[];
      emit(NewsGetSourcesSuccessState());
    } catch (e) {
      emit(NewsGetSourcesErrorState(e.toString()));
    }
  }

  Future<void> getNews({String? query}) async {
    emit(NewsGetNewsLoadingState());
    try {
      final newsResponse = await apiServices.getNews(sources[selectedIndex].id!);
      news = newsResponse.articles ?? [];
      emit(NewsGetNewsSuccessState());
    } catch (e) {
      emit(NewsGetNewsErrorState(e.toString()));
    }
  }

}
