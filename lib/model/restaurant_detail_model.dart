// To parse this JSON data, do
//
//     final restaurantDescription = restaurantDescriptionFromJson(jsonString);

import 'dart:convert';

RestaurantDescription restaurantDescriptionFromJson(dynamic str) => RestaurantDescription.fromJson(str);

String restaurantDescriptionToJson(RestaurantDescription data) => json.encode(data.toJson());

class RestaurantDescription {
  int matchingResults;
  List<Restaurant> restaurants;

  RestaurantDescription({
    required this.matchingResults,
    required this.restaurants,
  });

  factory RestaurantDescription.fromJson(Map<String, dynamic> json) => RestaurantDescription(
    matchingResults: json["matching_results"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "matching_results": matchingResults,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class Restaurant {
  int id;
  String restaurantName;
  String address;
  String zipCode;
  String phone;
  String website;
  String latitude;
  String longitude;
  String stateName;
  String cityName;
  String cuisineType;
  String? hoursInterval;

  Restaurant({
    required this.id,
    required this.restaurantName,
    required this.address,
    required this.zipCode,
    required this.phone,
    required this.website,
    required this.latitude,
    required this.longitude,
    required this.stateName,
    required this.cityName,
    required this.cuisineType,
    this.hoursInterval,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    restaurantName: json["restaurantName"],
    address: json["address"],
    zipCode: json["zipCode"],
    phone: json["phone"],
    website: json["website"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    stateName: json["stateName"],
    cityName: json["cityName"],
    cuisineType: json["cuisineType"],
    hoursInterval: json["hoursInterval"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurantName": restaurantName,
    "address": address,
    "zipCode": zipCode,
    "phone": phone,
    "website": website,
    "latitude": latitude,
    "longitude": longitude,
    "stateName": stateName,
    "cityName": cityName,
    "cuisineType": cuisineType,
    "hoursInterval": hoursInterval,
  };
}

