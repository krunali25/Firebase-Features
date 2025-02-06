
import 'package:dio/dio.dart';
import '../network/endPoint.dart';

class JobRepository {
  Future<Response> getAllJob() async {
    Response response = await Dio().get(jobUrl, options: Options(headers: {'x-rapidapi-host': 'jsearch.p.rapidapi.com', 'x-rapidapi-key': 'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c'}));
    return response;
  }

}