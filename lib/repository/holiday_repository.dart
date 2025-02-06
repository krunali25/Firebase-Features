
import 'package:dio/dio.dart';
import '../network/endPoint.dart';

class HolidayRepository {
  Future<Response> getAllCountry() async {
    Response response = await Dio().get(holidayUrl, options: Options(headers: {'x-rapidapi-host': 'public-holidays7.p.rapidapi.com', 'x-rapidapi-key': 'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c'}));
    return response;
  }
  Future<Response?> getPublicHolidayDetail(String code) async{
    try{
      Response response = await Dio().get('https://public-holidays7.p.rapidapi.com/2023/$code',options:Options(headers:{'x-rapidapi-host':'public-holidays7.p.rapidapi.com','x-rapidapi-key':'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c'}));
      print("statuscode : ${response.statusCode}");
      return response;
    }catch(e){
      return null;
    }
  }

}