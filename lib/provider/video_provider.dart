import 'package:dio/dio.dart';
import 'package:firebase_features/model/video_model.dart';
import 'package:firebase_features/repository/video_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/cake_model.dart';
import '../repository/cake_repository.dart';

VideoProvider getVideoStore(BuildContext context) {
  return Provider.of<VideoProvider>(context, listen: false);
}
class VideoProvider extends ChangeNotifier {
  VideoRepository videoRepository = VideoRepository();
  bool isLoading = false;

  List<Video> videoList = [];
  changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  getAllVideo() async {
    changeLoading(true);
    Response response = await videoRepository.getAllVideo();
    print("${response.data}");
    List<Video> tmpList = [];
    print("response.data : ${response.data}");
    response.data.forEach((element) {
      tmpList.add(Video.fromJson(element));
    });
    videoList = tmpList;
    notifyListeners();
    print("videoList : ${videoList.length}");
    changeLoading(false);
  }

}

