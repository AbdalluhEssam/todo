import 'package:course_udemy/layout/news_app/cubit/states.dart';
import 'package:course_udemy/modules/news_app/business/business_modules.dart';
import 'package:course_udemy/modules/news_app/science/science.dart';
import 'package:course_udemy/modules/news_app/sports/sports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/news_app/setting/setting_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports_baseball), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science_outlined), label: "Science"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<Widget> bodyList = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingScreen(),
  ];


  List<dynamic> business = [];

  void getBusinessData(){
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
}
