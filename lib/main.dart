import 'package:course_udemy/modules/home.dart';
import 'package:course_udemy/shared/bloc_observer.dart';
import 'package:course_udemy/shared/cubit/cubit.dart';
import 'package:course_udemy/shared/cubit/states.dart';
import 'package:course_udemy/shared/network/local/cache_helper.dart';
import 'package:course_udemy/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/news_app/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({Key? key, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppCubit()..changeDarkModeSheet(formShared: isDark!),
        ),
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessData()
            ..getSportsData()
            ..getScienceData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                primaryColor: Colors.deepOrange,
                progressIndicatorTheme:
                    const ProgressIndicatorThemeData(color: Colors.deepOrange),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark),
                  color: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                primarySwatch: Colors.blue,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    elevation: 20,
                    backgroundColor: Colors.white),
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))),
            themeMode: AppCubit.get(context).isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData(
                iconTheme: const IconThemeData(color: Colors.white),
                scaffoldBackgroundColor: Colors.black26,
                primaryColor: Colors.deepOrange,
                progressIndicatorTheme:
                    const ProgressIndicatorThemeData(color: Colors.deepOrange),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black26,
                      statusBarIconBrightness: Brightness.light),
                  color: Colors.black26,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                primarySwatch: Colors.blue,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    elevation: 20,
                    backgroundColor: Colors.black26),
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ))),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
