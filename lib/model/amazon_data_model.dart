// To parse this JSON data, do
//
//     final amazonData = amazonDataFromJson(jsonString);

import 'dart:convert';

AmazonData amazonDataFromJson(String str) => AmazonData.fromJson(json.decode(str));

String amazonDataToJson(AmazonData data) => json.encode(data.toJson());

class AmazonData {
  String status;
  String requestId;
  Parameters parameters;
  Data data;

  AmazonData({
    required this.status,
    required this.requestId,
    required this.parameters,
    required this.data,
  });

  factory AmazonData.fromJson(Map<String, dynamic> json) => AmazonData(
    status: json["status"],
    requestId: json["request_id"],
    parameters: Parameters.fromJson(json["parameters"]),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "request_id": requestId,
    "parameters": parameters.toJson(),
    "data": data.toJson(),
  };
}

class Data {
  int totalProducts;
  String country;
  String domain;
  List<Product> products;

  Data({
    required this.totalProducts,
    required this.country,
    required this.domain,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalProducts: json["total_products"],
    country: json["country"],
    domain: json["domain"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_products": totalProducts,
    "country": country,
    "domain": domain,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String? asin;
  String? productTitle;
  String? productPrice;
  String? productOriginalPrice;
  Currency? currency;
  String? productStarRating;
  int? productNumRatings;
  String? productUrl;
  String? productPhoto;
  int? productNumOffers;
  String? productMinimumOfferPrice;
  bool? isBestSeller;
  bool? isAmazonChoice;
  bool? isPrime;
  bool? climatePledgeFriendly;
  String? salesVolume;
  dynamic delivery;
  bool? hasVariations;
  ProductBadge? productBadge;
  String? couponText;

  Product({
    this.asin,
    this.productTitle,
    this.productPrice,
    this.productOriginalPrice,
    this.currency,
    this.productStarRating,
    this.productNumRatings,
    this.productUrl,
    this.productPhoto,
    this.productNumOffers,
    this.productMinimumOfferPrice,
    this.isBestSeller,
    this.isAmazonChoice,
    this.isPrime,
    this.climatePledgeFriendly,
    this.salesVolume,
    this.delivery,
    this.hasVariations,
    this.productBadge,
    this.couponText,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    asin: json["asin"],
    productTitle: json["product_title"],
    productPrice: json["product_price"],
    productOriginalPrice: json["product_original_price"],
    currency: json["currency"] != null ? currencyValues.map[json["currency"]] : null,
    productStarRating: json["product_star_rating"]?.toString(),
    productNumRatings: json["product_num_ratings"] ?? 0,
    productUrl: json["product_url"],
    productPhoto: json["product_photo"],
    productNumOffers: json["product_num_offers"],
    productMinimumOfferPrice: json["product_minimum_offer_price"],
    isBestSeller: json["is_best_seller"],
    isAmazonChoice: json["is_amazon_choice"],
    isPrime: json["is_prime"],
    climatePledgeFriendly: json["climate_pledge_friendly"],
    salesVolume: json["sales_volume"],
    delivery: json["delivery"], // Keep it as dynamic since it can be different formats
    hasVariations: json["has_variations"],
    productBadge: json["product_badge"] != null ? productBadgeValues.map[json["product_badge"]] : null, // Handle null
    couponText: json["coupon_text"],
  );

  Map<String, dynamic> toJson() => {
    "asin": asin,
    "product_title": productTitle,
    "product_price": productPrice,
    "product_original_price": productOriginalPrice,
    "currency": currency != null ? currencyValues.reverse[currency] : null,
    "product_star_rating": productStarRating,
    "product_num_ratings": productNumRatings,
    "product_url": productUrl,
    "product_photo": productPhoto,
    "product_num_offers": productNumOffers,
    "product_minimum_offer_price": productMinimumOfferPrice,
    "is_best_seller": isBestSeller,
    "is_amazon_choice": isAmazonChoice,
    "is_prime": isPrime,
    "climate_pledge_friendly": climatePledgeFriendly,
    "sales_volume": salesVolume,
    "delivery": delivery,
    "has_variations": hasVariations,
    "product_badge": productBadge != null ? productBadgeValues.reverse[productBadge] : null,
    "coupon_text": couponText,
  };
}

enum Currency {
  INR
}

final currencyValues = EnumValues({
  "INR": Currency.INR
});

enum ProductBadge {
  BEST_SELLER,
  LIMITED_TIME_DEAL
}

final productBadgeValues = EnumValues({
  "Best seller": ProductBadge.BEST_SELLER,
  "Limited time deal": ProductBadge.LIMITED_TIME_DEAL
});

class Parameters {
  String query;
  String categoryId;
  String country;
  String sortBy;
  int page;
  bool isPrime;

  Parameters({
    required this.query,
    required this.categoryId,
    required this.country,
    required this.sortBy,
    required this.page,
    required this.isPrime,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
    query: json["query"],
    categoryId: json["category_id"],
    country: json["country"],
    sortBy: json["sort_by"],
    page: json["page"],
    isPrime: json["is_prime"],
  );

  Map<String, dynamic> toJson() => {
    "query": query,
    "category_id": categoryId,
    "country": country,
    "sort_by": sortBy,
    "page": page,
    "is_prime": isPrime,
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
