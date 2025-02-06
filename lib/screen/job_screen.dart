import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/job_provider.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<JobProvider>(context, listen: false).getAllJob();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listings'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<JobProvider>(
        builder: (context, provider, child) {
          // Show loading indicator while fetching data
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.jobDetail == null) {
            return Center(child: Text('No job data available.'));
          }
          var jobDetails = provider.jobDetailsList;

          return ListView.builder(
            itemCount: jobDetails.length,
            itemBuilder: (context, index) {
              var job = jobDetails[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(job['jobTitle'] ?? 'No Title'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Publisher: ${job['jobPublisher']}'),
                      Text('Employer Name: ${job['employerWebsite']}'),
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
}

