import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/Data/components/components.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Data/shared/cubit/AppCubit/states.dart';

class ArchivedTask extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context ,state) {

        },
        builder:(context ,state){
          var tasks =AppCubit.get(context).archivedTasks;
          return Scaffold(
            appBar: AppBar(
              /*
              leading: IconButton(
                  onPressed:(){
                    navigateAndFinish(context , HomeLayout());
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new ,
                    color: Colors.grey,
                  )),

               */
            ),
            body: ConditionalBuilder(
              condition: tasks.length > 0,
              builder:(context)=> ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildArchivedTaskItem(tasks[index] , context),
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
                      Icons.archive_rounded,
                      size: 100.0,
                      color: AppCubit.get(context).isDark ?Colors.white :Colors.black,
                    ) ,
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'No Archived Tasks Yet' ,
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
}
