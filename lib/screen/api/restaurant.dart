import 'package:firebase_features/helper/colors.dart';
import 'package:flutter/material.dart';import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../provider/restaurant_provider.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  String? _selectedRestaurant;

  void initState() {
    super.initState();
    Provider.of<RestaurantProvider>(context, listen: false).getAllRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurant List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<RestaurantProvider>(context, listen: false)
                  .getAllRestaurant();
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.selectedRestaurantDetails == null) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.restaurantList.isEmpty) {
            return Center(child: Text('No restaurants available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedRestaurant,
                  hint: Text('Select a restaurant'),
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  items: provider.restaurantList.map((restaurant) {
                    return DropdownMenuItem<String>(
                      value: restaurant.restaurantChainName,
                      child: Text(restaurant.restaurantChainName),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRestaurant = newValue;
                    });
                    if (newValue != null) {
                      provider.getRestaurantDetails(newValue);
                    }
                  },
                ),
                SizedBox(height: 20),

                if (provider.isLoading && provider.selectedRestaurantDetails != null)
                  Center(child: CircularProgressIndicator()),

                if (provider.selectedRestaurantDetails != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                      provider.selectedRestaurantDetails!.restaurants.length,
                      itemBuilder: (context, index) {
                        var detail =
                        provider.selectedRestaurantDetails!.restaurants[index];
                        print('Detail at index $index: ${detail.toJson()}');
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              detail.restaurantName ?? 'No Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.home, size: 16, color: Colors.green),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        ' ${detail.address ?? 'N/A'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, size: 16, color: Colors.blue),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text('${detail.cityName ?? 'N/A'}',
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 16, color: Colors.blue),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '${detail.phone ?? 'N/A'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Icon(Icons.phone_android_sharp, size: 16, color: Colors.blue),
                                    SizedBox(width: 5),
                                    Expanded(child:Text(
                                      '${detail.zipCode ?? 'N/A'}',
                                      style: TextStyle(fontSize: 14),
                                    ), )

                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, size: 16, color: Colors.orange),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '${detail.hoursInterval ?? 'N/A'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Icon(Icons.restaurant_menu_rounded, size: 16, color: Colors.orange),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '${detail.cuisineType ?? 'N/A'}',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.web, size: 16, color: Colors.purple),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '${detail.website ?? 'N/A'}',
                                        style: TextStyle(fontSize: 14),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
