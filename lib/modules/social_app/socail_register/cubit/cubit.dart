import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_app/socail_register/cubit/state.dart';

import '../../../../models/SocailApp/socail_user_model.dart';

class SocailRegisterCubit extends Cubit<SocailRegisterStates>
{
  SocailRegisterCubit():super(SocailRegisterInitialState());

static SocailRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }
      ){
    emit(SocailRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
     // print(value.credential?.token);
      print(value.user?.uid);
      print(value.credential?.token);
      userCreate(
          name: name,
          email: email,
          uId: value.user!.uid,
          phone: phone
      );
     // emit(SocailRegisterSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocailRegisterErrorState(onError.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }){
    SocailUserModel Model=SocailUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image: 'https://img.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg?t=st=1694610874~exp=1694611474~hmac=b92f887461d99d761ffcbe206807d0a3e15cc851b3dac950bee56d8ce51d3837',
      bio: 'write your bio...',
      cover:'https://img.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg?t=st=1694610874~exp=1694611474~hmac=b92f887461d99d761ffcbe206807d0a3e15cc851b3dac950bee56d8ce51d3837',
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(Model.toMap()).then((value){
          emit(SocailRegisterSuccessCreateUserState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocailRegisterErrorCreateUserState(onError));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(SocailRegisterchangePasswordVisibilityState());
  }


}