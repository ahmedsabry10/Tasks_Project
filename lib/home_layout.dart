import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tests/shared/cubit/cubit.dart';
import 'package:tests/shared/cubit/states.dart';

import 'components/components.dart';

class Test extends StatelessWidget {


  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {
          if(states is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screen[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                    );
                  }
                }
                else {
                  scaffoldKey.currentState.showBottomSheet((context) =>
                      Container(
                        padding: EdgeInsets.all(20.0),
                        color:HexColor('#2C3E50'),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  labelText: 'Task Title',
                                  labelStyle: TextStyle(
                                    color: HexColor('#424949')
                                  ),
                                  prefixIcon: Icon(
                                    Icons.title,
                                      color: HexColor('#424949')
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Should enter title';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: timeController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  labelText: 'Task time',
                                  labelStyle: TextStyle(
                                      color: HexColor('#424949')
                                  ),
                                  prefixIcon: Icon(
                                    Icons.watch_later_outlined,
                                      color: HexColor('#424949')
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Should enter title';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value.format(context).toString();
                                    print(value.format(context));
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                controller: dateController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Should enter date';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  labelText: 'Task Date',
                                  labelStyle: TextStyle(
                                      color: HexColor('#424949')
                                  ),
                                  prefixIcon: Icon(
                                    Icons.calendar_today,
                                      color: HexColor('#424949')
                                  ),
                                ),
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2100-10-10'))
                                      .then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    elevation: 10.0,
                  ).closed.then((value){
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit ,);
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add ,);
                }
              },
              child: Icon(
                cubit.fabIcon,
              ),
            ),




            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_rounded,
                  ),
                  label: 'tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_rounded,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_rounded,
                  ),
                  label: 'Archived',
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
      ),
    );
  }
}
