import 'package:course_udemy/layout/news_app/cubit/cubit.dart';
import 'package:course_udemy/layout/news_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.business;
        return cubit.business.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.business.length,
                itemBuilder: (context, index) => buildArticleItem(list[index],context),
                separatorBuilder: (BuildContext context, int index) {
                  return myDivider();
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
