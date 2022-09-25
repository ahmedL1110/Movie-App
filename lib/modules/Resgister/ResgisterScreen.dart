import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/modules/Login/LoginScreen.dart';
import 'package:photoplayuikit/modules/Resgister/cubit/RegisterCubit.dart';
import 'package:photoplayuikit/modules/Resgister/cubit/RegisterState.dart';
import 'package:photoplayuikit/shared/components/compoents.dart';

import '../../layout/LayoutScreen.dart';
import '../../shared/network/remote/cache_helper.dart';

class ResgisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              LayoutCubit.get(context).getUserData(uId: state.uId).then((value) {
                LayoutCubit.get(context)
                    .changeBottomNac(0);
                navigateAndFinish(context, LayoutScreen());

              }).catchError((error) {
                print(error.toString());
              });
            });
          }else if(state is RegisterErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: EdgeInsetsDirectional.only(start: size.width * 0.1),
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset.fromDirection(1.5, 10),
                      spreadRadius: 0,
                      blurRadius: 10.0),
                ],
                //borderRadius: BorderRadius.circular(10),
                //color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Center(
                          child: CircleAvatar(
                        radius: size.height * 0.071,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: size.height * 0.068,
                          backgroundImage: AssetImage('asset/images/p3.PNG'),
                        ),
                      )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Center(
                        child: Text(
                          'Add profile picture',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'FIRST NAME',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      DefailTextFild(
                        size: size,
                        type: TextInputType.text,
                        stringError: 'please FIRST NAME your email address',
                        hintText: 'first name here',
                        prefix: Icons.email_outlined,
                        controller: first_name,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        'LAST NAME',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      DefailTextFild(
                        //isPassword: LoginCubit.get(context).isPassword,
                        size: size,
                        controller: last_name,
                        type: TextInputType.text,
                        stringError: 'please LAST NAME your password',
                        hintText: 'last name here',
                        prefix: Icons.lock,
                        suffix: Icons.visibility_outlined,
                        suffixPressed: () {
                          //LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: size.height * .005,
                      ),
                      Text(
                        'EMAIL',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      DefailTextFild(
                        size: size,
                        type: TextInputType.emailAddress,
                        stringError: 'please EMAIL your email address',
                        hintText: 'email here',
                        prefix: Icons.email_outlined,
                        controller: email,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        'PASSWORD',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      DefailTextFild(
                        size: size,
                        type: TextInputType.visiblePassword,
                        stringError: 'please PASSWORD your email address',
                        hintText: 'password here',
                        prefix: Icons.email_outlined,
                        controller: password,
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      Text(
                        'PHONE',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      DefailTextFild(
                        //isPassword: LoginCubit.get(context).isPassword,
                        size: size,
                        controller: phone,
                        type: TextInputType.phone,
                        stringError: 'please Phone your password',
                        hintText: 'Phone here',
                        prefix: Icons.lock,
                        suffix: Icons.visibility_outlined,
                        suffixPressed: () {
                          //LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: size.height * .005,
                      ),
                      if (true)
                        DefaultBotton(
                          size: size,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                lastname: last_name.text,
                                  firstname: first_name.text,
                                  phone: phone.text,
                                  email: email.text, password: password.text);
                            }
                          },
                          text: Text(
                            'REGISTER',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      else
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.lightGreen,
                          ),
                        ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      DefaultText(
                        login: false,
                        context: context,
                        widgetTo: LoginScreen(),
                      ),
                      SizedBox(
                        height: size.height * 0.002,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget DefailTextFild(
        {required Size size,
        required TextEditingController controller,
        required TextInputType type,
        required String stringError,
        bool isPassword = false,
        var ontap,
        var onS,
        var onchanged,
        required String hintText,
        required IconData prefix,
        IconData? suffix,
        var suffixPressed}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.85,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset.fromDirection(0, 0),
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onchanged,
        onFieldSubmitted: onS,
        keyboardType: type,
        validator: (value) {
          if (value!.isEmpty) {
            return stringError;
          }
        },
        onTap: ontap,
        obscureText: isPassword,
        cursorColor: Color.fromARGB(255, 255, 187, 59),
        decoration: InputDecoration(
          hintText: hintText,
          // icon: Icon(
          //   prefix,
          //   color: Color.fromARGB(255, 255, 187, 59),
          // ),
          border: InputBorder.none,
          // suffixIcon: suffix != null
          //     ? InkWell(
          //         onTap: () {
          //           print('aaaaaaa');
          //         },
          //         child: Padding(
          //           padding:
          //               EdgeInsets.symmetric(vertical: size.height * 0.017),
          //           child: Text('FORGOT?',
          //               style: TextStyle(
          //                   color: Colors.grey, fontWeight: FontWeight.w700)),
          //         ))
          //     : null,
        ),
      ),
    );

Widget DefaultBotton({
  required Size size,
  required Function function,
  required Text text,
}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.85,
      height: size.height * 0.07,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          child: text,
          onPressed: () {
            function();
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 255, 187, 59),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );

Widget DefaultText(
        {required bool login, required context, required Widget widgetTo}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(login ? "Don’t have an Account ? " : "Already have an Account ? ",
            style: Theme.of(context).textTheme.bodyText1),
        GestureDetector(
          onTap: () {
            navigateTo(context, widgetTo);
          },
          child: Text(login ? "REGISTER" : "LOGIN",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold)),
        )
      ],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
