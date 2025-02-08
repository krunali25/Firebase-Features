
import 'package:dio/dio.dart';
import '../network/endPoint.dart';

class VideoRepository {
  Future<Response> getAllVideo() async {
    Response response = await Dio().post(videoUrl, options: Options(headers: {'x-rapidapi-host': 'snap-video3.p.rapidapi.com', 'x-rapidapi-key': 'b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c'}));
    return response;
  }
}

