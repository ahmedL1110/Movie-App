abstract class RegisterState {}

class RegisterInitialState extends RegisterState{}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState{
  dynamic uId;

  RegisterSuccessState(this.uId);
}

class RegisterErrorState extends RegisterState{
  dynamic error;

  RegisterErrorState(this.error);
}

class CreateUserSuccessState extends RegisterState{
  dynamic uId;

  CreateUserSuccessState(this.uId);
}

class CreateUseErrorState extends RegisterState{
  final String error;

  CreateUseErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterState{}