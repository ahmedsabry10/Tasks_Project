import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/modules/donetasks/donetasks.dart';
import 'package:tests/modules/newtasks/newtasks.dart';
import 'package:tests/shared/cubit/cubit.dart';

void navigateTo (context ,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context)=>widget),);

class Components extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
Widget buildNewTaskItem (Map model , context) =>  Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.grey[50],
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            /*
                CircleAvatar(
                  radius: 35.0,
                  child: Text(
                    //'${model['time']}',
                    '6:10 PM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),




                 */

            SizedBox(
              width: 10.0,
            ),

            Container(
              height: 50.0,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3.0,

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
                          fontSize: 18.0,
                          color: Colors.grey
                      ),
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
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.black ,
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
                  AppCubit.get(context).updateDatabase(status: 'done', id:model['id']);
                },
                icon: Icon(
                  Icons.check_circle_rounded ,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed:(){
                   AppCubit.get(context).updateDatabase(status: 'archived', id:model['id']);
                },
                icon: Icon(
                  Icons.archive_rounded ,
                  color: Colors.grey,
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

Widget buildDoneTaskItem (Map model , context) =>   Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.grey[50],
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            /*
                CircleAvatar(
                  radius: 35.0,
                  child: Text(
                    //'${model['time']}',
                    '6:10 PM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),




                 */

            SizedBox(
              width: 10.0,
            ),

            Container(
              height: 50.0,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3.0,

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
                          fontSize: 18.0,
                          color: Colors.grey
                      ),
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
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                        color: Colors.black ,
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
                  color: Colors.grey,
                )),

            IconButton(
                onPressed:(){
                  AppCubit.get(context).updateDatabase(status: 'archived', id:model['id']);
                },
                icon: Icon(
                  Icons.archive ,
                  color: Colors.grey,
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
      color: Colors.grey[50],
      elevation: 7.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            /*
                CircleAvatar(
                  radius: 35.0,
                  child: Text(
                    //'${model['time']}',
                    '6:10 PM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),




                 */

            SizedBox(
              width: 10.0,
            ),

            Container(
              height: 50.0,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 3.0,

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
                          fontSize: 18.0,
                          color: Colors.grey
                      ),
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
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                        color: Colors.black ,
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
                  color: Colors.grey,
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
