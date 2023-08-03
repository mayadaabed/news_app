abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewsGetBusinessLoadingState extends NewsState {}

class NewsGetPopularSuccessState extends NewsState {}

class NewsGetPopularErrorState extends NewsState {
  late String error;

  NewsGetPopularErrorState(this.error);
}

class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErrorState extends NewsState {
  late String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErrorState extends NewsState {
  late String error;

  NewsGetScienceErrorState(this.error);
}

class AppChangeModeState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchLoadingState extends NewsState {}

class NewsGetSearchErrorState extends NewsState {
  late String error;

  NewsGetSearchErrorState(this.error);
}