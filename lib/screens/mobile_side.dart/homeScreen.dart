import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:eco_buy/widgets/home_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List categories = [
      "GROCERY",
      "PHARMACY",
      "COSMETICS",
      "ELECTRONICS",
      'GARMENTS',
    ];

    List images = [
      "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/23/15/03/medications-1853400_960_720.jpg",
      "https://cdn.pixabay.com/photo/2015/09/21/14/24/supermarket-949913_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/23/15/03/medications-1853400_960_720.jpg",
    ];
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () => FirebaseServices.signOut(),
            icon: Icon(Icons.logout))
      ]),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          const Center(
            child: Text(
              "HOMESCREEN",
              style: EcoStyle.kBoldStyle,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CarouselSlider(
              items: images
                  .map((e) => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  e,
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  Colors.blueAccent.withOpacity(0.3),
                                  Colors.redAccent.withOpacity(0.3)
                                ])),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "LABEL",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  )))
                        ],
                      ))
                  .toList(),
              options: CarouselOptions(height: 200, autoPlay: true)),
          HomeContainer(title: categories[0]),
          HomeContainer(title: categories[1]),
          HomeContainer(title: categories[2]),
          HomeContainer(title: categories[3]),
          HomeContainer(title: categories[4]),
        ]),
      )),
    );
  }
}
