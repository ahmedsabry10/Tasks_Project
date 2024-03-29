import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/Data/constanse/constanse.dart';
import 'package:tests/Data/shared/cachehelper.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Data/shared/cubit/AppCubit/states.dart';
import 'package:tests/Data/shared/shared.dart';
import 'package:tests/Screens/Auth_Screen/login_screen.dart';
import 'package:tests/Screens/MainScreens/home_layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  bool isDark=CacheHelper.getBoolean(key:'isDark');
  uId = CacheHelper.getData(key: 'uId');
  if(uId != null)
  {
    widget = HomeLayout();
  } else
  {
    widget = LoginScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData()..createDataBase()..changeAppMode(
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
                )
                ),
                fontFamily: 'Jannah'

            ),

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
                  unselectedItemColor: Colors.white,
                  backgroundColor: HexColor('#34495E'),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,

                    )
                ),
                fontFamily: 'Jannah'

            ),

            themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,

            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
