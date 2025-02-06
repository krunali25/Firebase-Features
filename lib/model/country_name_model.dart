// To parse this JSON data, do
//
//     final countryName = countryNameFromJson(jsonString);

import 'dart:convert';

List<CountryName> countryNameFromJson(String str) => List<CountryName>.from(json.decode(str).map((x) => CountryName.fromJson(x)));

String countryNameToJson(List<CountryName> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryName {
  String country;
  String code;

  CountryName({
    required this.country,
    required this.code,
  });

  factory CountryName.fromJson(Map<String, dynamic> json) => CountryName(
    country: json["country"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "code": code,
  };
}
