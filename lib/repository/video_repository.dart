import 'package:dio/dio.dart';

import '../network/endpoint.dart';

class VideoRepository {
  postAllVideo() async {
    var formData = FormData.fromMap({
      'url': 'https://www.tiktok.com/@adminkhaofficial/video/7237435441719299334',
    });
    Response response = await Dio().post(
      videoUrl, data: formData, options: Options(
      headers: {
        "x-rapidapi-host": "snap-video3.p.rapidapi.com",
        "x-rapidapi-key": "b32ca5428bmsh2cd4b61c67483f5p158e14jsna8d16851ce5c",
      },
    ),);
    return response;
  }
}