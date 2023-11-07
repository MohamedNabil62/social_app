import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/social_login/cubit/state.dart';
class SocailLoginCubit extends Cubit<SocailLoginStates>
{
  SocailLoginCubit():super(SocailLoginInitialState());
  @override

static SocailLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }
      ){
    emit(SocailLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      print(value.credential?.token);
      emit(SocailLoginSuccessState(value.user?.uid));
    }).catchError((onError){
      emit(SocailLoginErrorState(onError.toString()));
    });

  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocailChangePasswordVisibilityState());
  }
}