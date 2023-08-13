import 'dart:async';
import 'dart:convert';
import 'package:news_app/screens/home/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/home/repository/repo.dart';
import '../../../models/NewsResponse.dart';
import '../../../models/SoursesResponse.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.baseRepo) : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  List<Sources> sources = [];
  List<Articles> news = [];
  BaseRepo baseRepo;


  void changeSource(int index) {
    selectedIndex = index;
    emit(HomeChangeSourcesState());
  }

  Future<void> getSources(String id) async {

    emit(HomeGetSourcesLoadingState());
    baseRepo.getSources(id).then((value) {
      var jsonResponse = jsonDecode(value.body);
      SoursesResponse soursesResponse = SoursesResponse.fromJson(jsonResponse);
      if (soursesResponse.status != "ok") {
        emit(HomeConnectionErrorState());
        return;
      }
      sources = soursesResponse.sources ?? [];
      emit(HomeGetSourcesSuccessState());
    }).catchError((error) {
      emit(HomeGetSourcesErrorState(error));
    });
  }

  Future<void> getNewsData({String? query}) async {

    emit(HomeGetNewsLoadingState());
    baseRepo.getNewsData( sources[selectedIndex].id??"").then((value) {
      var jsonResponse = jsonDecode(value.body);
      NewsResponse newsResponse = NewsResponse.fromJson(jsonResponse);
      if (newsResponse.status != "ok") {
        emit(HomeConnectionErrorState());
        return;
      }
      news = newsResponse.articles ?? [];
      emit(HomeGetNewsSuccessState());
      return;
    }).catchError((error) {
      emit(HomeGetNewsErrorState(error));
    });
  }
}
