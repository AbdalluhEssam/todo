import 'package:course_udemy/shared/components/components.dart';
import 'package:course_udemy/shared/cubit/cubit.dart';
import 'package:course_udemy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDBState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldState,
            appBar: AppBar(
              title: Text(
                cubit.appBarTitle[cubit.currentIndex],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              foregroundColor: Colors.black,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  if (cubit.isBottomSheetShown) {
                    if (cubit.formKey.currentState!.validate()) {
                      await cubit.insertToDatabase(
                          title: cubit.titleController.text,
                          date: cubit.dateController.text,
                          time: cubit.timeController.text);
                    }
                  } else {
                    cubit.scaffoldState.currentState!
                        .showBottomSheet(
                            (context) => Container(
                                  padding: const EdgeInsets.all(20.0),
                                  color: Colors.white,
                                  child: Form(
                                    key: cubit.formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultTextFormField(
                                          controller: cubit.titleController,
                                          keyboardType: TextInputType.text,
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'title must not be empty';
                                            }
                                            return null;
                                          },
                                          labelText: "Task Title",
                                          icon: Icons.title,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        defaultTextFormField(
                                          controller: cubit.timeController,
                                          keyboardType: TextInputType.datetime,
                                          labelText: "Task Time",
                                          icon: Icons.watch_later_outlined,
                                          readOnly: true,
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) {
                                              cubit.timeController.text = value!
                                                  .format(context)
                                                  .toString();
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'title must not be empty';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        defaultTextFormField(
                                          controller: cubit.dateController,
                                          keyboardType: TextInputType.text,
                                          labelText: "Task Data",
                                          icon: Icons.calendar_month,
                                          readOnly: true,
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2025-05-03'),
                                            ).then((value) {
                                              cubit.dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value!);
                                            });
                                          },
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return 'title must not be empty';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            elevation: 25)
                        .closed
                        .then((value) {
                      cubit.changeBottomSheet(isShow: false);
                    });

                    cubit.changeBottomSheet(isShow: true);
                  }
                },
                child: cubit.isBottomSheetShown
                    ? const Icon(Icons.add)
                    : const Icon(Icons.edit)),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "Tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: "Done"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: "Archive"),
                ]),
            body: state is AppGetDataFormDBLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.bodyList[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
