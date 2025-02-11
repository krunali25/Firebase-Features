import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/screen/api/amazon_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/helper/dimens.dart';

import '../../model/amazon_data_model.dart';
import '../../provider/amazon_data_provider.dart';

class AmazonProductScreen extends StatefulWidget {
  @override
  _AmazonProductScreenState createState() => _AmazonProductScreenState();
}

class _AmazonProductScreenState extends State<AmazonProductScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AmazonDataProvider>(context, listen: false).getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amazon Products"),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Consumer<AmazonDataProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              Product product = provider.products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmazonDetailScreen(product: product),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image
                        Container(
                          width: 100,
                          height: Dimens.height_150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(product.productPhoto ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productTitle ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: Fonts.pBold,
                                  fontSize: Dimens.fontSize_15,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Ratings Row
                              Row(
                                children: [
                                  Text(
                                    product.productStarRating ?? '',
                                    style: TextStyle(
                                      fontSize: Dimens.fontSize_15,
                                      fontFamily: Fonts.pSemibold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  if (product.productStarRating != null)
                                    Row(
                                      children: () {
                                        double rating = double.tryParse(product.productStarRating ?? "0") ?? 0;
                                        int fullStars = rating.floor();
                                        bool hasHalfStar = (rating - fullStars) >= 0.5;
                                        int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

                                        return [
                                          ...List.generate(fullStars, (index) => const Icon(Icons.star, color: Colors.orange, size: 16)),
                                          if (hasHalfStar) const Icon(Icons.star_half, color: Colors.orange, size: 16),
                                          ...List.generate(emptyStars, (index) => const Icon(Icons.star_border, color: Colors.grey, size: 16)),
                                        ];
                                      }(),
                                    ),

                                  const SizedBox(width: 2),
                                  Text(
                                    "(${product.productNumRatings ?? '0'})",
                                    style: TextStyle(
                                      fontSize: Dimens.fontSize_13,
                                      fontFamily:Fonts.pRegular,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Purchase info
                              Text(
                                product.salesVolume ?? '+ bought in past month',
                                style: TextStyle(
                                  fontSize: Dimens.fontSize_12,
                                  fontFamily: Fonts.pSemibold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Price Row
                              Row(
                                children: [
                                  Text(
                                    product.productPrice ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "M.R.P: ₹${product.productOriginalPrice ?? ''}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Coupon Text
                              Text(
                                product.couponText ?? "No Coupons Available",
                                style: TextStyle(
                                  color: product.couponText != null ? Colors.green : Colors.black,
                                  fontFamily: Fonts.pBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
