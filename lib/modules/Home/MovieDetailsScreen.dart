import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/layout/Cubit/StateBloc.dart';
import 'package:photoplayuikit/layout/LayoutScreen.dart';
import 'package:photoplayuikit/models/MovieModel/movie.dart';
import 'package:photoplayuikit/modules/Home/CastScreen.dart';
import 'package:photoplayuikit/modules/Home/HomeScreen.dart';
import 'package:photoplayuikit/modules/Login/LoginScreen.dart';
import 'package:photoplayuikit/shared/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/styles/icon_broken.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  final int N;

  const MovieDetailsScreen({super.key, required this.movie, required this.N});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        if (LayoutCubit.get(context).credits!.cast!.length == 0)
          return Platform.isAndroid
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.brown,
                ))
              : CupertinoActivityIndicator(color: Colors.brown);
        return Builder(builder: (context) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(
                  children: [
                    ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original${movie.results![N].backdropPath}',
                        width: size.width,
                        height: size.height * 0.4,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://miro.medium.com/max/495/1*oQAvugLBiJ6AZ9jzQ6EB1g.jpeg'),
                            ),
                          ),
                        ),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: Colors.black12,
                              )
                            : CupertinoActivityIndicator(color: Colors.black12),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                    PositionedDirectional(
                      start: size.width * 0.32,
                      top: size.height * 0.18,
                      child: GestureDetector(
                        onTap: () async {
                          final Uri youtubUrl = Uri.parse(
                              'https://www.youtube.com/embed/${LayoutCubit.get(context).trailerId}');
                          if (await canLaunchUrl(youtubUrl)) {
                            await launchUrl(youtubUrl);
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.yellow,
                              size: size.width * 0.19,
                            ),
                            Text(
                              'Wactwatch now'.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.white, fontSize: 14.0),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: size.width * 0.04,
                      top: size.height * 0.35,
                      child: Text(
                        '${movie.results![N].title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.yellow, fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Column(children: [
                    Text(
                      '${movie.results![N].voteAverage}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: size.width * 0.1,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    RatingBar.builder(
                      unratedColor: dark ? Colors.white24 : Colors.black12,
                      initialRating: movie.results![N].voteAverage / 2,
                      minRating: 1,
                      maxRating: 5,
                      itemCount: 5,
                      itemSize: size.width * 0.06,
                      allowHalfRating: true,
                      itemBuilder: (context, _) => Icon(
                        IconBroken.Star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {},
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: size.height * 0.01, start: size.width * 0.03),
                      child: Text(
                        '${movie.results![N].overview}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      height: size.height * 0.2,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Card(
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${LayoutCubit.get(context).images!.backdrops![index].filePath}',
                              width: size.width * 0.7,
                              height: size.height * 0.2,
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://miro.medium.com/max/495/1*oQAvugLBiJ6AZ9jzQ6EB1g.jpeg'),
                                  ),
                                ),
                              ),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Platform.isAndroid
                                  ? CircularProgressIndicator(
                                      color: Colors.black12,
                                    )
                                  : CupertinoActivityIndicator(
                                      color: Colors.black12),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        itemCount:
                            LayoutCubit.get(context).images!.backdrops!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          width: size.width * 0.03,
                        ),
                      ),
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
                            'Cast',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.w500),
                          ),
                          // SizedBox(
                          //   height: size.height * 0.01,
                          // ),
                          Container(
                            height: size.height * 0.2,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                width: size.width * 0.25,
                                child: Column(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      elevation: 3,
                                      child: GestureDetector(
                                        onTap: () async {
                                          LayoutCubit.get(context).getBiography(
                                              LayoutCubit.get(context)
                                                  .credits!
                                                  .cast![index]
                                                  .id);
                                          LayoutCubit.get(context).getCastKnown(
                                              LayoutCubit.get(context)
                                                  .credits!
                                                  .cast![index]
                                                  .id);
                                          print(LayoutCubit.get(context)
                                              .credits!
                                              .cast![index]
                                              .id);
                                          navigateTo(
                                              context,
                                              CastScreen(
                                                cast: LayoutCubit.get(context)
                                                    .credits!
                                                    .cast![index],
                                                N: 2,
                                              ));
                                        },
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${LayoutCubit.get(context).credits!.cast![index].profilePath}',
                                            width: size.width * 0.3,
                                            height: size.height * 0.1,
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: size.width * 0.05),
                                      child: Text(
                                        '${LayoutCubit.get(context).credits!.cast![index].name}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              itemCount: (LayoutCubit.get(context)
                                          .credits!
                                          .cast!
                                          .length >
                                      10)
                                  ? 10
                                  : LayoutCubit.get(context)
                                      .credits!
                                      .cast!
                                      .length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
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
        });
      },
      listener: (context, state) {},
    );
  }
}
