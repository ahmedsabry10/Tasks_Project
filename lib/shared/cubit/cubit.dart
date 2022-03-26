import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tests/modules/archivedtasks/archivedtasks.dart';
import 'package:tests/modules/donetasks/donetasks.dart';
import 'package:tests/modules/newtasks/newtasks.dart';
import 'package:tests/shared/cubit/states.dart';

import '../cachehelper.dart';

class AppCubit extends Cubit <AppStates>{
  AppCubit ():super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List <Widget> screen=[
    NewTask(),
    DoneTask(),
    ArchivedTask(),
  ];
  List <String> titles =[
    'Add New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void changeIndex(int index){
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }


  Database database ;

  List <Map> newTasks =[];
  List <Map> doneTasks =[];
  List <Map> archivedTasks =[];



// داله ال create
  void createDataBase () {
    openDatabase(
        'todo.db',
        version: 1 ,
        onCreate: (database , version){
          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT ,time TEXT ,date TEXT ,status TEXT)').then((value) {
            print ('created table');
          }).catchError((error){
            print ('error when created table ${error.toString()}');
          });
        },
        onOpen: (database){
          getDataFromDatabase(database);
          print('Database Opened');
        }
    ).then((value) {
      database =value ;
      emit(AppCreateDatabaseState());
    });
  }

  // داله ال insert
 insertToDatabase ({
    @required String title ,
    @required String time ,
    @required String date ,

  }) async {
  await database.transaction((txn) {
      txn
          .rawInsert('INSERT INTO tasks (title ,time ,date ,status) VALUES ("$title" ,"$time" ,"$date" ,"new")',
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error){
        print('error when Inserting New Record ${error.toString()}');
      });
      return null ;
    });
  }



  // داله ال update

  void updateDatabase ({
    @required String status,
    @required int id ,
}){
    database.rawUpdate('UPDATE tasks SET status =? WHERE id = ?' ,
    ['$status' , id ]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
}
  void deleteDatabase ({
    @required int id ,
  }){
    database.rawDelete('DELETE FROM tasks WHERE id =?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }


// داله ال get
  getDataFromDatabase (database)  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element){
        if (element ['status']=='new') newTasks.add(element);
        else if (element ['status']=='done') doneTasks.add(element);
        else archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;
  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
}){
    isBottomSheetShown=isShow;
    fabIcon =icon ;
    emit(AppChangeBottomSheetState());
  }


  bool isDark=false;
  void changeAppMode({bool fromShared})
  {
    if(fromShared != null){
      isDark=fromShared;
      emit(AppChangeModeStates());
    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark
      ).then((value) {
        emit(AppChangeModeStates());
      });
    }

  }
}
