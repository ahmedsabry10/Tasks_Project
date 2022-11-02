import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/Data/Style/icon_broken.dart';
import 'package:tests/Data/components/components.dart';
import 'package:tests/Data/shared/cachehelper.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Screens/Auth_Screen/login_screen.dart';
import 'package:tests/Screens/Drawer_Screens/drawerScreens/profile_screen.dart';
import 'package:tests/Screens/MainScreens/home_layout.dart';
import 'package:tests/Screens/modules/archivedtasks/archivedtasks.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        // color:AppCubit.get(context).isDark? Colors.white:Colors.black,
        color: AppCubit.get(context).isDark? HexColor("#34495E"):Colors.white60,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: padding,
                child: Column(
                  children: [

                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                            onPressed: (){
                              navigateAndFinish(context, HomeLayout());
                            },
                            icon: Icon(
                              IconBroken.Close_Square,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    Container(
                      height: 120.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/splach.webp'
                            )
                        ),



                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    const SizedBox(height: 70),
                    buildMenuItem(
                      text: 'Update Profile',
                      icon: IconBroken.User,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Archived',
                      icon: Icons.archive_outlined,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: 'Dark Mode',
                      icon:Icons.brightness_4_outlined,
                      onClicked: () => selectedItem(context, 2),
                    ),

                    const SizedBox(height: 16),
                    defaultLine(),
                    const SizedBox(height: 10),
                    defaultLine(),
                    const SizedBox(height: 16),

                    buildMenuItem(
                      text: 'Log out',
                      icon: IconBroken.Logout,
                      onClicked: (){
                        CacheHelper.removeData(key: 'uId').then((value){
                          navigateAndFinish(context, LoginScreen());
                        });
                      },
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    const color = Colors.blue;
    const hoverColor = Colors.blue;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        navigateTo(context, ProfileScreen());
        break;

      case 1:
        navigateTo(context, ArchivedTask());
        break;

      case 2:
        AppCubit.get(context).changeAppMode();

        break;

      case 3:
        FirebaseAuth.instance.signOut();
        navigateAndFinish(context, LoginScreen());
        break;


    }
  }
}
