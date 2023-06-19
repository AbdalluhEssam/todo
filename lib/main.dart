
import 'package:bloc/bloc.dart';
import 'package:course_udemy/modules/BMI/bmi_screen.dart';
import 'package:course_udemy/modules/login/login.dart';
import 'package:course_udemy/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';
import 'modules/counter/counter.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const HomeLayout(),
    );
  }
}

