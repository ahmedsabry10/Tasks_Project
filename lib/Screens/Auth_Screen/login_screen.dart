
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/Data/Style/icon_broken.dart';
import 'package:tests/Data/components/components.dart';
import 'package:tests/Data/constanse/constanse.dart';
import 'package:tests/Data/shared/cachehelper.dart';
import 'package:tests/Data/shared/cubit/AppCubit/cubit.dart';
import 'package:tests/Data/shared/cubit/LoginCubit/login_cubit.dart';
import 'package:tests/Data/shared/cubit/LoginCubit/login_states.dart';
import 'package:tests/Screens/Auth_Screen/register_screen.dart';
import 'package:tests/Screens/MainScreens/home_layout.dart';



class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);


  var formKey=GlobalKey<FormState>();

  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),

      child: BlocConsumer <LoginCubit , LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if(state is LoginSuccessState)

          {
            showToast(
              text: "تم تسجيل الدخول بنجاح",
              state: ToastStates.SUCCESS,
            );
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
              //token= state.loginModel.data.token;
            ).then((value)
            {
              uId= state.uId;
              navigateAndFinish(
                context,
                HomeLayout(),
              );
              AppCubit.get(context).getUserData();

            });
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
                              IconBroken.User,
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
                          obscureText: LoginCubit.get(context).isPassword,
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
                            LoginCubit.get(context).suffix != null?
                            IconButton(
                              icon:Icon(
                                  LoginCubit.get(context).suffix,
                                color: Colors.blue,
                              ) ,
                              onPressed: (){
                                LoginCubit.get(context).changePasswordVisibility();
                              },
                            )
                                : null,



                          ),

                        ),

                        const SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! LoginLoadingState,
                          builder:(context)=>Container(
                            width: double.infinity,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: Colors.blue,
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                if (formKey.currentState.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );

                                } else
                                  print('NUll');
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          fallback: (context)=>const Center(child:  CupertinoActivityIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
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
                                    RegisterScreen()
                                );
                              },
                              child: Text(
                                'Sign up'.toUpperCase(),
                                style: TextStyle(
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
