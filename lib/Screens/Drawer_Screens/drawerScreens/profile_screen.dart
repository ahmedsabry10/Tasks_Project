import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/Data/Style/icon_broken.dart';
import 'package:tests/Data/components/components.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Data/shared/cubit/AppCubit/states.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key key}) : super(key: key);

  var nameController = TextEditingController();

  var bioController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).userModel;
        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        emailController.text=userModel.email;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            titleSpacing: 5.0,
            actions: [
              TextButton(
                  onPressed: (){
                    AppCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: const Text(
                      'UPDATE'
                  )
              ),
              const SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                ConditionalBuilder(
                    builder:(context )=> Column(
                      children: [

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
                        SizedBox(height: 20.0,),

                        TextFormField(
                          style: TextStyle(
                            color:AppCubit.get(context).isDark? Colors.white:Colors.black,
                          ),
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          enabled: true,


                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your name";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'User Name',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue
                            ),
                            prefixIcon: Icon(
                              IconBroken.Add_User,
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
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          style: TextStyle(
                            color:AppCubit.get(context).isDark? Colors.white:Colors.black,
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          enabled: true,


                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your email";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue
                            ),
                            prefixIcon: Icon(
                              IconBroken.Message,
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
                        ),
                        SizedBox(height: 20.0,),

                        TextFormField(
                          style: TextStyle(
                            color:AppCubit.get(context).isDark? Colors.white:Colors.black,
                          ),
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          enabled: true,


                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your Phone";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'Phone',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue
                            ),
                            prefixIcon: Icon(
                              IconBroken.Call,
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
                        ),

                        const SizedBox(
                          height: 10.0,
                        ),



                      ],
                    ),
                    fallback: (context )=>Center(child: CircularProgressIndicator(),),
                    condition: state is! UserUpdateLoadingState

                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
