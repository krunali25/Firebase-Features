import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/video_model.dart';
import '../repository/video_repository.dart';

class VideoProvider extends ChangeNotifier {
  final VideoRepository _videoRepository = VideoRepository();
  bool isLoading = false;
  List<Video> _videos = [];

  List<Video> get videos => _videos;

  void changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> postAllVideo() async {
    changeLoading(true);
    try {
      Response response = await _videoRepository.postAllVideo();
      print("API Response: ${response.data}");

      // Ensure the response contains a list of videos
      List<dynamic> jsonData = response.data["medias"] ?? [];
      _videos = jsonData.map((item) => Video.fromJson(item)).toList();
    } catch (e) {
      print("Error fetching videos: $e");
      _videos = [];
    }
    changeLoading(false);
  }
}
