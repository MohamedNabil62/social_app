import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/social_app/new_post/new_post_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/IconBroken.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocailLayout extends StatelessWidget {
  const SocailLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<SocailCubit,SocailStates>(
     builder:(context, state) {
       var cubit=SocailCubit.get(context);
     return Scaffold(
       appBar: AppBar(
         title:Text(
             cubit.titel[cubit.curent_index]),
         actions: [
           IconButton(onPressed: (){},
               icon:Icon(IconBroken.Notification)
           ),
           IconButton(onPressed: (){},
               icon:Icon(IconBroken.Search)
           ),
         ],
       ),
       body:cubit.bottomScreens[cubit.curent_index],
       bottomNavigationBar:BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
         elevation: 10,
         currentIndex: cubit. index_list,
         onTap: (index){
               cubit.changeBottom(index);
         },
         items: const [
           BottomNavigationBarItem(
               icon: Icon(
                   IconBroken.Home
               ),
             label: "Home"
           ),
           BottomNavigationBarItem(
               icon: Icon(IconBroken.Chat),
             label: "Chats"
           ),
           BottomNavigationBarItem(
               icon: Icon(IconBroken.Upload),
               label: "Posts"
           ),
           BottomNavigationBarItem(
               icon: Icon(IconBroken.Location),
               label: "Users"
           ),
           BottomNavigationBarItem(
               icon: Icon(IconBroken.Setting),
               label: "Settings"
           )
         ],
         //  backgroundColor: Colors.cyan,
       ),
     );
    },
     listener:(context, state) {
       if(state is SocailNewPostState)
         {
           nevgitto(context, NewPostScreen());
         }
     },
   );
  }
}
