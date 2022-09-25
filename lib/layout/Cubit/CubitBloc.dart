import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photoplayuikit/models/CreditsModel/credits.dart';
import 'package:photoplayuikit/models/CreditsModel/persons.dart';
import 'package:photoplayuikit/models/GenresModel/genres.dart';
import 'package:photoplayuikit/models/ImagesModel/images.dart';
import 'package:photoplayuikit/models/MovieModel/movie.dart';
import 'package:photoplayuikit/modules/Profile/ProfileScreen.dart';
import 'package:photoplayuikit/modules/Search/SearchScreen.dart';
import 'package:photoplayuikit/shared/network/remote/dio_helper.dart';
import '../../models/UserModel/user_model.dart';
import '../../modules/Home/HomeScreen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/remote/cache_helper.dart';
import 'StateBloc.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? usermodel;
  Future<void> getUserData(
      {
        required String uId
      }
      ) async {
    print('1');
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      usermodel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }
  AtHome(){
    emit(AtHomeState());
  }
  changeAddress(String st) {
    address = st;
    emit(ChangeAddressState());
  }

  IconData? icon;

  void ModeTheme() {
    dark=!dark;
    CacheHelper.saveData(key: 'dark', value: dark);
    emit(ModeThemeState());
  }

  int LanguageIndex = CacheHelper.getData(key: 'LanguageIndex') ?? 1;

  changeLanguage(int i) {
    LanguageIndex = i;
    CacheHelper.saveData(key: 'LanguageIndex', value: i);
    emit(ChangeLanguageState());
  }

  bool NotificationSetting1 =
      CacheHelper.getData(key: 'NotificationSetting1') ?? false;

  changeNotificationSetting1(bool s1) {
    NotificationSetting1 = s1;
    CacheHelper.saveData(key: 'NotificationSetting1', value: s1);
    emit(ChangeNotificationSetting1State());
  }

  bool NotificationSetting2 =
      CacheHelper.getData(key: 'NotificationSetting2') ?? false;

  changeNotificationSetting2(bool s2) {
    NotificationSetting2 = s2;
    CacheHelper.saveData(key: 'NotificationSetting2', value: s2);
    emit(ChangeNotificationSetting2State());
  }



  int currenIndex = 0;

  String address = '';

  List<Widget> screen = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  void changeBottomNac(int index) {
    currenIndex = index;
    emit(ChangeBottomNavState());
  }

  Movie? movielist;

  Future<void> getNowPlayingMovie()async {
    emit(NowPlayingMovieLoadingState());

    DioHelper.gatData(url: '/movie/now_playing?').then((value) {
      movielist = Movie.fromJson(value.data);
      getImages(movielist!.results![0].id!);
      getCredits(movielist!.results![0].id!);
      // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      // print(movielist!.results![1].backdropPath);
      emit(NowPlayingMovieSuccessState());
    }).catchError((error) {
      // print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(NowPlayingMovieErrorState());
    });
  }

  Genre? genreslist;
  List<Movie> movies = [];

  Future<void> getGenresList() async{
    emit(GetGenresListLoadingState());

    DioHelper.gatData(url: '/genre/movie/list?').then((value) {
      genreslist = Genre.fromJson(value.data);
      genreslist!.genres!.forEach((element) {
        getPlayingMovie(element.id!);
      });

      emit(GetGenresListSuccessState());
    }).catchError((error) {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(GetGenresListErrorState());
    });
  }

  int index = 0;
  int? id;

  void changeIndexId(int index1, int id2) {
    index = index1;
    id = id2;
    emit(ChangeIndexId());
  }

  void getPlayingMovie(int id) {
    emit(GetPlayingMovieLoadingState());
    DioHelper.gatData(url: '/discover/movie?with_genres=${id}&').then((value) {
      movies.add(Movie.fromJson(value.data));
      emit(GetPlayingMovieSuccessState());
    }).catchError((error) {
      //print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(GetPlayingMovieErrorState());
    });
  }

  Persons? personList;

  Future<void> getPersonList() async {
    emit(GetPersonListLoadingState());

    DioHelper.gatData(url: '/trending/person/week?').then((value) {
      personList = Persons.fromJson(value.data);

      emit(GetProductsSuccessState());
    }).catchError((error) {
      print('hwwwwwwwwwwwwwwwww');
      print(error.toString());

      emit(GetPersonListErrorState());
    });
  }

  String? trailerId;

  void getYoutubeId(int id) {
    trailerId = null;
    emit(GetYoutubeIdLoadingState());

    DioHelper.gatData(url: '/movie/$id/videos?').then((value) {
      trailerId = value.data['results'][0]['key'];
      emit(GetYoutubeIdSuccessState());
    }).catchError((error) {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(GetYoutubeIdErrorState());
    });
  }

  Images? images;

  void getImages(int id) {
    emit(GetImagesLoadingState());

    DioHelper.gatData(url: '/movie/$id/images?').then((value) {
      images = Images.fromJson(value.data);

      // print('awaslkaasl;;;;;;;;;;;;;;;;;asssssssssssssssssssssssssssssss');
      //print(genreslist!.genres![0].name);
      emit(GetImagesSuccessState());
    }).catchError((error) {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(GetImagesErrorState());
    });
  }

  Credits? credits;

  void getCredits(int id) {
    emit(GetCreditsLoadingState());

    DioHelper.gatData(url: '/movie/${id}/credits?').then((value) {
      credits = Credits.fromJson(value.data);

      print('saqwWASLKKKKKKKKKKKKKDFAHSFDldfklsdds');
      //print(genreslist!.genres![0].name);
      emit(GetCreditsSuccessState());
    }).catchError((error) {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(GetCreditsErrorState());
    });
  }

  String? biography;

  void getBiography(int id) {
    emit(GetBiographyLoadingState());

    DioHelper.gatData(url: '/person/$id?').then((value) {
      biography = value.data['biography'];
      // print('saqwWASLKKKKKKKKKKKKKDFAHSFDldfklsdds');
      emit(GetBiographySuccessState());
    }).catchError((error) {
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      print(error.toString());

      emit(GetBiographyErrorState());
    });
  }

  List<String> imagesCast = [];
  List<String> nameCast = [];
  List<int> idCast = [];

  void getCastKnown(int id) {
    emit(GetBiographyLoadingState());
    DioHelper.gatData(url: '/person/$id/movie_credits?').then((value) {
      imagesCast = [];
      nameCast = [];
      idCast = [];
      print(value.data['cast'][0]['poster_path'].toString());
      imagesCast.add(value.data['cast'][0]['poster_path']);
      print(imagesCast[0]);
      imagesCast.add(value.data['cast'][1]['poster_path']);
      imagesCast.add(value.data['cast'][2]['poster_path']);

      nameCast.add(value.data['cast'][0]['title']);
      nameCast.add(value.data['cast'][1]['title']);
      nameCast.add(value.data['cast'][2]['title']);

      idCast.add(value.data['cast'][0]['id']);
      idCast.add(value.data['cast'][1]['id']);
      idCast.add(value.data['cast'][2]['id']);

      print('saqwWASLKKKKKKKKKKKKKDFAHSFDldfklsdds');
      emit(GetBiographySuccessState());
    }).catchError((error) {
      print('waaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      print(error.toString());

      emit(GetBiographyErrorState());
    });
  }
  Movie? search;

  void getSearch(String searchString) {
    emit(GetSearchLoadingState());
    DioHelper.gatData(url: '/search/movie?',sea: '&language=en-US&query=$searchString&page=1&include_adult=false').then((value) {
      print(value.data.toString());
      search = Movie.fromJson(value.data);
      print(search!.results!.length);
      print('saqwWASLKKKKKKKKKKKKKDFAHSFDldfklsdds');
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print('waaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      print(error.toString());

      emit(GetSearchErrorState());
    });
  }

  void searchNull(){
    search!.results = [];
    emit(SearchNull());
  }
  Future<void> re()async {
    await Future.delayed(Duration(seconds: 0),);
    emit(SearchNull());
  }

  Future<void> changeNetWork()async {
    await Future.delayed(Duration(seconds: 3),);
    emit(ChangeNetWork());
  }
}
