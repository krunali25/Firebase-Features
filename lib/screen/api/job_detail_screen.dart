import 'package:firebase_features/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/job_detail_model.dart';

class JobDetailScreen extends StatelessWidget {
  final JobDetail job;

  JobDetailScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Job Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Employer Logo
            if (job.employerLogo != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    job.employerLogo!,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.business, size: 80, color: Colors.grey),
                  ),
                ),
              ),
            SizedBox(height: 15),

            // Job Title
            Text(
              job.jobTitle ?? "No Title",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Job Details Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.business, "Company", job.employerName ?? "Unknown"),
                    _buildInfoRow(Icons.location_on, "Location", job.jobLocation ?? "Not Specified"),
                    _buildInfoRow(Icons.work, "Employment Type", job.jobEmploymentType ?? "Not Specified"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),

            // Job Description
            _buildSectionTitle("Job Description"),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  job.jobDescription ?? "No description available",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 15),

            // Qualifications
            _buildSectionTitle("Qualifications"),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: job.jobHighlights.qualifications.isNotEmpty
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: job.jobHighlights.qualifications
                      .map((q) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text("• $q", style: TextStyle(fontSize: 16)),
                  ))
                      .toList(),
                )
                    : Text("No specific qualifications listed", style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 20),

            // Apply Now Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (job.jobApplyLink != null) {
                    final url = job.jobApplyLink!;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Could not open application link")),
                      );
                    }
                  }
                },
                icon: Icon(Icons.open_in_browser),
                label: Text("Apply Now", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for info rows
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22),
          SizedBox(width: 10),
          Text(
            "$title: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }
}
