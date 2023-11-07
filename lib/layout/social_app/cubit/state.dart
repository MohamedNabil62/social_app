abstract class SocailStates{}

class SocailInitialState extends SocailStates{}

class  SocailGetUserLoadingState extends SocailStates{}

class  SocailGetUserSuccessState extends SocailStates{}

class SocailGetUserErrorState extends SocailStates{
  final String error;
  SocailGetUserErrorState(this.error);
}

class  SocailGetPostLoadingState extends SocailStates{}

class  SocailGetPostSuccessState extends SocailStates{}

class SocailGetPostErrorState extends SocailStates{
  final String error;
  SocailGetPostErrorState(this.error);
}

class SocailChangeBottemNaveState extends SocailStates{}

class SocailNewPostState extends SocailStates{}

class  SocailGetProfileImageSuccessState extends SocailStates{}

class SocailGetProfileImageErrorState extends SocailStates{}

class  SocailGetCoverImageSuccessState extends SocailStates{}

class SocailGetCoverImageErrorState extends SocailStates{}

class  SocailUploadProfileImageSuccessState extends SocailStates{}

class SocailUploadProfileImageErrorState extends SocailStates{}

class  SocailUploadCoverImageSuccessState extends SocailStates{}

class SocailUploadCoverImageErrorState extends SocailStates{}

class SocailUpdateErrorState extends SocailStates{}

class SocailUpdateLoadingState extends SocailStates{}

//create post

class SocailCreatePostLoadingState extends SocailStates{}

class SocailCreatePostSuccessState extends SocailStates{}

class SocailCreatePostErrorState extends SocailStates{}

class SocailPostImageErrorState extends SocailStates{}

class  SocailPostImageSuccessState extends SocailStates{}

class  SocailRemovePostImageState extends SocailStates{}

//like

class  SocailLikePostSuccessState extends SocailStates{}

class SocailLikePostErrorState extends SocailStates{
  final String error;
  SocailLikePostErrorState(this.error);
}

//comment

class  SocailCommentPostSuccessState extends SocailStates{}

class SocailCommentPostErrorState extends SocailStates{
  final String error;
  SocailCommentPostErrorState(this.error);
}

//chat

class  SocailAllGetUserLoadingState extends SocailStates{}

class  SocailAllGetUserSuccessState extends SocailStates{}

class SocailAllGetUserErrorState extends SocailStates{
  final String error;
  SocailAllGetUserErrorState(this.error);
}

//massege

class  SocailSendMessageSuccessState extends SocailStates{}

class SocailSendMessageErrorState extends SocailStates{
  final String error;
  SocailSendMessageErrorState(this.error);
}

class  SocailGetMessageSuccessState extends SocailStates{}

class SocailGetMessageLoadingState extends SocailStates{}

class SocailMessageImageSuccessState extends SocailStates{}

class SocailMessageImageErrorState extends SocailStates{}

class SocailRemoveMessageImageState extends SocailStates{}
