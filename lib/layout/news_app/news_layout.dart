import 'package:course_udemy/layout/news_app/search/search_screen.dart';
import 'package:course_udemy/shared/components/components.dart';
import 'package:course_udemy/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var cubitDark = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {
                    cubitDark.changeDarkModeSheet();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                    size: 30,
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () {
          //
          //     },
          //     child: const Icon(Icons.add)),
          body: cubit.bodyList[cubit.currentIndex],
        );
      },
    );
  }
}
