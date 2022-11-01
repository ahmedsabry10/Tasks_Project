import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/components/components.dart';
import 'package:tests/shared/cubit/cubit.dart';
import 'package:tests/shared/cubit/states.dart';

class NewTask extends StatelessWidget {


  var scaffoldKey= GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
      listener: (context ,state) {

      },
      builder:(context ,state){
        var tasks =AppCubit.get(context).newTasks;
      return Scaffold(
        key: scaffoldKey,
        body: ConditionalBuilder(
          condition: tasks.length > 0,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),

            itemBuilder: (context,index)=>buildNewTaskItem2 (tasks[index] , context),

            separatorBuilder: (context,index)=>SizedBox(
              height: 0.00001,
            ),
            itemCount: tasks.length,
          ),

          fallback: (context)=> Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_rounded,
                  size: 100.0,
                  color: AppCubit.get(context).isDark ?Colors.white :Colors.black,
                ) ,
                SizedBox(
                  height: 20.0,
                ),
                Text(
                    'No Tasks yet, Enter Some' ,
                    style: TextStyle(
                      color: AppCubit.get(context).isDark ?Colors.white :Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold ,
                    ),
                ),

              ],
            ),
          ),
    ),
      );
    }

    );
  }
  Widget buildNewTaskItem2 (Map model , context) =>  Dismissible(
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

                  IconButton(onPressed: (){
                    scaffoldKey.currentState.showBottomSheet((context) =>Container(
                      color:AppCubit.get(context).isDark ? HexColor('#283747'):Colors.grey[300],
                      width: double.infinity,
                      child: Card(
                        color:AppCubit.get(context).isDark ? HexColor('#283747'):Colors.grey[300],

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
                    ), );
                  },
                      icon: Icon(
                          Icons.arrow_drop_down,
                        color: AppCubit.get(context).isDark ? Colors.white: Colors.black,

                      ))
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
}
