
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../../models/SocailApp/message_model.dart';
import '../../../models/SocailApp/post_model.dart';
import '../../../models/SocailApp/socail_user_model.dart';
import '../../../modules/social_app/chats/chat_Screen.dart';
import '../../../modules/social_app/feeds/feeds_screen.dart';
import '../../../modules/social_app/seetings/Seeting_Screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../modules/social_app/users/user_screen.dart';
import '../../../shared/components/constants.dart';
class SocailCubit extends Cubit<SocailStates>
{
  SocailCubit():super(SocailInitialState());

  static SocailCubit get(context) =>BlocProvider.of(context);

  int curent_index=0;
  int index_list=0;
  List<Widget> bottomScreens=[
   FeedsScreen(),
    ChatScreen(),
    UserScreen(),
    SettingsScreen()
  ];
  List<String>titel=[
    'Home',
    'Chats',
    'Users',
    'settings'
  ];
  void changeBottom(int index) {
    if(index==1)
      getAllUser();
      if (index == 2) {
        emit(SocailNewPostState());
      } else {
        if(index>2)
          index--;
        curent_index = index;
        if(index>=2)
          index++;
        index_list=index;
        print(index);
        emit(SocailChangeBottemNaveState());
      }

  }


  SocailUserModel? mode;
  void getUserData()
  {
    emit(SocailGetUserLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().then((value){
      mode=SocailUserModel.forjson(value.data() as Map<String, dynamic>);

      emit(SocailGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocailGetUserErrorState(error));
    });
  }


  File? profileImage;
  var picker = ImagePicker();
Future<void> getProfileImage() async
 {
  var pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if(pickedFile !=null)
    {
      profileImage=File(pickedFile.path);
      emit(SocailGetProfileImageSuccessState());
    }else
      {
        print("No image selected");
        emit(SocailGetProfileImageErrorState());
      }
}

  File? coverImage;
  Future<void> getCoverImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null)
    {
      coverImage=File(pickedFile.path);
      emit(SocailGetCoverImageSuccessState());
    }else
    {
      print("No image selected");
      emit(SocailGetCoverImageErrorState());
    }
  }
  void uploadingProfileImage({
  @required String? name,
  @required String? bio,
  @required String? phone,
}){
emit(SocailUpdateLoadingState());
    firebase_storage
        .FirebaseStorage.instance
        .ref()//enter
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")//name image
        .putFile(profileImage!).then((value) {
          value.ref.getDownloadURL().then((value) {
            print(value);
            updateUser(name: name, bio: bio, phone: phone,profile: value);
           // emit(SocailUploadProfileImageSuccessState());
          }).catchError((error){
            emit(SocailUploadProfileImageErrorState());
          });
    }).catchError((error){
      emit(SocailUploadProfileImageErrorState());
    });
  }

  void uploadingCoverImage({
    @required String? name,
    @required String? bio,
    @required String? phone,
  } ){
emit(SocailUpdateLoadingState());
    firebase_storage
        .FirebaseStorage.instance
        .ref()//enter
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")//name image
        .putFile(coverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, bio: bio, phone: phone,cover: value);
        emit(SocailUploadCoverImageSuccessState());
      }).catchError((error){
        emit(SocailUploadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocailUploadCoverImageErrorState());
    });
  }

      void updateUser({
        @required String? name,
        @required String? bio,
        @required String? phone,
        String?profile,
        String?cover,
}){
        SocailUserModel Model=SocailUserModel(
          name: name,
          phone: phone,
          isEmailVerified: false,
          image:profile??mode?.image,
          bio: bio,
          cover:cover??mode?.cover,
          email: mode?.email,
          uId: mode?.uId,

        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(mode?.uId)
            .update(Model.toMap()).then((value){
          getUserData();
        }).catchError((error){
          emit(SocailUpdateErrorState());
        });
      }

  File? postImage;
  Future<void> getpostImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null)
    {
      postImage=File(pickedFile.path);
      emit(SocailPostImageSuccessState());
    }else
    {
      print("No image selected");
      emit(SocailPostImageErrorState());
    }
  }

  void uploadPostImage({
    @required String? text,
    @required String? datatime,
  } ){
    emit(SocailCreatePostLoadingState());
    firebase_storage
        .FirebaseStorage.instance
        .ref()//enter
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")//name image
        .putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        creatpost(text: text, datatime: datatime,postimage: value);
        emit(SocailCreatePostSuccessState());
      }).catchError((error){
        emit(SocailCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocailCreatePostErrorState());
    });
  }

  void removePostImage(){
    postImage=null as File?;
    emit(SocailRemovePostImageState());
  }

  void creatpost({
    @required String? text,
    @required String? datatime,
    String?postimage,
  }){
    PostModel Model=PostModel(
      name:mode?.name,
      dataTime:datatime ,
      image:mode?.image,
      postImage: postimage??'',
      text: text,
      uId: mode?.uId,

    );
    emit(SocailCreatePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .add(Model.toMap()).then((value){
          emit(SocailCreatePostSuccessState());
    }).catchError((error){
      emit(SocailCreatePostErrorState());
    });
  }

  List<PostModel>post=[];
  List<String>postId=[];
  List <int>Like=[];
  List<String>commentId=[];
  List <int>comment=[];
  void getPost(){
    emit(SocailGetPostLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
            .collection('likes')
            .get()
            .then((value) {
              Like.add(value.docs.length );
              postId.add(element.id);
              comment.add(value.docs.length );
              commentId.add(element.id);
              post.add(PostModel.forjson( element.data()) );
            }
            );
          });
          emit(SocailGetPostSuccessState());
    })
        .catchError((error) {
          emit(SocailGetPostErrorState(error.toString()));
    });
  }
  void likePost(postId)
  {
    FirebaseFirestore
    .instance
    .collection('posts')
    .doc(postId)
    .collection('likes')
    .doc(mode?.uId)
    .set(
      {
        'like':true
      }
    ).then((value) {
      emit(SocailLikePostSuccessState());
    }).catchError((error){
      emit(SocailLikePostErrorState(error));
    });
  }

  void commentPost(commentId)
  {
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(commentId)
        .collection('comments')
        .doc(mode?.uId)
        .set(
        {
          'comment':true
        }
    ).then((value) {
      emit(SocailCommentPostSuccessState());
    }).catchError((error){
      emit(SocailCommentPostErrorState(error));
    });
  }

  List<SocailUserModel>allUser=[];

  void getAllUser()
  {
    if(allUser.length==0)
    FirebaseFirestore
        .instance
        .collection("users")
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if(element.data()['uId'] != mode?.uId)
            allUser.add(SocailUserModel.forjson(element.data()));
          });
          emit(SocailAllGetUserSuccessState());
    }).catchError((error){
      emit(SocailAllGetUserErrorState(error));
    });
  }
  File? messageImage;
  Future<void> getmassegeImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile !=null)
    {
      messageImage=File(pickedFile.path);
      emit(SocailMessageImageSuccessState());
    }else
    {
      print("No image selected");
      emit(SocailMessageImageErrorState());
    }
  }

  void uploadMessageImage({
    @required  String? receiveruId,
    @required String? datetime,
    @required  String? text,
  } ){
    firebase_storage
        .FirebaseStorage.instance
        .ref()//enter
        .child("users/${Uri.file(messageImage!.path).pathSegments.last}")//name image
        .putFile(messageImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(receiveruId: receiveruId, datetime: datetime, text: text,messageImage: value);
        emit(SocailSendMessageSuccessState());
      }).catchError((error){
        emit(SocailSendMessageErrorState(error));
      });
    }).catchError((error){
      emit(SocailSendMessageErrorState(error));
    });
  }

  void sendMessage({
    @required  String? receiveruId,
    @required String? datetime,
    @required  String? text,
    String?messageImage,
})
{
  //sender
  MessageModel messageModel=MessageModel(text: text,
  datetime: datetime,
    receiveruId: receiveruId,
    senderuId: mode?.uId,
    image: messageImage??' ',
  );
  FirebaseFirestore.instance
  .collection('users')
  .doc(mode?.uId)
  .collection("chats")
  .doc(receiveruId)
  .collection("messages")
  .add(messageModel.toMap()).then((value){
    emit(SocailSendMessageSuccessState());
  } ).catchError((error){
    emit(SocailSendMessageErrorState(error));
  });
  //receiver
  FirebaseFirestore.instance
      .collection('users')
      .doc(receiveruId)
      .collection("chats")
      .doc(mode?.uId)
      .collection("messages")
      .add(messageModel.toMap()).then((value){
    emit(SocailSendMessageSuccessState());
  } ).catchError((error){
    emit(SocailSendMessageErrorState(error));
  });

}

List<MessageModel>message=[];
  void getMessage({
    @required  String? receiveruId,
})
  {
    emit(SocailGetMessageLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(mode?.uId)
        .collection("chats")
        .doc(receiveruId)
        .collection("messages")
        .orderBy("datetime")
        .snapshots() //list of future
        .listen((event) {
          message=[];
          event.docs.forEach((element) {
            message.add(MessageModel.forjson(element.data()));
          });
          emit(SocailGetMessageSuccessState());
    });
  }

  void removeMessageImage(){
    messageImage=null as File?;
    emit(SocailRemoveMessageImageState());
  }
}