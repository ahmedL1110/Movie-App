abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ResetLoadingState extends LoginState {}

class ResetSuccessState extends LoginState {
}

class ResetErrorState extends LoginState {
  final String error;

  ResetErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginState {}


