
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/Data/Style/icon_broken.dart';
import 'package:tests/Data/shared/cubit/LoginCubit/login_states.dart';


class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);




  void userLogin({
    @required String email,
    @required String password,

  }){
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      emit(LoginSuccessState(value.user.uid));

    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix =IconBroken.Show ;
  bool isPassword=true;
  void changePasswordVisibility(){
    suffix=isPassword ?IconBroken.Hide :IconBroken.Show ;
    isPassword =! isPassword;
    emit(ChangePasswordVisibilityState());
  }
}