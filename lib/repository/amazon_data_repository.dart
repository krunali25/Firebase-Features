import 'dart:convert'; // Import for JSON parsing
import 'package:dio/dio.dart';
import 'package:firebase_features/model/amazon_data_model.dart';
import 'package:firebase_features/network/endPoint.dart';

class AmazonDataRepository {
  Future<List<Product>?> getAllProduct() async {
    try {
      Response response = await Dio().get(
        amazonDataUrl,
        options: Options(headers: {
          'x-rapidapi-host': 'real-time-amazon-data.p.rapidapi.com',
          'x-rapidapi-key': 'ge6x4THN6lmshv1gxlfc8G6hBqflp1lbSzbjsnqhSNqdbwZ5xp',
        }),
      );

      print("API Response: ${response.data}"); // Debugging
      if (response.statusCode == 200 && response.data != null) {
        AmazonData amazonData = amazonDataFromJson(jsonEncode(response.data));
        return amazonData.data.products;
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    return null;
  }
}
