import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/UserModel/user_model.dart';
import 'RegisterState.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String lastname,
    required String firstname,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.toString());
      print(value.user!.uid);
      userCreate(
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        email: email,
        password: password,
        uId: value.user!.uid,
      );

      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      //print(uId);
      print('hhhhhhh');
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String phone,
    required String uId,
  }) {
    UserModel modle = UserModel(
      email: email,
      password: password,
      phone: phone,
      lastname: lastname,
      firstname: firstname,
      uId: uId,
      image:
          'https://img.freepik.com/free-vector/delivery-service-customer-door_107791-11385.jpg', //الافتراضي
    );

    FirebaseFirestore.instance
        .collection('users') //لو ما لقه بروح يكريته ويشتغل عليه
        .doc(uId)
        .set(modle.toMap())
        .then((value) {
      emit(CreateUserSuccessState(modle.uId));
    }).catchError((error) {
      print('aaaaaaaaaaaaaaaaaaaaaaaa');
      print(error.toString());
      emit(CreateUseErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
