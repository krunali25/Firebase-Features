import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/restaurant_detail_model.dart';
import '../model/restaurant_name_model.dart';
import '../repository/restaurant_repository.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository = RestaurantRepository();
  bool isLoading = false;

  List<RestaurantName> restaurantList = [];
  RestaurantDescription? selectedRestaurantDetails; // Ensure this matches the UI logic

  void changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  // Fetch all restaurant names
  Future<void> getAllRestaurant() async {
    try {
      changeLoading(true);
      Response response = await restaurantRepository.getAllRestaurant();

      if (response.statusCode == 200) {
        List<RestaurantName> tmpList = [];
        for (var element in response.data) {
          tmpList.add(RestaurantName.fromJson(element));
        }
        restaurantList = tmpList;
        notifyListeners();
      } else {
        print("Failed to fetch restaurants. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching restaurants: $error");
    } finally {
      changeLoading(false);
    }
  }

  Future<void> getRestaurantDetails(String restaurantName) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await restaurantRepository.getRestaurantDetails(restaurantName);
      print('API Response: ${response.data}');
      selectedRestaurantDetails = restaurantDescriptionFromJson(response.data);
    } catch (e) {
      print('Error fetching details: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
