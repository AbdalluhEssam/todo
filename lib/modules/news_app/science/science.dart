import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.science;
        return cubit.science.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.science.length,
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
