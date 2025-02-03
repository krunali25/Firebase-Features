import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/cake_model.dart';
import '../repository/cake_repository.dart';

CakeProvider getCakeStore(BuildContext context) {
  return Provider.of<CakeProvider>(context, listen: false);
}
class CakeProvider extends ChangeNotifier {
  CakeRepository cakeRepository = CakeRepository();
  bool isLoading = false;

  List<Cake> cakeList = [];
  Cake? selectedCake; // To hold the selected cake details for description.

  changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  getAllCake(String cakeId) async {
    changeLoading(true);
    Response response = await cakeRepository.getAllCake();
    List<Cake> tmpList = [];
    print("response.data['results'] : ${response.data}");
    response.data.forEach((element) {
      tmpList.add(Cake.fromJson(element));
    });
    cakeList = tmpList;
    notifyListeners();
    print("cakeList : ${cakeList.length}");
    changeLoading(false);
  }

  getCakeDescription(String cakeId) async {
    changeLoading(true);
    Response response = await cakeRepository.getCakeDescription(cakeId);

    if (response.statusCode == 200) {
      selectedCake = Cake.fromJson(response.data);
      print(selectedCake!.toJson());
    } else {
      print("Failed to load description");
    }
    try {

    } catch (e) {
      print("Error fetching cake description: $e");
    }

    notifyListeners(); // Notify UI to update with new description
    changeLoading(false);
  }


}

