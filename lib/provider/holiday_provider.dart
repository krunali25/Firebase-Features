import 'package:firebase_features/model/country_name_model.dart';
import 'package:firebase_features/model/public_holiday_detail.dart';
import 'package:firebase_features/repository/holiday_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class HolidayProvider extends ChangeNotifier {
  final HolidayRepository holidayRepository = HolidayRepository();
  bool isLoading = false;

  List<CountryName> countryList = [];
  List<PublicHolidayDetail> publicHolidaysYearList =[];

  void changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }
  Future<void> getAllCountry() async {
    try {
      changeLoading(true);
      Response response = await holidayRepository.getAllCountry();

      if (response.statusCode == 200) {
        List<CountryName> tmpList = [];
        for (var element in response.data) {
          tmpList.add(CountryName.fromJson(element));
        }
        countryList = tmpList;
        notifyListeners();
      } else {
        print("Failed to fetch restaurants. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching restaurants: $error");
    } finally {
      changeLoading(false);
    }
  }
  getPublicHolidayDetail(String code) async {
    changeLoading(true);
    Response? response = await holidayRepository.getPublicHolidayDetail(code);
    print("API Response: ${response?.data}"); // Debugging response
    changeLoading(false);
    publicHolidaysYearList.clear();
    if(response == null){
      print("publicHolidaysYearList : ${publicHolidaysYearList.length}");
    }else{
      List<PublicHolidayDetail> tmpList = [];
      print("response.data : ${response.data}");
      response.data.forEach((element) {
        tmpList.add(PublicHolidayDetail.fromJson(element));
      });
      publicHolidaysYearList = tmpList;
      notifyListeners();
      print("publicHolidaysYearList : ${publicHolidaysYearList.length}");
    }
  }
}
