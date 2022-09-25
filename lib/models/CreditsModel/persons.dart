class Persons {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  Persons({this.page, this.results, this.totalPages, this.totalResults});

  Persons.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class Results {
  bool? adult;
  int? id;
  String? name;
  String? originalName;
  String? mediaType;
  dynamic popularity;
  int? gender;
  String? knownForDepartment;
  String? profilePath;
  List<KnownFor>? knownFor;

  Results(
      {this.adult,
        this.id,
        this.name,
        this.originalName,
        this.mediaType,
        this.popularity,
        this.gender,
        this.knownForDepartment,
        this.profilePath,
        this.knownFor});

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    mediaType = json['media_type'];
    popularity = json['popularity'];
    gender = json['gender'];
    knownForDepartment = json['known_for_department'];
    profilePath = json['profile_path'];
    if (json['known_for'] != null) {
      knownFor = <KnownFor>[];
      json['known_for'].forEach((v) {
        knownFor!.add(new KnownFor.fromJson(v));
      });
    }
  }
}

class KnownFor {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  List<int>? genreIds;
  dynamic popularity;
  String? releaseDate;
  bool? video;
  dynamic voteAverage;
  int? voteCount;

  KnownFor(
      {this.adult,
        this.backdropPath,
        this.id,
        this.title,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.posterPath,
        this.mediaType,
        this.genreIds,
        this.popularity,
        this.releaseDate,
        this.video,
        this.voteAverage,
        this.voteCount});

  KnownFor.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    genreIds = json['genre_ids'].cast<int>();
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

}
