import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoplayuikit/layout/LayoutScreen.dart';
import 'package:photoplayuikit/models/CreditsModel/credits.dart';
import 'package:photoplayuikit/models/CreditsModel/persons.dart';

import '../../layout/Cubit/CubitBloc.dart';
import '../../layout/Cubit/StateBloc.dart';
import '../../shared/components/compoents.dart';
import '../../shared/styles/icon_broken.dart';

class CastScreen extends StatelessWidget {
  final Cast? cast;
  final Results? results;
  final int N;

  const CastScreen({super.key, this.cast, this.results, required this.N});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black87,
                              //offset: Offset.fromDirection(1.5, 10),
                              spreadRadius: 0,
                              blurRadius: 100.0),
                        ],
                        //borderRadius: BorderRadius.circular(10),
                        //color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.1),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://image.tmdb.org/t/p/w500${N == 2 ? cast!
                                    .profilePath : results!.profilePath}',
                                fit: BoxFit.cover,
                                height: size.height * 0.35,
                                errorWidget: (context, url, error) =>
                                    Container(
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
                                Radius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: size.width * 0.03,
                      top: size.height * 0.05,
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, LayoutScreen());
                        },
                        child: Row(
                          children: [
                            Icon(IconBroken.Arrow___Left_2),
                            Text(
                              'BACK',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Column(children: [
                    Padding(
                      padding:
                      EdgeInsetsDirectional.only(start: size.width * 0.03),
                      child: Text(
                        '${N == 2 ? cast!.name : results!.name}',
                        maxLines: 1,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: size.height * 0.015, start: size.width * 0.03),
                      child: Text('${cubit.biography}',
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              fontSize: size.width * 0.043,
                              color: Colors.grey)),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    Container(
                      padding:
                      EdgeInsetsDirectional.only(start: size.width * 0.03),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Known for',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          if (N == 2 &&
                              LayoutCubit
                                  .get(context)
                                  .imagesCast
                                  .length != 3)
                            Platform.isAndroid
                                ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black12,
                                ))
                                : CupertinoActivityIndicator(
                                color: Colors.black12)
                          else
                            Container(
                              height: size.height * 0.3,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            'https://image.tmdb.org/t/p/original${N ==
                                                2 ? LayoutCubit
                                                .get(context)
                                                .imagesCast[index] : results!
                                                .knownFor![index].posterPath}',
                                            width: size.width * 0.3,
                                            height: size.height * 0.2,
                                            fit: BoxFit.fill,
                                            errorWidget: (context, url,
                                                error) =>
                                                Container(
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
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsetsDirectional.only(
                                              top: size.height * 0.01),
                                          width: size.width * 0.3,
                                          child: Text(
                                            '${N == 2 ? LayoutCubit
                                                .get(context)
                                                .nameCast[index] : results!
                                                .knownFor![index].title}',
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .bodyText1,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                itemCount: 3,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          );
          // return Platform.isAndroid
          //     ? Center(
          //         child: CircularProgressIndicator(
          //         color: Colors.brown,
          //       ))
          //     : CupertinoActivityIndicator(color: Colors.brown);
        });
  }
}
