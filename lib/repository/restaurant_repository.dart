
import 'package:dio/dio.dart';
import '../network/endPoint.dart';

class RestaurantRepository {
  Future<Response> getAllRestaurant() async {
    Response response = await Dio().get(restaurantUrl, options: Options(headers: {'x-rapidapi-host': 'fast-food-restaurants-usa-top-50-chains.p.rapidapi.com', 'x-rapidapi-key': 'ge6x4THN6lmshv1gxlfc8G6hBqflp1lbSzbjsnqhSNqdbwZ5xp','Cookie': 'PHPSESSID=co4cq1q88mdtsh5g1mleruku5a'}));
    return response;
  }

  Future<Response> getRestaurantDetails(String restaurantName) async {
    return await Dio().get(
      'https://fast-food-restaurants-usa-top-50-chains.p.rapidapi.com/restaurants-top/$restaurantName/location/0',
      options: Options(headers: {'x-rapidapi-host': 'fast-food-restaurants-usa-top-50-chains.p.rapidapi.com', 'x-rapidapi-key': 'ge6x4THN6lmshv1gxlfc8G6hBqflp1lbSzbjsnqhSNqdbwZ5xp','Cookie': 'PHPSESSID=co4cq1q88mdtsh5g1mleruku5a'}));
  }
}