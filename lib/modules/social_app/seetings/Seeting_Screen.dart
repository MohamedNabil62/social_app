import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/IconBroken.dart';
import '../edit_profile/edit_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit,SocailStates>(
        builder: (context, state) {
          var usermodel=SocailCubit.get(context).mode;
          var profileImage=SocailCubit.get(context).profileImage;
          var coverImage=SocailCubit.get(context).coverImage;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight:  Radius.circular(4)
                              ),
                              image: DecorationImage(
                                image:NetworkImage("${usermodel?.cover}"),
                                fit: BoxFit.cover,
                              ),
                          ),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius:60,
                          backgroundImage: profileImage==null? NetworkImage("${usermodel?.image}") as ImageProvider<Object>?:FileImage(profileImage),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("${usermodel?.name}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text("${usermodel?.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("100",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Posts",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("200",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Photos",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("10k",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Followers",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text("1",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text("Flowerings",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          "Add Photos"
                        )
                    ),

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        nevgitto(context, EditProfileScreen());
                      },
                      child:Icon(
                        IconBroken.Edit,
                        size: 16,
                      )
                  ),
                ],),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){
                            FirebaseMessaging.instance.subscribeToTopic("mohamed");
                          },
                          child: Text(
                              "subscribe"
                          )
                      ),

                    ),
                    SizedBox(
                      width: 28,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){
                            FirebaseMessaging.instance.unsubscribeFromTopic("mohamed");
                          },
                          child:  Text(
                              "unsubscribe"
                          )
                      ),

                    ),

                  ],
                )
              ],
            ),
          );
        },
        listener:(context, state) {}
    );
  }
}
