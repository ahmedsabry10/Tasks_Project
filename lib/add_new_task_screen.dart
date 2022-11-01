import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tests/components/components.dart';
import 'package:tests/home_layout.dart';
import 'package:tests/shared/cubit/cubit.dart';
import 'package:tests/shared/cubit/states.dart';

class AddNewTasks extends StatelessWidget {
  AddNewTasks({Key key}) : super(key: key);

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppStates>(
      listener: (BuildContext context, AppStates states){},
      builder: (BuildContext context, AppStates states){
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 180.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  'https://gdm-catalog-fmapi-prod.imgix.net/ProductLogo/77fef54a-22e6-46cd-b5ca-da2d75c73810.png?ixlib=rb-1.0.0&ch=Width%2CDPR&auto=format'
                              )
                          ),



                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                          labelText: 'Task Title',
                          labelStyle: const TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                          prefixIcon: Icon(
                            Icons.title,
                            color: Colors.blue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:  BorderSide(
                              color: Colors.blue,
                              width: .3,
                            ),
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
                          contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                          labelText: 'Task Time',
                          labelStyle: const TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                          prefixIcon: Icon(
                            Icons.watch_later_outlined,
                            color: Colors.blue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:  BorderSide(
                              color: Colors.blue,
                              width: .3,
                            ),
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
                          contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                          labelText: 'Task Date',
                          labelStyle: const TextStyle(
                              fontStyle: FontStyle.italic
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:  BorderSide(
                              color: Colors.blue,
                              width: .3,
                            ),
                          ),
                        ),
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                              DateTime.parse('2100-10-10'))
                              .then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value);
                          });
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              if (formKey.currentState.validate()) {
                                AppCubit.get(context).insertToDatabase(
                                  title: titleController.text,
                                  time: timeController.text,
                                  date: dateController.text,
                                );
                              }
                            },
                            child: Text(
                                'Add'
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
