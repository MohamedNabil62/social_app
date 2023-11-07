abstract class SocailRegisterStates{}

class  SocailRegisterInitialState extends SocailRegisterStates{}

class  SocailRegisterLoadingState extends SocailRegisterStates{}

class  SocailRegisterSuccessState extends SocailRegisterStates{}

class  SocailRegisterErrorState extends SocailRegisterStates{

  final String error;
  SocailRegisterErrorState(this.error);
}

class  SocailRegisterSuccessCreateUserState extends SocailRegisterStates{}

class  SocailRegisterErrorCreateUserState extends SocailRegisterStates{

  final String error;
  SocailRegisterErrorCreateUserState(this.error);
}

class  SocailRegisterchangePasswordVisibilityState extends SocailRegisterStates{}