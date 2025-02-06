
import 'dart:convert';

RestaurantName restaurantFromJson(dynamic str) => RestaurantName.fromJson(json.decode(str));

String restaurantToJson(RestaurantName data) => json.encode(data.toJson());

class RestaurantName {
  String restaurantChainName;

  RestaurantName({
    required this.restaurantChainName,
  });

  factory RestaurantName.fromJson(Map<String, dynamic> json) => RestaurantName(
    restaurantChainName: json["restaurantChainName"],
  );

  Map<String, dynamic> toJson() => {
    "restaurantChainName": restaurantChainName,
  };
}

