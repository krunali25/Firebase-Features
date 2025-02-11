import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/market_news_provider.dart';
import 'package:intl/intl.dart';

class MarketNewsScreen extends StatefulWidget {
  const MarketNewsScreen({super.key});

  @override
  State<MarketNewsScreen> createState() => _MarketNewsScreenState();
}

class _MarketNewsScreenState extends State<MarketNewsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NewsProvider>(context, listen: false).getNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Market News", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Text(
                provider.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (provider.news.isEmpty) {
            return const Center(child: Text("No news available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: provider.news.length,
            itemBuilder: (context, index) {
              final newsItem = provider.news[index];
              final String title = newsItem["title"] ?? "No Title";
              final String publishOn = newsItem["publishOn"] ?? "Unknown Date";
              final formattedDate = _formatDate(publishOn);
              final String? imageUrl = newsItem["image"] ?? null;

              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl != null) // Show image if available
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: Fonts.pBold,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Published On: $formattedDate",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: Fonts.pRegular
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat.yMMMMd().format(dateTime); // Example: February 10, 2025
    } catch (e) {
      return dateString; // Fallback if parsing fails
    }
  }
}
