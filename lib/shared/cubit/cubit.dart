import 'package:course_udemy/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_taskes/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  Database? database;
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<Widget> bodyList = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> appBarTitle = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT)')
            .then((value) {
          print('database created');
        }).catchError((onError) {
          print("Erorr ${onError.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database open');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDBState());
    });
  }

  insertToDatabase(
      {required String? title,
      required String? date,
      required String? time}) async {
    await database!.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDBState());

        getDataFromDatabase(database).then((value) {
          newTasks = value;
          emit(AppGetDataFormDBState());
        });
      }).catchError((onError) {
        print("Error Insert ${onError.toString()}");
      });
      return null;
    }).catchError((onError) {
      print("Error in Insert ${onError.toString()}");
    });
  }

  void updateToDatabase({required String status, required int id}) {
    database!.rawUpdate(
      'UPDATE tasks SET status = ?  WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteFromDatabase({required int id}) {
    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  getDataFromDatabase(database) {
    newTasks.clear();
    doneTasks.clear();
    archiveTasks .clear();
    emit(AppGetDataFormDBLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      emit(AppGetDataFormDBState());
    });
  }

  void changeBottomSheet({required bool isShow}) {
    isBottomSheetShown = isShow;
    emit(AppChangBottomSheetState());
  }
}
