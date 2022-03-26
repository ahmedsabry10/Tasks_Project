import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tests/components/components.dart';
import 'package:tests/shared/cubit/cubit.dart';
import 'package:tests/shared/cubit/states.dart';

class ArchivedTask extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context ,state) {

        },
        builder:(context ,state){
          var tasks =AppCubit.get(context).archivedTasks;
          return ConditionalBuilder(
            condition: tasks.length > 0,
            builder:(context)=> ListView.separated(
              itemBuilder: (context,index)=>buildTaskItem(tasks[index] , context),
              separatorBuilder: (context,index)=>Container(
                width: double.infinity,
                height: 1.0,
                color: HexColor('#283747'),
              ),
              itemCount: tasks.length,
            ),
            fallback: (context)=> Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.archive_rounded,
                    size: 100.0,
                    color: Colors.grey,
                  ) ,
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'No Archived Tasks Yet' ,
                    style: TextStyle(
                      color: Colors.grey ,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold ,
                    ),
                  ),

                ],
              ),
            ),
          );
        }

    );
  }
}
