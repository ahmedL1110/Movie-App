class Images {
  List<Backdrops>? backdrops;
  int? id;
  List<Logos>? logos;

  Images({this.backdrops, this.id, this.logos});

  Images.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = <Backdrops>[];
      json['backdrops'].forEach((v) {
        backdrops!.add(new Backdrops.fromJson(v));
      });
    }
    id = json['id'];
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos!.add(new Logos.fromJson(v));
      });
    }

  }

}

class Backdrops {
  dynamic aspectRatio;
  dynamic height;
  String? iso6391;
  String? filePath;
  dynamic voteAverage;
  dynamic voteCount;
  dynamic width;

  Backdrops(
      {this.aspectRatio,
        this.height,
        this.iso6391,
        this.filePath,
        this.voteAverage,
        this.voteCount,
        this.width});

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['file_path'] = this.filePath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }
}

class Logos {
  dynamic aspectRatio;
  dynamic height;
  String? iso6391;
  String? filePath;
  dynamic voteAverage;
  dynamic voteCount;
  dynamic width;

  Logos(
      {this.aspectRatio,
        this.height,
        this.iso6391,
        this.filePath,
        this.voteAverage,
        this.voteCount,
        this.width});

  Logos.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['file_path'] = this.filePath;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }
}
