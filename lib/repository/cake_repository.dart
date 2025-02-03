
import 'package:dio/dio.dart';
import '../network/endPoint.dart';

class CakeRepository {
  Future<Response> getAllCake() async {
    Response response = await Dio().get(cakeUrl, options: Options(headers: {'x-rapidapi-host': 'the-birthday-cake-db.p.rapidapi.com', 'x-rapidapi-key': 'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c'}));
    return response;
  }
  Future<Response> getCakeDescription(String cakeId) async {
    try {
      final String url = 'https://the-birthday-cake-db.p.rapidapi.com/$cakeId';
      final response = await Dio().get(url, options: Options(
          headers: {
            'X-RapidAPI-Key': 'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c',
            'X-RapidAPI-Host': 'the-birthday-cake-db.p.rapidapi.com'
          }
      ));
      return response;
    } catch (e) {
      throw Exception("Error fetching cake description: $e");
    }
  }
}