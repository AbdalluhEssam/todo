// ignore_for_file: avoid_print

import 'package:course_udemy/layout/news_app/cubit/states.dart';
import 'package:course_udemy/modules/news_app/business/business_modules.dart';
import 'package:course_udemy/modules/news_app/science/science.dart';
import 'package:course_udemy/modules/news_app/sports/sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball), label: "Sports"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: "Science"),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 1) {
    //   getSportsData();
    // }
    // if (index == 2) {
    //   getScienceData();
    // }

    emit(NewsBottomNavState());
  }

  List<Widget> bodyList = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<dynamic> search = [];

  void getSearchData(String value) {
    search.clear();
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: "v2/everything", query: {
      'q': value,
      'apiKey': '4033929973e24c1ba9a5b46d5756867b',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: "v2/top-headlines", query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '4033929973e24c1ba9a5b46d5756867b',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSportsData() {
    if (sports.isEmpty) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '4033929973e24c1ba9a5b46d5756867b',
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScienceData() {
    if (science.isEmpty) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '4033929973e24c1ba9a5b46d5756867b',
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
