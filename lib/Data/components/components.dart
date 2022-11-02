import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';


void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = HexColor('#175396');
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber[300];
      break;
  }

  return color;
}


var scaffoldKey= GlobalKey<ScaffoldState>();
void navigateTo (context ,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context)=>widget),);

Widget buildNewTaskItem (Map model , context) =>  Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color:AppCubit.get(context).isDark ? HexColor('#2E4053'): Colors.grey[50],
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,


          children: [
            //date and title
            Row(
              children: [


                //title
                Expanded(
                  child: Text(
                    '${model['title']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color:Colors.blue,

                    ),
                  ),
                ) ,


                SizedBox(
                  width: 20.0,
                ),

                //date
                Text(
                  '${model['date']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: AppCubit.get(context).isDark ? Colors.white: Colors.black,

                      fontSize: 15.0
                  ),
                ),



              ],

            ),

            //details


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color:AppCubit.get(context).isDark ? HexColor('#283747'):Colors.grey[300],
                  elevation: 7.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      '${model['details']}',
                      style: TextStyle(
                          color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                          fontSize: 15.0
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //icons and time
            Row(
              children: [
                Text(
                  '${model['time']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                  ),
                ),
                Spacer(),

                IconButton(

                    onPressed:(){
                      AppCubit.get(context).updateDatabase(status: 'done', id:model['id']);
                    },
                    icon: Icon(
                      Icons.check_circle_rounded ,
                      color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                      size: 20.0,

                    )),
                IconButton(
                    onPressed:(){
                      AppCubit.get(context).updateDatabase(status: 'archived', id:model['id']);
                    },
                    icon: Icon(
                      Icons.archive_rounded ,
                      color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                      size: 20.0,
                    )),
              ],
            )
          ],
        ),
      ),
    ),
  ),
  onDismissed: (direction){
  AppCubit.get(context).deleteDatabase( id:model['id'],);
  },
);

Widget buildDoneTaskItem (Map model , context) =>   Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color:AppCubit.get(context).isDark ? HexColor('#2E4053'): Colors.grey[50],
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            SizedBox(
              width: 10.0,
            ),

            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.grey[50],
              elevation: 7.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${model['time']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color:Colors.blue,

                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Text(
                    '${model['date']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppCubit.get(context).isDark ? Colors.white: Colors.black,

                        fontSize: 12.0
                    ),
                  ),
                ],
              ),
            ) ,


            SizedBox(
              width: 20.0,
            ),


            IconButton(

                onPressed:(){
                  AppCubit.get(context).updateDatabase(status: 'new', id:model['id']);
                },
                icon: Icon(
                  Icons.info_rounded ,
                  color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                )),

            IconButton(
                onPressed:(){
                  AppCubit.get(context).updateDatabase(status: 'archived', id:model['id']);
                },
                icon: Icon(
                  Icons.archive ,
                  color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                )),


          ],

        ),
      ),
    ),
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase( id:model['id'],);
  },
);

Widget buildArchivedTaskItem (Map model , context) =>   Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color:AppCubit.get(context).isDark ? HexColor('#2E4053'): Colors.grey[50],
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(
              width: 10.0,
            ),

            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.grey[50],
              elevation: 7.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${model['time']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color:Colors.blue,

                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Text(
                    '${model['date']}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: AppCubit.get(context).isDark ? Colors.white: Colors.black,

                        fontSize: 12.0
                    ),
                  ),
                ],
              ),
            ) ,


            SizedBox(
              width: 20.0,
            ),

            IconButton(

                onPressed:(){
                  AppCubit.get(context).updateDatabase(status: 'new', id:model['id']);
                },
                icon: Icon(
                  Icons.unarchive ,
                  color: AppCubit.get(context).isDark ? Colors.white: Colors.black,
                )),

          ],

        ),
      ),
    ),
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase( id:model['id'],);
  },
);









void navigateAndFinish(context ,widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context)=>widget
  ),
      (Route <dynamic> route)=>false,
);
