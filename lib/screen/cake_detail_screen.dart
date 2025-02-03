import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cake_provider.dart';

class CakeDetailScreen extends StatefulWidget {
  final String cakeId;

  const CakeDetailScreen({required this.cakeId});

  @override
  State<CakeDetailScreen> createState() => _CakeDetailScreenState();
}

class _CakeDetailScreenState extends State<CakeDetailScreen> {
  @override
  void initState() {
    final cakeProvider = Provider.of<CakeProvider>(context, listen: false);
    if (cakeProvider.selectedCake == null) {
      cakeProvider.getCakeDescription(widget.cakeId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CakeProvider>(builder: (context, cakeStore, child) {
        if (cakeStore.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (cakeStore.selectedCake == null) {
          return Center(child: Text("No cake details found"));
        }

        final item = cakeStore.selectedCake!;
        print('item.ingredients? ${item.ingredients}');
        List<String> methodList =  [];

        for (var element in item.method) {
          methodList.add(element.values.toString().replaceAll("(", "").replaceAll(")", ""));
        }
        print('item.method? ${item.method}');


        return Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: Image.network(
                    item.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 100), // To ensure spacing when scrolling
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 330),
              child: SingleChildScrollView(
                // Added scroll view for small devices
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cake title and details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.title ?? "No Title",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: Fonts.pBold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 24),
                              SizedBox(width: 5),
                              Text(
                                "4.5",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Dimens.height_10),
                      _buildDetailRow(
                          AppImages.difficultyIcon, item.difficulty ?? ''),
                      SizedBox(height: Dimens.height_10),
                      _buildDetailRow(
                          AppImages.portionIcon, item.portion ?? ''),
                      SizedBox(height: Dimens.height_10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(CupertinoIcons.time),
                          SizedBox(width: Dimens.width_10),
                          Expanded(
                            child: Text(
                              item.time ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: Fonts.pMedium,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.detailIcon,
                            width: 30,
                            height: 24,
                          ),
                          SizedBox(width: Dimens.width_10),
                          Expanded(
                            child: Text(
                              item.description ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: Fonts.pMedium,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      // Ingredients list
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.ingredientsIcon,
                            width: 30,
                            height: 24,
                          ),
                          SizedBox(width: Dimens.width_10),
                          Expanded(
                            child: Text(
                              item.ingredients?.join('\n') ??
                                  'No ingredients available',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: Fonts.pMedium,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                       Image.asset(
                        AppImages.detailIcon,
                        width: 30,
                        height: 24,
                      ),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Step : ${index + 1}) "),
                              Expanded(
                                child: Text(
                                  methodList[index],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: Dimens.height_5);
                        },
                        itemCount: methodList.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDetailRow(String assetPath, String text) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 30,
          height: 24,
        ),
        SizedBox(width: Dimens.width_10),
        Expanded(
          // Ensures text wraps if needed
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: Fonts.pMedium,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
