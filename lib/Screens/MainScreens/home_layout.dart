import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/Data/Style/icon_broken.dart';
import 'package:tests/Data/components/components.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Data/shared/cubit/AppCubit/states.dart';

import 'package:tests/Screens/MainScreens/add_new_task_screen.dart';
import 'package:tests/Screens/modules/archivedtasks/archivedtasks.dart';



class HomeLayout extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates states) {
        if (states is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      },
      builder: (BuildContext context, AppStates states) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  navigateTo(context, ArchivedTask());
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: AppCubit.get(context).isDark ?Colors.white :Colors.black,
                )),

            actions: [
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  )),
            ],
          ),
          body: ConditionalBuilder(
            condition: true,
            builder: (context) => cubit.screen[cubit.currentIndex],
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddNewTasks());
            },
            child: Icon(
              cubit.fabIcon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Tick_Square,
                ),
                label: 'Done',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
              /*  setState(() {
              currentIndex=index;
            });*/
            },
          ),
        );
      },
    );
  }
}
