import 'package:course_udemy/layout/news_app/cubit/cubit.dart';
import 'package:course_udemy/layout/news_app/cubit/states.dart';
import 'package:course_udemy/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return SafeArea(
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.navigate_before)),
                      Expanded(
                        child: defaultTextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            labelText: 'Search',
                            icon: Icons.search,
                            onChanged: (val) {
                              NewsCubit.get(context).getSearchData(val);
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Search must not be Empty';
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: ((context, index) =>
                      buildArticleItem(list[index], context)),
                  itemCount: list.length,
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
