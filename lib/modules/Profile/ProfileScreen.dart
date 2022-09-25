import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/layout/Cubit/StateBloc.dart';
import 'package:photoplayuikit/modules/Login/LoginScreen.dart';
import 'package:photoplayuikit/shared/components/compoents.dart';
import 'package:photoplayuikit/shared/components/constants.dart';
import 'package:photoplayuikit/shared/network/remote/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          body: Container(
              padding: EdgeInsetsDirectional.only(
                  top: size.width * 0.1,
                  end: size.width * 0.1,
                  start: size.width * 0.1),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    width: size.width*0.4,
                    child: Card(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      elevation: 3,
                      child: ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl:
                          '${LayoutCubit.get(context).usermodel!.image}',
                          height: size.height * 0.18,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://miro.medium.com/max/495/1*oQAvugLBiJ6AZ9jzQ6EB1g.jpeg'),
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                          Platform.isAndroid
                              ? CircularProgressIndicator(
                            color: Colors.black12,
                          )
                              : CupertinoActivityIndicator(
                              color: Colors.black12),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                  // Center(
                  //   child: CircleAvatar(
                  //     radius: size.height * 0.09,
                  //     backgroundColor:
                  //         Theme.of(context).scaffoldBackgroundColor,
                  //     child: CircleAvatar(
                  //       radius: size.height * 0.088,
                  //       child:
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '${LayoutCubit.get(context).usermodel!.firstname}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 30.0),
                  ),
                  Text(
                    '${LayoutCubit.get(context).usermodel!.lastname}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 22.0,color: Colors.yellow),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  buildMyAccount(context,
                      size: size,
                      title: 'Account',
                      icon: Icons.account_circle_sharp),
                  Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                  buildMyAccount(context,
                      size: size, title: 'Settings', icon: Icons.settings),
                  Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                  buildMyAccount(context,
                      size: size, title: 'Help', icon: Icons.help),
                  Container(
                    color: Colors.grey[300],
                    width: double.infinity,
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      uId = '-1';
                      CacheHelper.saveData(key: 'uId', value: uId);
                      navigateAndFinish(context, LoginScreen());
                    },
                    child: buildMyAccount(context,
                        size: size,
                        title: 'Log Out',
                        icon: Icons.logout_outlined),
                  ),
                ],
              )),
        );
      },
      listener: (context, state) {},
    );
  }
}

Widget buildMyAccount(BuildContext context,
        {required Size size, required String title, required IconData icon}) =>
    InkWell(
      // onTap: (){
      //   navigateTo(context, Screento);
      // },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.022, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon,
                size: size.width * .09, color: Color.fromARGB(255, 90, 90, 90)),
            SizedBox(
              width: size.width * 0.04,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
