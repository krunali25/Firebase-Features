import 'package:flutter/material.dart';
import '../repository/market_news_repository.dart';

class NewsProvider extends ChangeNotifier {
  final MarketNewsRepository _newsRepository = MarketNewsRepository();
  bool isLoading = false;
  String? errorMessage;
  List<Map<String, dynamic>> news = []; // Store news list

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getNews() async {
    changeLoading(true);
    errorMessage = null;

    try {
      List<dynamic>? fetchedNews = await _newsRepository.postAllNews();
      if (fetchedNews != null) {
        news = fetchedNews
            .map((item) => {
          "title": item["attributes"]["title"] ?? "No Title",
          "publishOn": item["attributes"]["publishOn"] ?? "Unknown",
        })
            .toList();
      } else {
        errorMessage = "No news found.";
      }
    } catch (e) {
      errorMessage = "Failed to fetch news.";
    }

    changeLoading(false);
  }
}
