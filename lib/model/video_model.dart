// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  String? url;
  String? quality;
  String? extension;
  int size;
  String? formattedSize;
  bool videoAvailable;
  bool audioAvailable;
  bool chunked;
  bool cached;

  Video({
    required this.url,
    required this.quality,
    required this.extension,
    required this.size,
    required this.formattedSize,
    required this.videoAvailable,
    required this.audioAvailable,
    required this.chunked,
    required this.cached,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    url: json["url"],
    quality: json["quality"],
    extension: json["extension"],
    size: json["size"],
    formattedSize: json["formattedSize"],
    videoAvailable: json["videoAvailable"],
    audioAvailable: json["audioAvailable"],
    chunked: json["chunked"],
    cached: json["cached"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "quality": quality,
    "extension": extension,
    "size": size,
    "formattedSize": formattedSize,
    "videoAvailable": videoAvailable,
    "audioAvailable": audioAvailable,
    "chunked": chunked,
    "cached": cached,
  };
}
