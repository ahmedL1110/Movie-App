import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/layout/Cubit/StateBloc.dart';
import 'package:photoplayuikit/layout/LayoutScreen.dart';
import 'package:photoplayuikit/modules/Login/cubit/LoginState.dart';
import 'package:photoplayuikit/shared/components/constants.dart';

import '../../shared/components/compoents.dart';
import '../../shared/network/remote/cache_helper.dart';
import '../Resgister/ResgisterScreen.dart';
import 'cubit/LoginCubit.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            //print(state.error.);
            showToast(text: state.error, state: ToastStates.ERROR);
          } else if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              LayoutCubit.get(context)
                  .getUserData(uId: state.uId)
                  .then((value) {
                LayoutCubit.get(context).changeBottomNac(0);
                navigateAndFinish(context, LayoutScreen());
              }).catchError((error) {
                print(error.toString());
              });
            });
          }
          if (state is ResetErrorState) {
            //print(state.error.);
            showToast(text: state.error, state: ToastStates.ERROR);
          } else if (state is ResetSuccessState) {
            showToast(text: 'Check email', state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(children: [
              Image(
                image: AssetImage(
                    dark ? 'asset/images/p2.PNG' : 'asset/images/p1.PNG'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: size.height * 0.45,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.38,
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.only(
                              start: size.width * 0.1),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'EMAIL',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              DefailTextFild(
                                context,
                                email: email.text,
                                size: size,
                                type: TextInputType.emailAddress,
                                stringError: 'please enter your email address',
                                hintText: 'Email Address',
                                prefix: Icons.email_outlined,
                                controller: email,
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Text(
                                'PASSWORD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              DefailTextFild(
                                context,
                                email: email.text,
                                //isPassword: LoginCubit.get(context).isPassword,
                                size: size,
                                controller: password,
                                type: TextInputType.visiblePassword,
                                stringError: 'please enter your password',
                                hintText: 'Password',
                                prefix: Icons.lock,
                                suffix: Icons.visibility_outlined,
                                suffixPressed: () {
                                  //LoginCubit.get(context).changePasswordVisibility();
                                },
                              ),
                              SizedBox(
                                height: size.height * .02,
                              ),
                              if (true)
                                DefaultBotton(
                                    size: size,
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: email.text,
                                            password: password.text);
                                      }
                                    },
                                    text: 'LOGIN')
                              else
                                Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.lightGreen,
                                  ),
                                ),
                              Row(
                                children: [
                                  Container(
                                    height: 1,
                                    width: size.width * 0.26,
                                    color: Color.fromARGB(106, 137, 137, 137),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.01,
                                        horizontal: size.width * 0.05),
                                    child: Text(
                                      'Social Login',
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: size.width * 0.26,
                                    color: Color.fromARGB(106, 137, 137, 137),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.facebook,
                                          color:
                                              Color.fromARGB(255, 255, 187, 59),
                                          size: size.width * 0.16),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Icon(Icons.g_mobiledata_outlined,
                                          color:
                                              Color.fromARGB(255, 255, 187, 59),
                                          size: size.width * 0.2)
                                    ]),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              DefaultText(
                                login: true,
                                context: context,
                                widgetTo: ResgisterScreen(),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}

Widget DefailTextFild(context,
        {required String email,
        required Size size,
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
            icon: Icon(
              prefix,
              color: Color.fromARGB(255, 255, 187, 59),
            ),
            border: InputBorder.none,
            suffixIcon: suffix != null
                ? InkWell(
                    onTap: () {
                      LoginCubit.get(context).ResetPassword(email: email);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.017),
                      child: Text('FORGOT?',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w700)),
                    ))
                : null),
      ),
    );

Widget DefaultBotton({
  required Size size,
  required Function function,
  required String text,
}) =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.85,
      height: size.height * 0.07,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ElevatedButton(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
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
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, widgetTo);
          },
          child: Text(
            login ? "REGISTER" : "Sign In",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
