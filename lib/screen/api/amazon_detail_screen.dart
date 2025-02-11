import 'package:firebase_features/helper/app_assets.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:firebase_features/helper/dimens.dart';
import 'package:flutter/material.dart';

import '../../helper/image_slider.dart';
import '../../model/amazon_data_model.dart';

class AmazonDetailScreen extends StatefulWidget {
  final Product product;

  AmazonDetailScreen({required this.product});

  @override
  _AmazonDetailScreenState createState() => _AmazonDetailScreenState();
}

class _AmazonDetailScreenState extends State<AmazonDetailScreen> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Black Back Arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2E6CCA),
                Color(0xFF4FBCB9),
                Color(0xFF499DAC),
                Color(0xFF2E6CCA)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "Search or ask a question...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.black),
                            ),
                          ),
                        ),
                        Icon(Icons.camera_alt_outlined, color: Colors.black),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Icon(Icons.qr_code_scanner, color: Colors.black),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                          },
                          child: MouseRegion(
                            onEnter: (_) => setState(() => isHovered = true),
                            onExit: (_) => setState(() => isHovered = false),
                            child: Text(
                              StringConstants.visitBrand,
                              style: TextStyle(
                                fontSize: Dimens.fontSize_16,
                                fontFamily: Fonts.pSemibold,
                                color: ratingColor,
                                decoration: isHovered ? TextDecoration.underline : TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Row(
                              children: () {
                                double rating = double.tryParse(widget.product.productStarRating ?? "0") ?? 0;
                                int fullStars = rating.floor();
                                bool hasHalfStar = (rating - fullStars) >= 0.5;
                                int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

                                return [
                                  ...List.generate(fullStars, (index) => Icon(Icons.star, color: Colors.orange, size: 18)),
                                  if (hasHalfStar) Icon(Icons.star_half, color: Colors.orange, size: 18),
                                  ...List.generate(emptyStars, (index) => Icon(Icons.star_border, color: Colors.grey, size: 18)),
                                ];
                              }(),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${widget.product.productNumRatings ?? '0'}",
                              style: TextStyle( fontSize: Dimens.fontSize_15,fontFamily: Fonts.pSemibold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.product.productTitle ?? '',
                      style: TextStyle(fontSize: Dimens.fontSize_18, fontFamily: Fonts.pSemibold,color: numberRatingColor),
                    ),
                    Center(
                      child: ProductImageSlider(
                        imageUrls: [
                          widget.product.productPhoto ?? '',
                          "https://m.media-amazon.com/images/I/61W0Ucal3hL._SY741_.jpg",
                          "https://m.media-amazon.com/images/I/51j8-zllAhL._SY741_.jpg",
                          'https://m.media-amazon.com/images/I/61gzKcW79nL._SY741_.jpg',
                          'https://m.media-amazon.com/images/I/81rlLrgobLL._SY741_.jpg',
                          // Add more images dynamically
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.product.productPrice ?? 'N/A'}",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "₹${widget.product.productOriginalPrice ?? ''}",
                          style: TextStyle(fontSize: 16, color: Colors.red, decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "prime",
                          style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      widget.product.salesVolume ?? '+ bought in past month',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    SizedBox(height: 12),
                    if (widget.product.couponText != null)
                      Text(
                        "🔖 ${widget.product.couponText!}",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🚚 Free Delivery on eligible orders", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("🔄 Easy Returns Available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () {},
                    child: Text("Buy Now", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () {},
                    child: Text("Add to Cart", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
