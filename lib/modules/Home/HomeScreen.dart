import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/layout/Cubit/StateBloc.dart';
import 'package:photoplayuikit/modules/Home/CastScreen.dart';
import 'package:photoplayuikit/shared/components/constants.dart';

import '../../shared/components/compoents.dart';
import '../../shared/styles/icon_broken.dart';
import 'MovieDetailsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  cubit.ModeTheme();
                },
                child: Icon(
                    dark ? Icons.dark_mode_rounded : Icons.dark_mode_outlined),
              ),
              title: Container(
                padding: EdgeInsetsDirectional.only(start: size.width * 0.15),
                child: Text(
                  'Movies-Db'.toUpperCase(),
                ),
              ),
            ),
            body: (cubit.personList != null &&
                    cubit.movielist != null &&
                    cubit.genreslist != null &&
                    cubit.movies != null)
                ? Builder(builder: (context) {
                    cubit.AtHome();
                    return SingleChildScrollView(
                      child: Column(children: [
                        CarouselSlider.builder(
                            itemCount: cubit.movielist!.results!.length,
                            itemBuilder: (context, index, realIndex) {
                              return Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      cubit.getCredits(
                                          cubit.movielist!.results![index].id!);
                                      cubit.getYoutubeId(
                                          cubit.movielist!.results![index].id!);
                                      cubit.getImages(
                                          cubit.movielist!.results![index].id!);
                                      navigateTo(
                                          context,
                                          MovieDetailsScreen(
                                              movie: cubit.movielist!,
                                              N: index));
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/original${cubit.movielist!.results![index].backdropPath}',
                                        width: size.width * 0.85,
                                        height: size.height,
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://miro.medium.com/max/495/1*oQAvugLBiJ6AZ9jzQ6EB1g.jpeg'),
                                            ),
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Platform
                                                .isAndroid
                                            ? const CircularProgressIndicator(
                                                color: Colors.black12,
                                              )
                                            : const CupertinoActivityIndicator(
                                                color: Colors.black12),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: size.width * 0.05,
                                        bottom: size.height * 0.01),
                                    child: Text(
                                      '${cubit.movielist!.results![index].title}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.amberAccent),
                                    ),
                                  ),
                                ],
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(microseconds: 800),
                              pauseAutoPlayOnTouch: true,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            )),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            start: size.width * 0.03,
                          ),
                          height: size.height * 0.08,
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        padding:
                                            EdgeInsetsDirectional.all(10.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white24,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25.0),
                                          ),
                                          color: dark
                                              ? ((cubit.index == index)
                                                  ? Colors.black
                                                  : Colors.white24)
                                              : ((cubit.index == index)
                                                  ? Colors.black87
                                                  : Colors.black12),
                                        ),
                                        child: Text(
                                          '${cubit.genreslist!.genres![index].name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: (cubit.index != index)
                                                      ? Colors.grey
                                                      : Colors.white),
                                        ),
                                      ),
                                      onTap: () {
                                        print(LayoutCubit.get(context)
                                            .images!
                                            .backdrops![0]
                                            .filePath);
                                        cubit.changeIndexId(
                                            index,
                                            cubit.genreslist!.genres![index]
                                                .id!);
                                        cubit.getPlayingMovie(cubit
                                            .genreslist!.genres![index].id!);
                                      },
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  VerticalDivider(
                                    color: Colors.transparent,
                                    width: size.width * 0.01,
                                  ),
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.genreslist!.genres!.length),
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            start: size.width * 0.03,
                          ),
                          height: size.height * 0.32,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () async {
                                cubit.getYoutubeId(cubit
                                    .movies[cubit.index].results![index].id!);
                                cubit.getCredits(cubit
                                    .movies[cubit.index].results![index].id!);
                                cubit.getImages(cubit
                                    .movies[cubit.index].results![index].id!);
                                navigateTo(
                                  context,
                                  MovieDetailsScreen(
                                      movie: cubit.movies[cubit.index],
                                      N: index),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/original${cubit.movies[cubit.index].results![index].posterPath}',
                                      width: size.width * 0.5,
                                      height: size.height * 0.25,
                                      fit: BoxFit.fill,
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
                                  Container(
                                    padding: EdgeInsetsDirectional.only(
                                        top: size.height * 0.01),
                                    width: size.width * 0.5,
                                    child: Text(
                                      '${cubit.movies[cubit.index].results![index].title}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                          unratedColor: dark
                                              ? Colors.white24
                                              : Colors.black12,
                                          initialRating: cubit
                                                  .movies[cubit.index]
                                                  .results![index]
                                                  .voteAverage /
                                              2,
                                          minRating: 1,
                                          maxRating: 5,
                                          itemCount: 5,
                                          itemSize: size.width * 0.06,
                                          allowHalfRating: true,
                                          itemBuilder: (context, _) => Icon(
                                                IconBroken.Star,
                                                color: Colors.amber,
                                              ),
                                          onRatingUpdate: (value) {}),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(
                                        '${cubit.movies[cubit.index].results![index].voteAverage}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            itemCount:
                                cubit.movies[cubit.index].results!.length,
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              width: size.width * 0.05,
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.16,
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
                                      onTap: () {
                                        LayoutCubit.get(context).getBiography(
                                            LayoutCubit.get(context)
                                                .personList!
                                                .results![index + 5]
                                                .id!);
                                        navigateTo(
                                            context,
                                            CastScreen(
                                              results: cubit.personList!
                                                  .results![index + 5],
                                              N: 1,
                                            ));
                                      },
                                      child: ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w200${cubit.personList!.results![index + 5].profilePath}',
                                          width: size.width * 0.3,
                                          height: size.height * 0.1,
                                          fit: BoxFit.cover,
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
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: size.width * 0.05),
                                    child: Text(
                                      '${cubit.personList!.results![index + 5].name}',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            itemCount: cubit.personList!.results!.length - 5,
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                              width: size.width * 0.03,
                            ),
                          ),
                        ),
                      ]),
                    );
                  })
                : Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Please check the network',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
