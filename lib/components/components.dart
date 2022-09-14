import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
Widget buildTaskItem (Map model , context) =>  Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: HexColor('#E5E7E9'),
            offset: const Offset(0, 0),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          )
        ],

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
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white60,
                    offset: const Offset(0, 0),
                    blurRadius: 2.0,
                    spreadRadius: 6.0,
                  )
                ],

              ),
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
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey ,
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
                  Icons.check_box ,
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