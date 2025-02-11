import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/job_provider.dart';
import '../../model/job_detail_model.dart';
import 'job_detail_screen.dart';

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  String? selectedCity; // Selected city for filtering

  // Manually defined city list
  final List<String> cityList = [
    "New York",
    "Los Angeles",
    "Chicago",
    "Seattle",
    "Boston",
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<JobProvider>(context, listen: false).getAllJob());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("Job Listings", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<JobProvider>(context, listen: false).getAllJob();
              setState(() {
                selectedCity = null;
                Provider.of<JobProvider>(context, listen: false).filterJobs(null);
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // City Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter by City:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: whiteColor),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: buttonBackground, // Background color for the dropdown button
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.pink, // Background color for the dropdown list
                      style: TextStyle(color: Colors.white, fontSize: 16), // Text color white
                      value: selectedCity,
                      hint: Text("Select a city", style: TextStyle(color: Colors.white)),
                      items: cityList
                          .map((city) => DropdownMenuItem(
                        value: city,
                        child: Text(city, style: TextStyle(color: Colors.white)), // Text color white
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                          Provider.of<JobProvider>(context, listen: false).filterJobs(value);
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),

          // Job List
          Expanded(
            child: Consumer<JobProvider>(
              builder: (context, jobProvider, child) {
                if (jobProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                List<JobDetail> jobs = jobProvider.filteredJobList;

                if (jobs.isEmpty) {
                  return Center(
                    child: Text(
                      "No jobs available",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final JobDetail job = jobs[index];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildJobRow(Icons.work, "Job Title", job.jobTitle ?? "No Title"),
                            _buildJobRow(Icons.location_on, "Location", job.jobLocation ?? "Not Specified"),
                            _buildJobRow(Icons.category, "Employment Type", job.jobEmploymentType ?? "Not Specified"),
                            _buildJobRow(Icons.calendar_today, "Posted At", job.jobPostedAt ?? "N/A"),
                            _buildJobRow(Icons.description, "Description", job.jobDescription ?? "No description available", maxLines: 3),
                            _buildJobRow(Icons.person, "Publisher", job.jobPublisher ?? "Unknown"),

                            SizedBox(height: 10),

                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetailScreen(job: job),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.arrow_forward),
                                label: Text("More Details"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonBackground,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }

  // Helper method for job detail rows
  Widget _buildJobRow(IconData icon, String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "$label: $value",
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
