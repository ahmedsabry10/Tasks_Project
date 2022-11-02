
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/Data/Style/icon_broken.dart';
import 'package:tests/Data/components/components.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Data/shared/cubit/RegisterCubit/register_cubit.dart';
import 'package:tests/Data/shared/cubit/RegisterCubit/register_states.dart';
import 'package:tests/Screens/Auth_Screen/login_screen.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  var formKey=GlobalKey<FormState>();

  var nameController =TextEditingController();
  var phoneController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),

      child: BlocConsumer <RegisterCubit , RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndFinish(
              context,
              LoginScreen(),
            );

          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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


                        const SizedBox(
                          height: 20.0,
                        ),




                        //name
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

                        const SizedBox(
                          height: 20.0,
                        ),

                        //email
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
                        const SizedBox(
                          height: 20.0,
                        ),

                        //phone
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
                          height: 20.0,
                        ),

                        //password
                        TextFormField(
                          style: TextStyle(
                            color:AppCubit.get(context).isDark? Colors.white:Colors.black,
                          ),
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: RegisterCubit.get(context).isPassword,
                          enabled: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your email";
                            } else
                              return null;
                          },


                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blue
                            ),

                            prefixIcon: Icon(
                              IconBroken.Password,
                              color: Colors.blue,

                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:  BorderSide(
                                color: Colors.blue,

                                width: .3,
                              ),
                            ),


                            suffixIcon:
                            RegisterCubit.get(context).suffix != null?
                            IconButton(
                              icon:Icon(
                                RegisterCubit.get(context).suffix,
                                color: Colors.blue,

                              ) ,
                              onPressed: (){
                                RegisterCubit.get(context).changePasswordVisibility();
                              },
                            )
                                : null,



                          ),

                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! RegisterLoadingState,
                          builder:(context)=>Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (){
                                if (formKey.currentState.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  navigateTo(context, LoginScreen());
                                } else
                                  print('NUll');
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          fallback: (context)=>const Center(child: CupertinoActivityIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              ' have an account?',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),


                            TextButton(
                              onPressed: (){
                                navigateAndFinish(
                                    context,
                                    LoginScreen()
                                );
                              },
                              child: Text(
                                'Sign In'.toUpperCase(),
                                style:  TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic


                                ),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(
                          height: 20.0,
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
