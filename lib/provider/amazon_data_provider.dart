import 'package:flutter/material.dart';
import '../model/amazon_data_model.dart';
import '../repository/amazon_data_repository.dart';


class AmazonDataProvider extends ChangeNotifier {
  final AmazonDataRepository amazonDataRepository = AmazonDataRepository();
  bool isLoading = false;
  String? errorMessage;
  List<Product> products = [];

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllProduct() async {
    _setLoading(true);
    errorMessage = null;

    try {
      final fetchedProducts = await amazonDataRepository.getAllProduct();
      if (fetchedProducts != null && fetchedProducts.isNotEmpty) {
        products = fetchedProducts;
      } else {
        errorMessage = "No products found.";
      }
    } catch (e) {
      errorMessage = "Failed to fetch products: $e";
    }
    print("dataList : ${products.length}");
    _setLoading(false);
  }
}

