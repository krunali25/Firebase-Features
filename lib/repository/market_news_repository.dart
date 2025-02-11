import 'package:dio/dio.dart';
import 'package:firebase_features/network/endPoint.dart';

class MarketNewsRepository {
  Future<List<dynamic>?> postAllNews() async {
    try{
      Response response = await Dio().get(newsUrl, options: Options(headers: {
      'x-rapidapi-host': 'seeking-alpha.p.rapidapi.com',
      'x-rapidapi-key': 'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c',
    }));
    if (response.statusCode == 200 && response.data != null) {
      return response.data["data"]; // Extract "data" array
    }
  } catch (e) {
  print("Error fetching news: $e");
  }
  return null;
}
}