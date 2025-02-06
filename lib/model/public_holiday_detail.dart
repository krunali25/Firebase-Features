// To parse this JSON data, do
//
//     final publicHolidayDetail = publicHolidayDetailFromJson(jsonString);

import 'dart:convert';

List<PublicHolidayDetail> publicHolidayDetailFromJson(String str) => List<PublicHolidayDetail>.from(json.decode(str).map((x) => PublicHolidayDetail.fromJson(x)));

String publicHolidayDetailToJson(List<PublicHolidayDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicHolidayDetail {
  DateTime? date;
  String? localName;
  String? name;
  CountryCode? countryCode;
  bool? fixed;
  bool? global;
  List<String>? counties;
  dynamic launchYear;
  List<String>? types;

  PublicHolidayDetail({
    required this.date,
    required this.localName,
    required this.name,
    required this.countryCode,
    required this.fixed,
    required this.global,
    required this.counties,
    required this.launchYear,
    required this.types,
  });

  factory PublicHolidayDetail.fromJson(Map<String, dynamic> json) => PublicHolidayDetail(
    date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
    localName: json["localName"] ?? "Unknown",
    name: json["name"] ?? "Unknown",
    countryCode: json["countryCode"] != null ? countryCodeValues.map[json["countryCode"]] : null,
    fixed: json["fixed"] ?? false,
    global: json["global"] ?? false,
    counties: json["counties"] != null ? List<String>.from(json["counties"]) : [],
    launchYear: json["launchYear"],
    types: json["types"] != null ? List<String>.from(json["types"]) : [],
  );


  Map<String, dynamic> toJson() => {
    "date": date != null
        ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
        : null,
    "localName": localName,
    "name": name,
    "countryCode": countryCodeValues.reverse[countryCode],
    "fixed": fixed,
    "global": global,
    "counties": counties == null ? [] : List<dynamic>.from(counties!.map((x) => x)),
    "launchYear": launchYear,
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
  };

}

enum CountryCode {
  US
}

final countryCodeValues = EnumValues({
  "US": CountryCode.US
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
