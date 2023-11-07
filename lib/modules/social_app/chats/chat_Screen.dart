import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/state.dart';
import '../../../models/SocailApp/socail_user_model.dart';
import '../../../shared/components/components.dart';
import '../chat_details/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit,SocailStates>(
      builder: (context, state) {
      return ConditionalBuilder(
        condition: SocailCubit.get(context).allUser.length>0,
        builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(context,SocailCubit.get(context).allUser[index]),
            separatorBuilder: (context, index) => meSlider( ),
            itemCount: SocailCubit.get(context).allUser.length
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    }, listener:(context, state) {},
    );
  }
}

Widget buildChatItem(context,SocailUserModel model) => InkWell(
  onTap: (){
    nevgitto(context, ChatDetailsScreen(model));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child:   Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius:25,
          backgroundImage: NetworkImage("${model?.image}"),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text("${model?.name}",
          ),
        ),
      ],
    ),
  ),
);