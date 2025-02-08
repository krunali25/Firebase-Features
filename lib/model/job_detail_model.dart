// To parse this JSON data, do
//
//     final jobDetail = jobDetailFromJson(jsonString);

import 'dart:convert';

JobDetail jobDetailFromJson(String str) => JobDetail.fromJson(json.decode(str));

String jobDetailToJson(JobDetail data) => json.encode(data.toJson());

class JobDetail {
  String? jobId;
  String? jobTitle;
  String? employerName;
  String? employerLogo;
  String? employerWebsite;
  String? jobPublisher;
  String? jobEmploymentType;
  List<String> jobEmploymentTypes;
  String? jobApplyLink;
  bool jobApplyIsDirect;
  List<ApplyOption> applyOptions;
  String? jobDescription;
  bool jobIsRemote;
  String? jobPostedAt;
  int? jobPostedAtTimestamp;
  DateTime? jobPostedAtDatetimeUtc;
  String? jobLocation;
  String? jobCity;
  String? jobState;
  String? jobCountry;
  double jobLatitude;
  double jobLongitude;
  dynamic jobBenefits;
  String? jobGoogleLink;
  dynamic jobSalary;
  dynamic jobMinSalary;
  dynamic jobMaxSalary;
  dynamic jobSalaryPeriod;
  JobHighlights jobHighlights;
  String? jobOnetSoc;
  String? jobOnetJobZone;

  JobDetail({
    required this.jobId,
    required this.jobTitle,
    required this.employerName,
    required this.employerLogo,
    required this.employerWebsite,
    required this.jobPublisher,
    required this.jobEmploymentType,
    required this.jobEmploymentTypes,
    required this.jobApplyLink,
    required this.jobApplyIsDirect,
    required this.applyOptions,
    required this.jobDescription,
    required this.jobIsRemote,
    required this.jobPostedAt,
    required this.jobPostedAtTimestamp,
    required this.jobPostedAtDatetimeUtc,
    required this.jobLocation,
    required this.jobCity,
    required this.jobState,
    required this.jobCountry,
    required this.jobLatitude,
    required this.jobLongitude,
    required this.jobBenefits,
    required this.jobGoogleLink,
    required this.jobSalary,
    required this.jobMinSalary,
    required this.jobMaxSalary,
    required this.jobSalaryPeriod,
    required this.jobHighlights,
    required this.jobOnetSoc,
    required this.jobOnetJobZone,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    jobId: json["job_id"],
    jobTitle: json["job_title"],
    employerName: json["employer_name"],
    employerLogo: json["employer_logo"],
    employerWebsite: json["employer_website"],
    jobPublisher: json["job_publisher"],
    jobEmploymentType: json["job_employment_type"],
    jobEmploymentTypes: List<String>.from(json["job_employment_types"].map((x) => x)),
    jobApplyLink: json["job_apply_link"],
    jobApplyIsDirect: json["job_apply_is_direct"],
    applyOptions: List<ApplyOption>.from(json["apply_options"].map((x) => ApplyOption.fromJson(x))),
    jobDescription: json["job_description"],
    jobIsRemote: json["job_is_remote"],
    jobPostedAt: json["job_posted_at"],
    jobPostedAtTimestamp: json["job_posted_at_timestamp"],
    jobPostedAtDatetimeUtc:json["job_posted_at_datetime_utc"]==null?null: DateTime.parse(json["job_posted_at_datetime_utc"]),
    jobLocation: json["job_location"],
    jobCity: json["job_city"],
    jobState: json["job_state"],
    jobCountry: json["job_country"],
    jobLatitude: json["job_latitude"]?.toDouble(),
    jobLongitude: json["job_longitude"]?.toDouble(),
    jobBenefits: json["job_benefits"],
    jobGoogleLink: json["job_google_link"],
    jobSalary: json["job_salary"],
    jobMinSalary: json["job_min_salary"],
    jobMaxSalary: json["job_max_salary"],
    jobSalaryPeriod: json["job_salary_period"],
    jobHighlights: JobHighlights.fromJson(json["job_highlights"]),
    jobOnetSoc: json["job_onet_soc"],
    jobOnetJobZone: json["job_onet_job_zone"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "job_title": jobTitle,
    "employer_name": employerName,
    "employer_logo": employerLogo,
    "employer_website": employerWebsite,
    "job_publisher": jobPublisher,
    "job_employment_type": jobEmploymentType,
    "job_employment_types": List<dynamic>.from(jobEmploymentTypes.map((x) => x)),
    "job_apply_link": jobApplyLink,
    "job_apply_is_direct": jobApplyIsDirect,
    "apply_options": List<dynamic>.from(applyOptions.map((x) => x.toJson())),
    "job_description": jobDescription,
    "job_is_remote": jobIsRemote,
    "job_posted_at": jobPostedAt,
    "job_posted_at_timestamp": jobPostedAtTimestamp,
    "job_posted_at_datetime_utc": jobPostedAtDatetimeUtc!.toIso8601String(),
    "job_location": jobLocation,
    "job_city": jobCity,
    "job_state": jobState,
    "job_country": jobCountry,
    "job_latitude": jobLatitude,
    "job_longitude": jobLongitude,
    "job_benefits": jobBenefits,
    "job_google_link": jobGoogleLink,
    "job_salary": jobSalary,
    "job_min_salary": jobMinSalary,
    "job_max_salary": jobMaxSalary,
    "job_salary_period": jobSalaryPeriod,
    "job_highlights": jobHighlights.toJson(),
    "job_onet_soc": jobOnetSoc,
    "job_onet_job_zone": jobOnetJobZone,
  };
}

class ApplyOption {
  String publisher;
  String applyLink;
  bool isDirect;

  ApplyOption({
    required this.publisher,
    required this.applyLink,
    required this.isDirect,
  });

  factory ApplyOption.fromJson(Map<String, dynamic> json) => ApplyOption(
    publisher: json["publisher"],
    applyLink: json["apply_link"],
    isDirect: json["is_direct"],
  );

  Map<String, dynamic> toJson() => {
    "publisher": publisher,
    "apply_link": applyLink,
    "is_direct": isDirect,
  };
}

class JobHighlights {
  List<String> qualifications;

  JobHighlights({
    required this.qualifications,
  });

  factory JobHighlights.fromJson(Map<String, dynamic> json) => JobHighlights(
    qualifications:json["Qualifications"] == null ?[] : List<String>.from(json["Qualifications"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Qualifications": List<dynamic>.from(qualifications.map((x) => x)),
  };
}
