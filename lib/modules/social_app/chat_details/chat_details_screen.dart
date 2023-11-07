import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/state.dart';
import '../../../models/SocailApp/message_model.dart';
import '../../../models/SocailApp/socail_user_model.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../../shared/styles/colors.dart';
var messagecontroaer=TextEditingController();
class ChatDetailsScreen extends StatelessWidget {
  SocailUserModel? Model;
  ChatDetailsScreen(
  this.Model,

  );
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocailCubit.get(context).getMessage(receiveruId: Model?.uId);
      return BlocConsumer<SocailCubit,SocailStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                  IconBroken.Arrow___Left_2
              ),
            ),
            titleSpacing: 0,
            title:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius:20,
                  backgroundImage: NetworkImage("${Model?.image}"),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text("${Model?.name}",
                    style: TextStyle(
                      //  height: 1.4
                        fontSize: 15
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition:SocailCubit.get(context).message.length>0,
            builder: (context) => Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var message = SocailCubit.get(context).message[index];
                      print(message.text);
                      if (SocailCubit.get(context).mode?.uId == message.senderuId)
                        return bluidMyMessage(message);
                      return bluidMessage(message);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: SocailCubit.get(context).message.length,
                  ),
                ),
                if(SocailCubit.get(context).messageImage!=null)
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 150,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: FileImage(SocailCubit.get(context).messageImage!),
                                fit: BoxFit.cover,
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, right: 6),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: myColor,
                            child: IconButton(onPressed: () {
                              SocailCubit.get(context).removeMessageImage();
                            },
                              icon: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,

                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color:Colors.grey[300]!
                        ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: messagecontroaer,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: "type your message here...",
                              ),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                          SocailCubit.get(context).getmassegeImage();
                        },
                            icon: Icon(
                                IconBroken.Image
                            )
                        ),
                        Container(
                          height: 50,
                          color: myColor,
                          child: MaterialButton(onPressed: (){
                            if(SocailCubit.get(context).messageImage ==null)
                            SocailCubit.get(context).sendMessage(
                                receiveruId: Model?.uId,
                                datetime:DateTime.now().toString(),
                                text:messagecontroaer.text
                            );
                            SocailCubit.get(context).uploadMessageImage(
                                receiveruId: Model?.uId,
                                datetime:DateTime.now().toString(),
                                text:messagecontroaer.text
                            );
                            SocailCubit.get(context).removeMessageImage();
                          },
                            minWidth: 1,
                            child: Icon(
                              IconBroken.Send,
                              size: 16,
                              //   color: myColor,
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
        listener:(context, state) {},);
    },
    );
  }
}

Widget bluidMessage(MessageModel message,){
  return Align(
  alignment: AlignmentDirectional.centerStart,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(message.text !='')
      Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
          ),
          child: Text("${message.text} ")
      ),
        if(message.image !='')
          Column(
            children: [
              SizedBox(height: 15,),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image(
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                    image:NetworkImage("${message.image}")

                ),
              ),
            ],
          ),
    ],),
  ),
);}

Widget bluidMyMessage(MessageModel message) {
  print(message.image);
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if(message.text !='')
            Container(
                decoration: BoxDecoration(
                  color: myColor.withOpacity(.2),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10
                ),
                child: Text("${message.text} ")
            ),
            //image in
            if(message.image !=' ')
            Column(
              children: [
                SizedBox(height: 15,),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                      image:NetworkImage("${message.image}")

                  ),
                ),
              ],
            )
            //  if(message.image !=' ')

          ],)
    ),
  );
}