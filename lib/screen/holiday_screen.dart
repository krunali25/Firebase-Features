import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/colors.dart';
import '../provider/holiday_provider.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({super.key});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  String? _selectedCountry;

  @override
  void initState() {
    super.initState();
    Provider.of<HolidayProvider>(context, listen: false).getAllCountry();
  }

  String getFormattedDate(String dtStr) {
    var dt = DateTime.parse(dtStr);
    return "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Country List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<HolidayProvider>(context, listen: false)
                  .getAllCountry();
            },
          ),
        ],
      ),
      body: Consumer<HolidayProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.countryList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.countryList.isEmpty) {
            return Center(child: Text('No countries available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCountry,
                  hint: Text('Select a country'),
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  items: provider.countryList.map((country) {
                    return DropdownMenuItem<String>(
                      value: country.code,
                      child: Text(country.country),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCountry = newValue;
                    });

                    if (newValue != null) {
                      provider.getPublicHolidayDetail(newValue);
                    }
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: provider.publicHolidaysYearList.isNotEmpty
                      ? ListView.builder(
                    itemCount: provider.publicHolidaysYearList.length,
                    itemBuilder: (context, index) {
                      var holiday = provider.publicHolidaysYearList[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      holiday.name ?? 'No Name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                                        SizedBox(width: 5),
                                        Text(
                                          getFormattedDate(holiday.date.toString()),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 16, color: Colors.green),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            holiday.localName ?? 'N/A',
                                            style: TextStyle(fontSize: 14),
                                            softWrap: true,
                                            // maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : Center(child: Text("No holiday data available")),
                ),
                if (provider.isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
