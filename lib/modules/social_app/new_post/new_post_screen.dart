import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../../shared/styles/colors.dart';
var textcontroller=TextEditingController();
class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubit,SocailStates>(builder: (context, state) {
      return Scaffold(
        appBar:defaultAppBar(context: context,
          text: ' Create Post',
          action: [
            defaultTextButten(function:(){
              DateTime formattedDateTime = DateTime.now();
              String now= DateFormat('MMM dd, yyyy - hh:mm a').format(formattedDateTime);
              if(SocailCubit.get(context).postImage==null)
                {
                  SocailCubit.get(context).creatpost(
                      text: textcontroller.text,
                      datatime:now.toString() ,
                  );
                }else
                  {
                    SocailCubit.get(context).uploadPostImage(
                      text: textcontroller.text,
                      datatime:now.toString() ,
                    );
                  }
            } ,
                text: "Post")
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is SocailCreatePostLoadingState)
                LinearProgressIndicator(),
              if(state is SocailCreatePostLoadingState)
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius:25,
                    backgroundImage: NetworkImage("${SocailCubit.get(context).mode?.image}"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text("${SocailCubit.get(context).mode?.name}",
                      style: TextStyle(
                          height: 1.4
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textcontroller,
                  decoration: InputDecoration(
                      hintText: 'what is on your mind...',
                    border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            if(SocailCubit.get(context).postImage !=null)
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: FileImage(SocailCubit.get(context).postImage!),
                        fit: BoxFit.cover,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, right: 6),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: myColor,
                      child: IconButton(onPressed: () {
                        SocailCubit.get(context).removePostImage();
                      },
                        icon: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,

                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      SocailCubit.get(context).getpostImage();
                    },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5,),
                            Text("add photo")
                          ],
                        )
                    ),
                  ),
                  Expanded(
                    child: TextButton(onPressed: (){},
                        child: Text("# tags")
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
      listener: (context, state) {},);
  }
}
