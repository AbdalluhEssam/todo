import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.sports;
        return cubit.sports.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.sports.length,
                itemBuilder: (context, index) =>
                    buildArticleItem(list[index], context),
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
