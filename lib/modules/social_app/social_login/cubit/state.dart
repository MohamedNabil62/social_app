abstract class SocailLoginStates{}

class SocailLoginInitialState extends SocailLoginStates{}

class  SocailLoginLoadingState extends SocailLoginStates{}

class  SocailLoginSuccessState extends SocailLoginStates{
  final String? uId;
  SocailLoginSuccessState(this.uId);
}

class SocailLoginErrorState extends SocailLoginStates{
  final String error;
  SocailLoginErrorState(this.error);
}

class SocailChangePasswordVisibilityState extends SocailLoginStates{}