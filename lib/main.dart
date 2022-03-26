import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/home_layout.dart';
import 'package:tests/shared/shared.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(

        ),
        buttonTheme: ButtonThemeData(),
        drawerTheme: DrawerThemeData(
          backgroundColor: HexColor('#1C2833'),
        ),
        scaffoldBackgroundColor: HexColor('#1C2833'),
        primarySwatch: Colors.deepOrange,
        backgroundColor: HexColor('#1C2833'),
        appBarTheme: AppBarTheme(
          backgroundColor:  HexColor('#1C2833'),
          titleSpacing: 20.0,
          backwardsCompatibility: false,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: HexColor('#1C2833 '),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          backgroundColor: HexColor('#1C2833 '),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),

      ),
      home:Test(),
      debugShowCheckedModeBanner: false,
    );
  }
}

