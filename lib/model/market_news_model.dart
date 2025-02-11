// To parse this JSON data, do
//
//     final marketNews = marketNewsFromJson(jsonString);

import 'dart:convert';

MarketNews marketNewsFromJson(String str) => MarketNews.fromJson(json.decode(str));

String marketNewsToJson(MarketNews data) => json.encode(data.toJson());

class MarketNews {
  String? id;
  String? type;
  Attributes attributes;
  Relationships relationships;
  Links links;

  MarketNews({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
    required this.links,
  });

  factory MarketNews.fromJson(Map<String, dynamic> json) => MarketNews(
    id: json["id"],
    type: json["type"],
    attributes: Attributes.fromJson(json["attributes"]),
    relationships: Relationships.fromJson(json["relationships"]),
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attributes": attributes.toJson(),
    "relationships": relationships.toJson(),
    "links": links.toJson(),
  };
}

class Attributes {
  DateTime publishOn;
  bool isLockedPro;
  int commentCount;
  String? gettyImageUrl;
  dynamic videoPreviewUrl;
  dynamic videoDuration;
  Themes themes;
  String? title;
  bool isPaywalled;
  DateTime lastModified;
  String? status;
  String? content;
  bool metered;
  dynamic correctionReason;
  double audioDuration;

  Attributes({
    required this.publishOn,
    required this.isLockedPro,
    required this.commentCount,
    required this.gettyImageUrl,
    required this.videoPreviewUrl,
    required this.videoDuration,
    required this.themes,
    required this.title,
    required this.isPaywalled,
    required this.lastModified,
    required this.status,
    required this.content,
    required this.metered,
    required this.correctionReason,
    required this.audioDuration,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    publishOn: DateTime.parse(json["publishOn"]),
    isLockedPro: json["isLockedPro"],
    commentCount: json["commentCount"],
    gettyImageUrl: json["gettyImageUrl"],
    videoPreviewUrl: json["videoPreviewUrl"],
    videoDuration: json["videoDuration"],
    themes: Themes.fromJson(json["themes"]),
    title: json["title"],
    isPaywalled: json["isPaywalled"],
    lastModified: DateTime.parse(json["lastModified"]),
    status: json["status"],
    content: json["content"],
    metered: json["metered"],
    correctionReason: json["correctionReason"],
    audioDuration: json["audioDuration"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "publishOn": publishOn.toIso8601String(),
    "isLockedPro": isLockedPro,
    "commentCount": commentCount,
    "gettyImageUrl": gettyImageUrl,
    "videoPreviewUrl": videoPreviewUrl,
    "videoDuration": videoDuration,
    "themes": themes.toJson(),
    "title": title,
    "isPaywalled": isPaywalled,
    "lastModified": lastModified.toIso8601String(),
    "status": status,
    "content": content,
    "metered": metered,
    "correctionReason": correctionReason,
    "audioDuration": audioDuration,
  };
}

class Themes {
  Global us;
  Global naCap;
  Global global;
  Global usEconomy;
  Global newsMetered;
  Global tariffs;

  Themes({
    required this.us,
    required this.naCap,
    required this.global,
    required this.usEconomy,
    required this.newsMetered,
    required this.tariffs,
  });

  factory Themes.fromJson(Map<String, dynamic> json) => Themes(
    us: Global.fromJson(json["us"]),
    naCap: Global.fromJson(json["na-cap"]),
    global: Global.fromJson(json["global"]),
    usEconomy: Global.fromJson(json["us-economy"]),
    newsMetered: Global.fromJson(json["news-metered"]),
    tariffs: Global.fromJson(json["tariffs"]),
  );

  Map<String, dynamic> toJson() => {
    "us": us.toJson(),
    "na-cap": naCap.toJson(),
    "global": global.toJson(),
    "us-economy": usEconomy.toJson(),
    "news-metered": newsMetered.toJson(),
    "tariffs": tariffs.toJson(),
  };
}

class Global {
  int id;
  String? path;
  String? slug;
  String? title;
  String? sasource;
  bool nonTheme;

  Global({
    required this.id,
    required this.path,
    required this.slug,
    required this.title,
    required this.sasource,
    required this.nonTheme,
  });

  factory Global.fromJson(Map<String, dynamic> json) => Global(
    id: json["id"],
    path: json["path"],
    slug: json["slug"],
    title: json["title"],
    sasource: json["sasource"],
    nonTheme: json["non_theme"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
    "slug": slug,
    "title": title,
    "sasource": sasource,
    "non_theme": nonTheme,
  };
}

class Links {
  String self;
  String canonical;
  String uriImage;
  List<String> schemaImage;

  Links({
    required this.self,
    required this.canonical,
    required this.uriImage,
    required this.schemaImage,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"],
    canonical: json["canonical"],
    uriImage: json["uriImage"],
    schemaImage: List<String>.from(json["schemaImage"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "canonical": canonical,
    "uriImage": uriImage,
    "schemaImage": List<dynamic>.from(schemaImage.map((x) => x)),
  };
}

class Relationships {
  Author author;
  OtherTags sentiments;
  OtherTags primaryTickers;
  OtherTags secondaryTickers;
  OtherTags otherTags;
  RatingChangeNotice ratingChangeNotice;

  Relationships({
    required this.author,
    required this.sentiments,
    required this.primaryTickers,
    required this.secondaryTickers,
    required this.otherTags,
    required this.ratingChangeNotice,
  });

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
    author: Author.fromJson(json["author"]),
    sentiments: OtherTags.fromJson(json["sentiments"]),
    primaryTickers: OtherTags.fromJson(json["primaryTickers"]),
    secondaryTickers: OtherTags.fromJson(json["secondaryTickers"]),
    otherTags: OtherTags.fromJson(json["otherTags"]),
    ratingChangeNotice: RatingChangeNotice.fromJson(json["ratingChangeNotice"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author.toJson(),
    "sentiments": sentiments.toJson(),
    "primaryTickers": primaryTickers.toJson(),
    "secondaryTickers": secondaryTickers.toJson(),
    "otherTags": otherTags.toJson(),
    "ratingChangeNotice": ratingChangeNotice.toJson(),
  };
}

class Author {
  Dat data;

  Author({
    required this.data,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    data: Dat.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Dat {
  String id;
  Type type;

  Dat({
    required this.id,
    required this.type,
  });

  factory Dat.fromJson(Map<String, dynamic> json) => Dat(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
  };
}

enum Type {
  NEWS_AUTHOR_USER,
  TAG
}

final typeValues = EnumValues({
  "newsAuthorUser": Type.NEWS_AUTHOR_USER,
  "tag": Type.TAG
});

class OtherTags {
  List<Dat> data;

  OtherTags({
    required this.data,
  });

  factory OtherTags.fromJson(Map<String, dynamic> json) => OtherTags(
    data: List<Dat>.from(json["data"].map((x) => Dat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RatingChangeNotice {
  RatingChangeNotice();

  factory RatingChangeNotice.fromJson(Map<String, dynamic> json) => RatingChangeNotice(
  );

  Map<String, dynamic> toJson() => {
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
