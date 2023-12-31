import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/categoryModel.dart';
import 'package:eco_buy/models/productsModel.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/category_home_boxex.dart';
import '../../widgets/home_cards.dart';
import '../product_detail_screen.dart';

/* List categories = [
  "GROCERY",
  "ELECTRONICES",
  "COSMETICS",
  "PHARMACY",
  "GARMENTS"
]; */

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List images = [
    "https://cdn.pixabay.com/photo/2017/03/28/12/11/chairs-2181960_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/04/20/06/46/office-730681_640.jpg",
    "https://cdn.pixabay.com/photo/2017/03/25/23/32/kitchen-2174593_640.jpg",
    "https://cdn.pixabay.com/photo/2017/09/09/18/25/living-room-2732939_640.jpg",
    "https://cdn.pixabay.com/photo/2017/03/19/01/18/living-room-2155353_640.jpg",
    "https://cdn.pixabay.com/photo/2016/09/02/22/36/kitchen-1640439_640.jpg"
  ];

  List<Products> allProducts = [];

  getDate() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        if (e.exists) {
          setState(() {
            allProducts.add(
              Products(
                brand: e["brand"],
                category: e["category"],
                id: e['id'],
                productName: e["productName"],
                detail: e["detail"],
                price: e["price"],
                discountPrice: e["discountPrice"],
                serialCode: e["serialCode"],
                imageUrls: e["imageUrls"],
                isSale: e["isOnSale"],
                isPopular: e["isPopular"],
                isFavourite: e["isFavourite"],
              ),
            );
          });
        }
      });
    });
    print(allProducts[0].discountPrice);
  }

  @override
  void initState() {
    getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 22.h,
              child: Column(
                children: [
                  Container(
                      child: RichText(
                          text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "ECO ",
                        style: TextStyle(
                          fontSize: 27,
                          color: Color.fromARGB(255, 23, 1, 94),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "FURNITURE",
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ))),
                  const CategoryHomeBoxes(),
                ],
              ),
            ),
            Container(
              height: 64.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    carousel(images: images),
                    Text(
                      "POPULAR ITEMS",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    allProducts.length == 0
                        ? CircularProgressIndicator()
                        : PopularItems(allProducts: allProducts),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 23, 1, 94)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    "HOT \n SALES",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 23, 1, 94),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    "NEW \n ARRIVALS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* Text(
                      "TOP BRANDS",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Brands(allProducts: allProducts), */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularItems extends StatelessWidget {
  const PopularItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.isPopular == true)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailScreen(
                                          id: e.id,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                e.imageUrls![0],
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Text(e.productName!)),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class Brands extends StatelessWidget {
  const Brands({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      constraints: BoxConstraints(
        minWidth: 50,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 90,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.primaries[Random().nextInt(15)],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              e.brand!,
                              style: EcoStyle.boldStyle.copyWith(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class carousel extends StatelessWidget {
  const carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl: e,
                          placeholder: (c, i) =>
                              Center(child: Image.asset(categories[0].image!)),
                          width: double.infinity,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          /* gradient: LinearGradient(colors: [
                              Colors.blueAccent.withOpacity(0.3),
                              Colors.redAccent.withOpacity(0.3),
                            ]) */
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          /* child: Text(
                            "TITLE",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ), */
                        ),
                      ),
                    )
                  ],
                ))
            .toList(),
        options: CarouselOptions(
          height: 140,
          autoPlay: true,
        ));
  }
}
