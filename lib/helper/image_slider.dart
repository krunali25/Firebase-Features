import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_features/helper/colors.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  ProductImageSlider({required this.imageUrls});

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0; // For tracking the current image index

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 350,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: widget.imageUrls.map((imageUrl) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(height: 8),

        // Indicator & Icons Row with Fixed Width
        Container(
          width: double.infinity,
          child: Row(
            children: [
              // Image Indicators (Centered)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(widget.imageUrls.length, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              Spacer(), // Pushes icons to the right

              // Like & Share Icons (Right Side)
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: blackColor),
                    onPressed: () {
                      // Like action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: blackColor),
                    onPressed: () {
                      // Share action
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
