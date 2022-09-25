import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:photoplayuikit/layout/Cubit/CubitBloc.dart';
import 'package:photoplayuikit/layout/Cubit/StateBloc.dart';

import '../../shared/components/compoents.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/icon_broken.dart';
import '../Home/MovieDetailsScreen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          body: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: size.width * 0.02,
                  end: size.width * 0.02,
                  top: size.height * 0.03),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset.fromDirection(1.5, 10),
                            spreadRadius: 0,
                            blurRadius: 10.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        print(value);
                        if (value != '')
                          LayoutCubit.get(context).getSearch(value);
                        else
                          LayoutCubit.get(context).searchNull;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.black12,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                    ),
                  ),
                ),
                if(LayoutCubit.get(context).search != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1 / 1.45,
                      children: List.generate(
                        LayoutCubit.get(context).search!.results!.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(

                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w400${LayoutCubit.get(context).search!.results![index].posterPath}',
                                  width: size.width * 0.45,
                                  height: size.height * 0.25,
                                  errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://miro.medium.com/max/495/1*oQAvugLBiJ6AZ9jzQ6EB1g.jpeg'),
                                      ),
                                    ),
                                  ),
                                  fit: BoxFit.fill,
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
                              onTap: () async {
                                LayoutCubit.get(context).getCredits(
                                    LayoutCubit.get(context).search!.results![index].id!);
                                LayoutCubit.get(context).getYoutubeId(
                                    LayoutCubit.get(context).search!.results![index].id!);
                                LayoutCubit.get(context).getImages(
                                    LayoutCubit.get(context).search!.results![index].id!);
                                navigateTo(
                                  context,
                                  MovieDetailsScreen(
                                      movie: LayoutCubit.get(context).search!, N: index),
                                );
                              },
                            ),
                            Container(
                              padding: EdgeInsetsDirectional.only(
                                  top: size.height * 0.01),
                              width: size.width * 0.42,
                              child: Text(
                                '${LayoutCubit.get(context).search!.results![index].title}',
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                    unratedColor:
                                        dark ? Colors.white24 : Colors.black12,
                                    initialRating: LayoutCubit.get(context)
                                            .search!
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
                                  '${LayoutCubit.get(context).search!.results![index].voteAverage}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
