abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeConnectionErrorState extends HomeStates {}

class HomeGetSourcesLoadingState extends HomeStates {}

class HomeGetSourcesSuccessState extends HomeStates {}

class HomeChangeSourcesState extends HomeStates {}

class HomeGetSourcesErrorState extends HomeStates {
  String error;

  HomeGetSourcesErrorState(this.error);
}

class HomeGetNewsLoadingState extends HomeStates {}

class HomeGetNewsSuccessState extends HomeStates {}

class HomeGetNewsErrorState extends HomeStates {
  String error;

  HomeGetNewsErrorState(this.error);
}
