import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/home_layout.dart';
import 'package:tests/shared/cachehelper.dart';
import 'package:tests/shared/cubit/cubit.dart';
import 'package:tests/shared/cubit/states.dart';
import 'package:tests/shared/shared.dart';

import 'add_new_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool isDark=CacheHelper.getBoolean(key:'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase()..changeAppMode(
        fromShared: isDark,
      ),
      child: BlocConsumer <AppCubit ,AppStates>(
        listener:(context ,state){},
        builder: (context ,state){
          return MaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.dark,
                      statusBarColor: Colors.white,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    )),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                ),
                textTheme: TextTheme(bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ))),

            darkTheme: ThemeData(
              //#243447
                scaffoldBackgroundColor: HexColor('#34495E'),
                primarySwatch: Colors.blue,
                backgroundColor: HexColor('#34495E'),
                appBarTheme: AppBarTheme(
                  backgroundColor:  HexColor('#34495E'),
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarColor: HexColor('#34495E'),
                  ),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('#34495E'),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,

                    )
                )
            ),
            themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,

            home: HomeLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
