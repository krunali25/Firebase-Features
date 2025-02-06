// To parse this JSON data, do
//
//     final jobDetail = jobDetailFromJson(jsonString);

import 'dart:convert';

JobDetail jobDetailFromJson(String str) => JobDetail.fromJson(json.decode(str));

String jobDetailToJson(JobDetail data) => json.encode(data.toJson());

class JobDetail {
  String status;
  String requestId;
  Parameters parameters;
  List<Datum> data;

  JobDetail({
    required this.status,
    required this.requestId,
    required this.parameters,
    required this.data,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
    status: json["status"],
    requestId: json["request_id"],
    parameters: Parameters.fromJson(json["parameters"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "request_id": requestId,
    "parameters": parameters.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String jobId;
  String jobTitle;
  String employerName;
  String? employerLogo;
  String? employerWebsite;
  JobPublisher jobPublisher;
  PurpleJobEmploymentType jobEmploymentType;
  List<JobEmploymentTypeElement> jobEmploymentTypes;
  String jobApplyLink;
  bool jobApplyIsDirect;
  List<ApplyOption> applyOptions;
  String jobDescription;
  bool jobIsRemote;
  String? jobPostedAt;
  int? jobPostedAtTimestamp;
  DateTime? jobPostedAtDatetimeUtc;
  JobLocation jobLocation;
  JobCity jobCity;
  JobState jobState;
  JobCountry jobCountry;
  double jobLatitude;
  double jobLongitude;
  List<String>? jobBenefits;
  String jobGoogleLink;
  dynamic jobSalary;
  int? jobMinSalary;
  int? jobMaxSalary;
  String? jobSalaryPeriod;
  JobHighlights jobHighlights;
  String jobOnetSoc;
  String jobOnetJobZone;

  Datum({
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
    this.jobSalary,
    required this.jobMinSalary,
    required this.jobMaxSalary,
    required this.jobSalaryPeriod,
    required this.jobHighlights,
    required this.jobOnetSoc,
    required this.jobOnetJobZone,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    jobId: json["job_id"],
    jobTitle: json["job_title"],
    employerName: json["employer_name"],
    employerLogo: json["employer_logo"],
    employerWebsite: json["employer_website"],
    jobPublisher: jobPublisherValues.map[json["job_publisher"]]!,
    jobEmploymentType: purpleJobEmploymentTypeValues.map[json["job_employment_type"]]!,
    jobEmploymentTypes: List<JobEmploymentTypeElement>.from(json["job_employment_types"].map((x) => jobEmploymentTypeElementValues.map[x]!)),
    jobApplyLink: json["job_apply_link"],
    jobApplyIsDirect: json["job_apply_is_direct"],
    applyOptions: List<ApplyOption>.from(json["apply_options"].map((x) => ApplyOption.fromJson(x))),
    jobDescription: json["job_description"],
    jobIsRemote: json["job_is_remote"],
    jobPostedAt: json["job_posted_at"],
    jobPostedAtTimestamp: json["job_posted_at_timestamp"],
    jobPostedAtDatetimeUtc: json["job_posted_at_datetime_utc"] == null ? null : DateTime.parse(json["job_posted_at_datetime_utc"]),
    jobLocation: jobLocationValues.map[json["job_location"]]!,
    jobCity: jobCityValues.map[json["job_city"]]!,
    jobState: jobStateValues.map[json["job_state"]]!,
    jobCountry: jobCountryValues.map[json["job_country"]]!,
    jobLatitude: json["job_latitude"]?.toDouble(),
    jobLongitude: json["job_longitude"]?.toDouble(),
    jobBenefits: json["job_benefits"] == null ? [] : List<String>.from(json["job_benefits"]!.map((x) => x)),
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
    "job_publisher": jobPublisherValues.reverse[jobPublisher],
    "job_employment_type": purpleJobEmploymentTypeValues.reverse[jobEmploymentType],
    "job_employment_types": List<dynamic>.from(jobEmploymentTypes.map((x) => jobEmploymentTypeElementValues.reverse[x])),
    "job_apply_link": jobApplyLink,
    "job_apply_is_direct": jobApplyIsDirect,
    "apply_options": List<dynamic>.from(applyOptions.map((x) => x.toJson())),
    "job_description": jobDescription,
    "job_is_remote": jobIsRemote,
    "job_posted_at": jobPostedAt,
    "job_posted_at_timestamp": jobPostedAtTimestamp,
    "job_posted_at_datetime_utc": jobPostedAtDatetimeUtc?.toIso8601String(),
    "job_location": jobLocationValues.reverse[jobLocation],
    "job_city": jobCityValues.reverse[jobCity],
    "job_state": jobStateValues.reverse[jobState],
    "job_country": jobCountryValues.reverse[jobCountry],
    "job_latitude": jobLatitude,
    "job_longitude": jobLongitude,
    "job_benefits": jobBenefits == null ? [] : List<dynamic>.from(jobBenefits!.map((x) => x)),
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

enum JobCity {
  CHICAGO
}

final jobCityValues = EnumValues({
  "Chicago": JobCity.CHICAGO
});

enum JobCountry {
  US
}

final jobCountryValues = EnumValues({
  "US": JobCountry.US
});

enum PurpleJobEmploymentType {
  CONTRACTOR,
  FULL_TIME
}

final purpleJobEmploymentTypeValues = EnumValues({
  "Contractor": PurpleJobEmploymentType.CONTRACTOR,
  "Full-time": PurpleJobEmploymentType.FULL_TIME
});

enum JobEmploymentTypeElement {
  CONTRACTOR,
  FULLTIME
}

final jobEmploymentTypeElementValues = EnumValues({
  "CONTRACTOR": JobEmploymentTypeElement.CONTRACTOR,
  "FULLTIME": JobEmploymentTypeElement.FULLTIME
});

class JobHighlights {
  List<String> qualifications;
  List<String>? responsibilities;
  List<String>? benefits;

  JobHighlights({
    required this.qualifications,
    this.responsibilities,
    this.benefits,
  });

  factory JobHighlights.fromJson(Map<String, dynamic> json) => JobHighlights(
    qualifications: List<String>.from(json["Qualifications"].map((x) => x)),
    responsibilities: json["Responsibilities"] == null ? [] : List<String>.from(json["Responsibilities"]!.map((x) => x)),
    benefits: json["Benefits"] == null ? [] : List<String>.from(json["Benefits"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Qualifications": List<dynamic>.from(qualifications.map((x) => x)),
    "Responsibilities": responsibilities == null ? [] : List<dynamic>.from(responsibilities!.map((x) => x)),
    "Benefits": benefits == null ? [] : List<dynamic>.from(benefits!.map((x) => x)),
  };
}

enum JobLocation {
  CHICAGO_IL
}

final jobLocationValues = EnumValues({
  "Chicago, IL": JobLocation.CHICAGO_IL
});

enum JobPublisher {
  INDEED,
  LINKED_IN,
  UNITED_AIRLINES_JOBS
}

final jobPublisherValues = EnumValues({
  "Indeed": JobPublisher.INDEED,
  "LinkedIn": JobPublisher.LINKED_IN,
  "United Airlines Jobs": JobPublisher.UNITED_AIRLINES_JOBS
});

enum JobState {
  ILLINOIS
}

final jobStateValues = EnumValues({
  "Illinois": JobState.ILLINOIS
});

class Parameters {
  String query;
  int page;
  int numPages;
  String datePosted;
  String country;
  String language;

  Parameters({
    required this.query,
    required this.page,
    required this.numPages,
    required this.datePosted,
    required this.country,
    required this.language,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
    query: json["query"],
    page: json["page"],
    numPages: json["num_pages"],
    datePosted: json["date_posted"],
    country: json["country"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "query": query,
    "page": page,
    "num_pages": numPages,
    "date_posted": datePosted,
    "country": country,
    "language": language,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
