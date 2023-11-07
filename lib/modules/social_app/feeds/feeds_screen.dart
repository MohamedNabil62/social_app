import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/social_app/cubit/cubit.dart';
import '../../../layout/social_app/cubit/state.dart';
import '../../../models/SocailApp/post_model.dart';
import '../../../shared/styles/IconBroken.dart';
import '../../../shared/styles/colors.dart';
class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<SocailCubit,SocailStates>(
        builder: (context, state) {
          return  ConditionalBuilder(
            condition:SocailCubit.get(context).post.length >0&&SocailCubit.get(context).mode !=null,
            builder: (context) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),//shep to scroll
                child: Column(
                  children: [
                    Card(
                      clipBehavior:Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage("https://img.freepik.com/free-photo/photo-delighted-cheerful-afro-american-woman-with-crisp-hair-points-away-shows-blank-space-happy-advertise-item-sale-wears-orange-jumper-demonstrates-where-clothes-shop-situated_273609-26392.jpg"),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("communicate with friends",
                              style:Theme.of(context).textTheme.subtitle1?.copyWith(
                                  color: Colors.white
                              ) ,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics:NeverScrollableScrollPhysics(),//stop scroll in list
                      itemBuilder:(context, index) => bluidPostItem(context,SocailCubit.get(context).post[index] ,index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: SocailCubit.get(context).post.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
            fallback: (context) {
              return  Center(child: CircularProgressIndicator());
            },
          );
        },
        listener: (context, state) {},
      );
  }
}

Widget bluidPostItem(context,PostModel model,index) => Card(
    clipBehavior:Clip.antiAliasWithSaveLayer,
    elevation: 1,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius:25,
                backgroundImage: NetworkImage("${model.image}"),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(model.name!,
                          style: TextStyle(
                              height: 1.4
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.check_circle,
                          color: Colors.blue,
                          size:16 ,
                        )
                      ],
                    ),
                    Text(model.dataTime!,
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.black54,
                            height: 1.4
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed:() {

                  },
                  icon:Icon(Icons.more_horiz,
                    size: 16,
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,

            ),
          ),
          Text(model.text!,
            // style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0,top: 5),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 3),
                    child: Container(
                      height: 25,
                      child: MaterialButton(onPressed: (){},
                        padding: EdgeInsets.zero,
                        // height: 1,//hight
                        minWidth: 1, //wideth
                        child: Text("#UiFlutter",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              color:myColor
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 3),
                    child: Container(
                      height: 25,
                      child: MaterialButton(onPressed: (){},
                        padding: EdgeInsets.zero,
                        //  height: 1,//hight
                        minWidth: 1, //wideth
                        child: Text("#Udemy",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              color:myColor
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(model.postImage !='')
            Padding(
              padding:  EdgeInsetsDirectional.only(top: 15.0),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage("${model.postImage}"),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,
                            size:17,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5,),
                          Text("${SocailCubit.get(context).Like[index]}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,
                            size:17,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5,),
                          Text("${SocailCubit.get(context).comment[index]} comment",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,

            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius:18,
                        backgroundImage:NetworkImage('${SocailCubit.get(context).mode?.image!}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text("write a comment ...",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.black54,
                          )
                      ),
                    ],),
                  onTap: (){
                    SocailCubit.get(context).commentPost(SocailCubit.get(context).commentId[index]);

                  },
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      Icon(IconBroken.Heart,
                        size:17,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5,),
                      Text("like",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  SocailCubit.get(context).likePost(SocailCubit.get(context).postId[index]);
                },
              ),
            ],
          ),
        ],
      ),
    )
);