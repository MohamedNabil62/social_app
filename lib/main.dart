// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/bloc_observre.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/theme-data.dart';

import 'layout/social_app/cubit/cubit.dart';
import 'layout/social_app/cubit/state.dart';
import 'layout/social_app/socail_layout.dart';
import 'modules/social_app/social_login/socail_login_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print("on Background message");
  print( message.data.toString());
  showToast(text: "on Background message", state: ToastState.SUCCESS);
}
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //flutter-fire

  var token=await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print("on message");
   print( event.data.toString());
    showToast(text: "on message", state: ToastState.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("on message open app");
    print( event.data.toString());
    showToast(text: "on message open app", state: ToastState.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
 await CacheHelper.init();
 bool? isDark=CacheHelper.getData(kay: 'mode');
  bool? OnBorading=CacheHelper.getData(kay: 'onborading');
  token=CacheHelper.getData(kay: 'token');
  uId=CacheHelper.getData(kay: "uId");
  print(uId);
  Widget? widget;
  if(uId != null) //socail app
    {
      widget=SocailLayout();
    }else
      {
        widget=SocialLoginScreen();
      }

  runApp(MyApp(isDark,widget));
}
class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget Start_Widget;
  const MyApp(this.isDark, this.Start_Widget,{super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SocailCubit()..getUserData()..getPost(),//..getAllUser(),
                 )
        ],
        child:BlocConsumer<SocailCubit,SocailStates>(
        listener:(context, state) => {
        },
    builder:(context, state) {
          return  MaterialApp(debugShowCheckedModeBanner: false,
             home: Directionality(textDirection: TextDirection.ltr,
                  child:Start_Widget,
             )
          );
    })
    );

  }
}