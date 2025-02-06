import 'package:firebase_features/model/job_detail_model.dart';
import 'package:firebase_features/repository/job_repository.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class JobProvider extends ChangeNotifier {
  final JobRepository jobRepository = JobRepository();
  bool _isLoading = false;
  JobDetail? _jobDetail;

  bool get isLoading => _isLoading;
  JobDetail? get jobDetail => _jobDetail;

  void changeLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> getAllJob() async {
    try {
      changeLoading(true);

      Response response = await jobRepository.getAllJob();
      print('Response Data: ${response.data}');

      // Check for successful response
      if (response.statusCode == 200) {
        List<Datum> tmpList = [];

        // Ensure the "data" key exists and contains a list
        if (response.data["data"] != null && response.data["data"] is List) {
          for (var element in response.data["data"]) {
            tmpList.add(Datum.fromJson(element));
          }
        } else {
          print("Error: 'data' field is missing or not an array.");
        }

        // Map the job details
        _jobDetail = JobDetail(
          status: response.data["status"],
          requestId: response.data["request_id"],
          parameters: Parameters.fromJson(response.data["parameters"]),
          data: tmpList,
        );

        notifyListeners();
      } else {
        print("Failed to fetch job. Status Code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching job: $error");
    } finally {
      changeLoading(false);
    }
  }

  List<Map<String, String>> get jobDetailsList {
    if (_jobDetail == null) return [];
    return _jobDetail!.data.map((datum) {
      return {
        'jobTitle': datum.jobTitle,
        'jobPublisher': datum.jobPublisher.toString(),
        'jobDescription': datum.jobDescription,
      };
    }).toList();
  }
}
