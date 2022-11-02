import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tests/Data/Models/user_model.dart';
import 'package:tests/Data/constanse/constanse.dart';
import 'package:tests/Data/shared/cubit/AppCubit/states.dart';
import 'package:tests/Screens/modules/donetasks/donetasks.dart';
import 'package:tests/Screens/modules/newtasks/newtasks.dart';


import '../../cachehelper.dart';

class AppCubit extends Cubit <AppStates>{
  AppCubit ():super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex=0;
  List <Widget> screen=[
    NewTask(),
    DoneTask(),
  ];

  void changeIndex(int index){
    currentIndex =index;
    emit(AppChangeBottomNavBarState());
  }


  Database database ;

  List <Map> newTasks =[];
  List <Map> doneTasks =[];
  List <Map> archivedTasks =[];


  UserModel userModel ;


  //get user
  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());

      print(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  // update users
  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  }) {
    emit(UserUpdateLoadingState());
    UserModel socialUserModel = UserModel(
      uId: uId,
      email: userModel.email ?? 'your mail',
      image: image ??
          userModel.image ??
          'https://img.freepik.com/premium-photo/3d-rendering-3d-illustration-people-avatar-icon-isolated-white-background_640106-552.jpg?size=626&ext=jpg&uid=R78364619&ga=GA1.2.140343669.1662316312',
      cover: cover ??
          userModel.cover ??
          'https://img.freepik.com/free-photo/abstract-luxury-gradient-blue-background-smooth-dark-blue-with-black-vignette-studio-banner_1258-82801.jpg?size=626&ext=jpg&uid=R78364619&ga=GA1.2.140343669.1662316312',
      name: name ?? 'Name',
      phone: phone ?? 'Number Phone',
      bio: bio ?? 'your bio',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(socialUserModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UserUpdateErrorState());
    });
  }


// داله ال create
  void createDataBase () {
    openDatabase(
        'todo.db',
        version: 1 ,
        onCreate: (database , version){
          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT ,time TEXT ,date TEXT ,details TEXT,status TEXT)').then((value) {
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
    @required String details ,
  }) async {
  await database.transaction((txn) {
      txn
          .rawInsert('INSERT INTO tasks (title ,time ,date,details ,status) VALUES ("$title" ,"$time" ,"$date","$details" ,"new")',
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
