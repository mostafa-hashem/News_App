abstract class NewsStates {}

class NewsInitState extends NewsStates {}

class NewsConnectionErrorState extends NewsStates {}

class NewsGetSourcesLoadingState extends NewsStates {}

class NewsGetSourcesSuccessState extends NewsStates {}

class NewsChangeSourcesState extends NewsStates {}

class NewsGetSourcesErrorState extends NewsStates {
  String error;

  NewsGetSourcesErrorState(this.error);
}

class NewsGetNewsLoadingState extends NewsStates {}

class NewsGetNewsSuccessState extends NewsStates {}

class NewsGetNewsErrorState extends NewsStates {
  String error;

  NewsGetNewsErrorState(this.error);
}
