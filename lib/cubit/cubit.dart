import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/style/colors.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/fire.png',
          height: 25,
          width: 25,
          color: grey,
        ),
        label: 'Popular'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/science.png',
          height: 25,
          width: 25,
          color: grey,
        ),
        label: 'Science'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/olympic.png',
          height: 25,
          width: 25,
          color: grey,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Image.asset(
          'assets/images/settings.png',
          height: 25,
          width: 25,
          color: grey,
        ),
        label: 'Settings'),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;

    // if (index == 2) getSports();
    // if (index == 3) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> popular = [];

  void getPopular() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'apiKey': '8823a01cf90344379ea6986d615c67ed',
      'q': 'القدس',
      'from': '2023-8-1',
      'to': '2023-8-03',
      'sortBy': 'popularity'
    }).then((value) {
      popular = value.data['articles'];
      debugPrint(popular[0]['title'].toString());
      emit(NewsGetPopularSuccessState());
    }).catchError((error) {
      debugPrint('MyNaem 11 $error');
      emit(NewsGetPopularErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'apiKey': '8823a01cf90344379ea6986d615c67ed',
        'category': 'sports',
        'language': 'ar'
      }).then((value) {
        sports = value.data['articles'];
        debugPrint(sports[0]['title'].toString());
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'apiKey': '8823a01cf90344379ea6986d615c67ed',
        'category': 'science',
        'language': 'ar'
      }).then((value) {
        science = value.data['articles'];
        debugPrint(science[0]['title'].toString());
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }

    print('MEeeee');
    print('MEeeee $isDark');
  }

  List<dynamic> search = [];

  void getSearch(String q) {
    search = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'apiKey': '8823a01cf90344379ea6986d615c67ed',
      'q': q,
    }).then((value) {
      search = value.data['articles'];
      debugPrint(search[0]['title'].toString());
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      debugPrint('MyNaem 11 $error');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
