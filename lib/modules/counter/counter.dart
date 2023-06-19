import 'package:course_udemy/modules/counter/cubit/cubit.dart';
import 'package:course_udemy/modules/counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterMinusState) {
            // print("CounterMinusState ${state.counter}");
          }
          if (state is CounterPlusState) {
            // print("CounterPlusState ${state.counter}");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: const Text("MINUS")),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: const Text("PLUS")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
