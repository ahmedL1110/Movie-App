import 'package:equatable/equatable.dart';

abstract class LayoutState {}


class InitialState extends LayoutState {}

class GetUserLoadingState extends LayoutState {}

class GetUserSuccessState extends LayoutState {}

class GetUserErrorState extends LayoutState {
  final String error;

  GetUserErrorState(this.error);
}

class ChangeBottomNavState extends LayoutState {}

class ChangeAddressState extends LayoutState {}

class AtHomeState extends LayoutState {}

class ModeThemeState extends LayoutState {}

class ChangeLanguageState extends LayoutState {}

class ChangeNotificationSetting1State extends LayoutState {}

class ChangeNotificationSetting2State extends LayoutState {}

class GetProductsLoadingState extends LayoutState {}

class GetProductsSuccessState extends LayoutState {}

class GetProductsErrorState extends LayoutState {
  final String error;

  GetProductsErrorState(this.error);
}

class GetFavouriteLoadingState extends LayoutState {}

class GetFavouriteSuccessState extends LayoutState {}

class GetFavouriteErrorState extends LayoutState {
  final String error;

  GetFavouriteErrorState(this.error);
}

class CheckFavouriteErrorState extends LayoutState {
  final String error;

  CheckFavouriteErrorState(this.error);
}

class SetFavouriteLoadingState extends LayoutState {}

class SetFavouriteSuccessState extends LayoutState {}

class SetFavouriteErrorState extends LayoutState {
  final String error;

  SetFavouriteErrorState(this.error);
}

class DeleteFavouriteLoadingState extends LayoutState {}

class DeleteFavouriteSuccessState extends LayoutState {}

class DeleteFavouriteErrorState extends LayoutState {
  final String error;

  DeleteFavouriteErrorState(this.error);
}

class NowPlayingMovieLoadingState extends LayoutState {}

class NowPlayingMovieSuccessState extends LayoutState {}

class NowPlayingMovieErrorState extends LayoutState {}

class GetPersonListLoadingState extends LayoutState {}

class GetPersonListSuccessState extends LayoutState {}

class GetPersonListErrorState extends LayoutState {}

class GetPlayingMovieLoadingState extends LayoutState {}

class GetPlayingMovieSuccessState extends LayoutState {}

class GetPlayingMovieErrorState extends LayoutState {}

class GetGenresListLoadingState extends LayoutState {}

class GetGenresListSuccessState extends LayoutState {}

class GetGenresListErrorState extends LayoutState {}

class GetYoutubeIdLoadingState extends LayoutState {}

class GetYoutubeIdSuccessState extends LayoutState {}

class GetYoutubeIdErrorState extends LayoutState {}

class GetCreditsLoadingState extends LayoutState {}

class GetCreditsSuccessState extends LayoutState {}

class GetCreditsErrorState extends LayoutState {}

class GetImagesLoadingState extends LayoutState {}

class GetImagesSuccessState extends LayoutState {}

class GetImagesErrorState extends LayoutState {}

class GetBiographyLoadingState extends LayoutState {}

class GetBiographySuccessState extends LayoutState {}

class GetBiographyErrorState extends LayoutState {}

class GetSearchLoadingState extends LayoutState {}

class GetSearchSuccessState extends LayoutState {}

class GetSearchErrorState extends LayoutState {}

class SearchNull extends LayoutState {}

class ChangeNetWork extends LayoutState {}



class ChangeIndexId extends LayoutState {}