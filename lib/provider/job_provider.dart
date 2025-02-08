import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/job_detail_model.dart';
import '../repository/job_repository.dart';

JobProvider getJobStore(BuildContext context) {
  return Provider.of<JobProvider>(context, listen: false);
}

class JobProvider extends ChangeNotifier {
  final JobRepository jobRepository = JobRepository();
  bool isLoading = false;
  JobDetail? jobDetail;
  List<JobDetail> jobList = [];
  List<JobDetail> filteredJobList = [];
  String? selectedCity;

  changeLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  getAllJob() async {
    changeLoading(true);
    Response response = await jobRepository.getAllJob();
    List<JobDetail> tmpList = [];
    print("response.data['data'] : ${response.data['data']}");

    response.data['data'].forEach((element) {
      tmpList.add(JobDetail.fromJson(element));
    });

    jobList = tmpList;
    filteredJobList = List.from(jobList); // Initially, show all jobs

    notifyListeners();
    print("jobList : ${jobList.length}");
    changeLoading(false);
  }

  void filterJobs(String? city) {
    selectedCity = city;
    if (city == null) {
      filteredJobList = List.from(jobList);
    } else {
      filteredJobList = jobList.where((job) => job.jobLocation == city).toList();
    }
    notifyListeners();
  }
}
