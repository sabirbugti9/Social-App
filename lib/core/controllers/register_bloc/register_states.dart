abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  late final String error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterStates {
  late String userId;

  SocialCreateUserSuccessState(this.userId);
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  late final String error;

  SocialCreateUserErrorState(this.error);
}

class SocialRegChangePasswordVisibilityState extends SocialRegisterStates {}
