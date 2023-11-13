import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/productsModel.dart';
import 'package:eco_buy/screens/web_side/update_complete_screen.dart';
import 'package:flutter/material.dart';

class UpdateProductsScreen extends StatelessWidget {
  static const String id = 'update';
  const UpdateProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('UPDATE PRODUCTS SCREEN'),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('No Data Exist'),
                  );
                }
                final data = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey,
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushReplacementNamed(
                                //     context, UpdateCompleteScreen.id);
                              },
                              child: ListTile(
                                title: Text(
                                  data[index]['productName'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: Container(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return UpdateCompleteScreen(
                                                  id: data[index].id,
                                                  products: Products(
                                                    brand: data[index]["brand"],
                                                    category: data[index]
                                                        ["category"],
                                                    id: id,
                                                    productName: data[index]
                                                        ["productName"],
                                                    detail: data[index]
                                                        ["detail"],
                                                    price: data[index]["price"],
                                                    discountPrice: data[index]
                                                        ["discountPrice"],
                                                    serialCode: data[index]
                                                        ["serialCode"],
                                                    imageUrls: data[index]
                                                        ["imageUrls"],
                                                    isSale: data[index]
                                                        ["isOnSale"],
                                                    isPopular: data[index]
                                                        ["isPopular"],
                                                    isFavourite: data[index]
                                                        ["isFavourite"],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (_) {
                                          //       return const UpdateCompleteScreen();
                                          //     },
                                          //   ),
                                          // );
                                        },
                                        icon: const Icon(
                                          Icons.delete_forever_sharp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              })
        ],
      ),
    );
  }
}
