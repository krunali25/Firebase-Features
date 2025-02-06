import 'package:firebase_features/provider/cake_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cake_detail_screen.dart';


class CakeScreen extends StatefulWidget {
  const CakeScreen({super.key});

  @override
  State<CakeScreen> createState() => _CakeScreenState();
}

class _CakeScreenState extends State<CakeScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCakeStore(context).getAllCake("defaultCakeId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CakeProvider>(builder: (context, cakeStore, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10, // Space between columns
              mainAxisSpacing: 10, // Space between rows
              childAspectRatio: 3 / 4, // Aspect ratio of each item
            ),
            itemCount: cakeStore.cakeList.length,
            itemBuilder: (context, index) {
              final item = cakeStore.cakeList[index];
              return  GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CakeDetailScreen(cakeId: item.id!)));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        // Image
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10),bottom: Radius.circular(10)),
                          child: Image.network(
                            item.image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text(
                              item.title!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),)
              );
            },
          ),
        );
      }),
    );
  }
}